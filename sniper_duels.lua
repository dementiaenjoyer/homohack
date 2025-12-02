-- Services
local Service = setmetatable({ }, { __index = function(Self, Index)
    return cloneref(game.GetService(game, Index));
end })

local ReplicatedStorage = Service.ReplicatedStorage;
local RunService = Service.RunService;
local Workspace = Service.Workspace;
local Players = Service.Players;

-- Modules
local Modules = { }; do
    local Descendants = ReplicatedStorage:GetDescendants();
    Modules.Packed = { };

    function Modules:GetScript(ModuleName)
        return self.Packed[ModuleName];
    end

    function Modules:Require(Name)
        return require(self:GetScript(Name));
    end

    function Modules:Pack()
        for _, Descendant in Descendants do
            if (Descendant.ClassName ~= "ModuleScript") then
                continue;
            end

            local FullName = Descendant:GetFullName();
            FullName = string.gsub(FullName, "^ReplicatedStorage%.", "");
            FullName = `{string.gsub(FullName, "%.", "/")}.lua`;

            self.Packed[FullName] = Descendant;
        end
    end

    Modules:Pack();
end

local Objects = { }; do
    function Objects:Get(Ancestor, Name, Class, Identifier)
        for _, Descendant in Ancestor:GetDescendants() do
            if (Descendant.Name ~= Name) or (Descendant.ClassName ~= Class) then
                continue;
            end

            if (Identifier or function() return true end)(Descendant) then
                return Descendant;
            end
        end
    end
end

local CrosshairController = Modules:Require("Modules/Controllers/CrosshairController.lua");
local CameraController = Modules:Require("Modules/Controllers/CameraController.lua");
local ToolController = Modules:Require("Modules/Controllers/ToolController.lua");
local Effects = Modules:Require("Modules/Controllers/Effects.lua");

-- Variables
local ReplicatorToClient = Objects:Get(ReplicatedStorage, "ToClient", "UnreliableRemoteEvent");
local Remotes = Objects:Get(ReplicatedStorage, "Remotes", "Folder", function(Descendant)
    return tostring(Descendant.Parent) ~= "BetterReplication";
end)

local WeaponEvents = Objects:Get(Remotes, "Weapons", "Folder");
local GunEvents = Objects:Get(WeaponEvents, "Gun", "Folder");
local MatchEvents = Objects:Get(Remotes, "Match", "Folder");

local Camera = Workspace.CurrentCamera;
local LocalPlayer = Players.LocalPlayer;

-- Imports
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/refs/heads/main/ud_linoria/new_font.lua"))();

-- Cache
local Params = RaycastParams.new();
local NaN = 0 / 0;

local Vector3New = Vector3.new;
local Vector3NaN = Vector3New(NaN, NaN, NaN);

local TaskDelay = task.delay;

local StringGSub = string.gsub;
local StringFind = string.find;

local TableUnpack = table.unpack;
local TableClone = table.clone;
local TableFind = table.find;

local MathAbs = math.abs;

-- Classes
local ReplicationObject = { }; do
    function ReplicationObject:GetCharacter()
        local CharacterObject = self.Character;

        if (not CharacterObject) then
            return;
        end

        return (function()
            local Character = { };

            for Index, Value in CharacterObject:GetChildren() do
                Character[Value.Name] = Value;
            end

            return Character;
        end)( ) or { }, CharacterObject;
    end

    function ReplicationObject:Hitscan(Origin, Ignorelist)
        local Position, ReplicationCharacter, Character = self:GetPosition();

        if (not Character) then
            return;
        end

        local Direction = (Position - Origin);
        Params.FilterDescendantsInstances = Ignorelist;

        local Hitscan = Workspace:Raycast(Origin, Direction.Unit * 200, Params);
        local HitObject = Hitscan and Hitscan.Instance;

        if (not HitObject) then
            return;
        end

        return HitObject:IsDescendantOf(Character), ReplicationCharacter, Hitscan.Position;
    end

    function ReplicationObject:GetPosition()
        local ReplicationCharacter, CharacterObject = self:GetCharacter();

        return self.Position, ReplicationCharacter, CharacterObject;
    end

    ReplicationObject = setmetatable(ReplicationObject, { __call = function(Self, Character, CoordinateFrame)
        local Clone = TableClone(ReplicationObject);
        Clone.Character = Character;
        Clone.Position = CoordinateFrame.Position;

        return Clone;
    end})
end

-- Functions
local Utility = { Match = false }; do
    local Replicators = debug.getupvalue(getconnections(ReplicatorToClient.OnClientEvent)[1].Function, 13);
    local MatchData = debug.getupvalue(getconnections(MatchEvents.NewMatch.OnClientEvent)[1].Function, 1);

    function Utility:GetPlayers()
        local PlayerObjects = { };

        if (MatchData.CurrentMatch) then
            for Player, CoordinateFrame in Replicators do
                if (MatchData:IsPlayerFriendly(Player)) then
                    continue;
                end

                local Character = Player.Character;

                if (not Character) then
                    continue;
                end

                local Humanoid = Character:FindFirstChildOfClass("Humanoid");

                if (not Humanoid) or Humanoid.Health <= 0 then
                    continue;
                end

                PlayerObjects[Player.Name] = ReplicationObject(Character, CoordinateFrame);
            end
        end

        return PlayerObjects;
    end
end

local Bullet = { }; do
    local Directions = {
        Vector3New(0, 0, -1),
        Vector3New(-1, 0, 0),
        Vector3New(0, -1, 0),

        Vector3New(1, 0, 0),
        Vector3New(0, 1, 0),
        Vector3New(0, 0, 1),
    };

    function Bullet:Scan(Origin, Range)
        for Index = 1, #Directions do
            local Direction = Directions[Index];
            local WallCast = Workspace:Raycast(Origin, Direction * Range, Params);

            if (WallCast) then
                continue;
            end

            local ShiftedOrigin = Origin + (Direction * Range);
            local FavoritePlayer = self:GetFavorite(ShiftedOrigin);

            if (not FavoritePlayer) then
                continue;
            end

            return ShiftedOrigin, FavoritePlayer;
        end
    end

    function Bullet:GetFavorite(Origin)
        local Closest, MaxDistance = nil, 400;
        local IgnoreList = Utility.IgnoreList;

        for _, Player in Utility:GetPlayers() do
            local Position, ReplicationCharacter, Character = Player:GetPosition();

            if (not Position) then
                continue;
            end

            local Distance = (Position - Origin).Magnitude;
            local CanHit = UIFlags["Combat/Ragebot/Wallbang"] or Player:Hitscan(Origin, IgnoreList)

            if (not CanHit) then
                continue;
            end

            if (Distance <= MaxDistance) then
                Closest = { Character, ReplicationCharacter, Position };
                MaxDistance = Distance;
            end
        end

        return Closest;
    end
end

local Weapon = { Reloading = nil, Connection = nil }; do
    local Map = { [1] = "Primary", [2] = "Melee" };
    local Aliases = { ["Head"] = "FakeHead" };
    Weapon.Objects = { ["Primary"] = nil, ["Melee"] = nil };

    function Weapon:FireBullet(Origin, Destination, Character, Config, Tool, HitPart)
        local Humanoid = Character and Character.Humanoid;
        local HitObject = Humanoid and Character[Aliases[HitPart]];

        if (not HitObject) then
            return;
        end

        local ToolHandle = Tool:FindFirstChild("ToolHandle");
        local Muzzle = ToolHandle and ToolHandle:FindFirstChild("Muzzle");

        if (not Muzzle) then
            return;
        end

        if (not Origin) then
            Origin = Muzzle.WorldCFrame.Position;
        end

        local Shoot = WeaponEvents.Gun.Fire;

        for _ = 0, (UIFlags["Combat/Ragebot/DoubleTap"] and 2) or 1 do
            Shoot:FireServer(NaN, Vector3NaN, Vector3NaN, HitObject);
        end

        self:Reload(Config, Tool); -- i dont retrieve the weaponobject itself so i cant really get ammo .... so we're just gonna hope this works
        self:Effects(Destination, Character, HitPart, Muzzle, ToolHandle, Config);
    end

    function Weapon:Reload(Config, Tool)
        local OnReload = Tool:FindFirstChild("a");

        if (not OnReload) or self.Reloading then
            return;
        end

        self.Reloading = true;

        local StartReload, ReloadFinished = GunEvents.StartReload, GunEvents.ReloadFinished;
        StartReload:FireServer();

        TaskDelay(Config.ReloadTime , function()
            local MaxAmmo = Config.Ammo;
            self.Reloading = false;

            ReloadFinished:FireServer();
            getconnections(OnReload.OnClientEvent)[1].Function(MaxAmmo);
        end)
    end

    function Weapon:Effects(Destination, Character, HitPart, Muzzle, ToolHandle, Config)
        local SoundPoint = ToolHandle:FindFirstChild("SoundPoint");

        if (not SoundPoint) then
            return;
        end

        local Humanoid = Character.Humanoid;

        if (not ToolHandle) then
            return;
        end

        local Damage = self:GetDamage(Config, HitPart);

        Effects:GunFiringSound(SoundPoint);
        Effects:Muzzle(Muzzle);
        
        Effects:DmgIndicator(Destination, Damage);
        CrosshairController:Hitmarker(HitPart == "Head", (Humanoid.Health - Damage) <= 0);

        CameraController:Recoil();
    end

    function Weapon:GetConfiguration()
        local ToolBar = ToolController.CurToolbar;
        local Selected, Tools = ToolBar.CurrentIndexSelected, ToolBar.ToolsInOrder;

        local ToolObject = Tools[Selected];

        return self.Objects[Map[Selected]], (ToolObject and ToolObject.tool) or nil;
    end

    function Weapon:GetDamage(Config, HitPart)
        local Damage = Config.Damage;

        return (HitPart == "Head" and Damage.Head) or (StringFind(HitPart, "Leg") and Damage.Lower) or Damage.Upper;
    end

    local Require = nil; Require = hookfunction(getrenv().require, function(...)
        local Info = debug.getinfo(3);
        local Result = Require(...);

    	if (StringFind(Info.source, ".WeaponController")) and Info.name == "new" then
            Weapon.Objects[(Result.Spread and "Primary") or "Melee"] = Result; -- this only retrieves the weaponconfig, we don't need anything else
    	end

    	return Result;
    end)
end

-- UI Library
do
    local Repository = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/storage";

    local ThemeManager = loadstring(game:HttpGet(`{Repository}/ThemeManager.lua`))();
    local SaveManager = loadstring(game:HttpGet(`{Repository}/SaveManager.lua`))();

    Window = Library:CreateWindow({
        Title = "homohack | @dementia_enjoyr",
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2,
    });

    local Combat = Window:AddTab("Combat"); do
        local Ragebot = Combat:AddLeftGroupbox("Ragebot"); do
            Ragebot:AddToggle("Combat/Ragebot/Enabled", {
                Text = "Enabled",
                Default = false,
            }):AddKeyPicker("Combat/Ragebot/Key", {
                Default = "None",
                SyncToggleState = false,

                Mode = "Always",

                Text = "Ragebot",
                NoUI = false,
            });

            Ragebot:AddDivider();

            Ragebot:AddToggle("Combat/Ragebot/DoubleTap", {
                Text = "Double Tap",
                Tooltip = "May cause invalids if gun doesn't reload fast enough",
                Default = false,
            });

            Ragebot:AddToggle("Combat/Ragebot/Wallbang", {
                Text = "Wallbang",
                Default = false,
            });

            Ragebot:AddSlider("Combat/Ragebot/ScanRange", {
                Text = "Scan Range",
                Default = 25,
                Min = 2,
                Max = 25,
                Rounding = 0,
                Compact = false,
            });
        end
    end

    local Settings = Window:AddTab("Settings"); do
        local MenuGroup = Settings:AddLeftGroupbox("Menu");
        
        MenuGroup:AddToggle("Settings/KeybindList", {
            Text = "Keybind List",
            Default = true,
            Callback = function(Value)
                Library.KeybindFrame.Visible = Value;
            end
        });

        MenuGroup:AddLabel("Keybind"):AddKeyPicker("Settings/MenuKeybind", { 
            Default = 'End', NoUI = true, Text = 'Menu keybind'
        });

        Library.ToggleKeybind = Options["Settings/MenuKeybind"];
        Library.KeybindFrame.Visible = true;

        ThemeManager:SetLibrary(Library);
        SaveManager:SetLibrary(Library);
        SaveManager:IgnoreThemeSettings();
        ThemeManager:SetFolder("Homohack");
        SaveManager:SetFolder("Homohack/sniper-duels");
        SaveManager:BuildConfigSection(Settings);
        ThemeManager:ApplyToTab(Settings);
        SaveManager:LoadAutoloadConfig();
    end

    local ShowFullData = {
        "KeyPicker",
        "ColorPicker",
        "Dropdown",
        "Slider",
    };

    UIFlags = setmetatable({ }, {
        __index = function(Self, Index)
            local FlagData = (Toggles[Index] or Options[Index]);
            local Value = FlagData and FlagData.Value;

            if (TableFind(ShowFullData, (FlagData and FlagData.Type) or "hello")) then
                Value = FlagData;
            end
            
            return Value;
        end
    });

    KeybindToggles = setmetatable({ }, {
        __index = function(Self, Index)
            return UIFlags[Index] and UIFlags[StringGSub(Index, "/Enabled", "/Key")]:GetState();
        end
    });
end

-- Main
do
    local Script = { }; do
        local ShootTick = -1;

        function Script:Ragebot(Data, DeltaTime)
            local Enabled = KeybindToggles["Combat/Ragebot/Enabled"];

            if (not Enabled) then
                return;
            end

            local GameTick, GamePlayers, GameIgnore, Character, Root = TableUnpack(Data);

            if (not Root) or (not Utility.Match) then
                return;
            end

            local Configuration, Tool = Weapon:GetConfiguration();

            if (not Configuration) then
                return;
            end

            local FireRate = Configuration.Firerate;

            if (not FireRate) or (GameTick - ShootTick) < FireRate then -- you can actually shift the firerate by however much you want, but i cannot check if the gun has enough ammo to continue shooting which may lead it to start dumping, so thats kinda why i keep it normal
                return;
            end

            local Min, Max = 1, UIFlags["Combat/Ragebot/ScanRange"].Value;
            local Range = (Min + MathAbs((GameTick * 9 % 2) - 1) * (Max - Min));

            local Origin, Target = Bullet:Scan(Root.Position, Range);
            local _, ReplicationCharacter, Position = TableUnpack(Target or { });

            if (not ReplicationCharacter) then
                return;
            end

            Weapon:FireBullet(Origin, Position, ReplicationCharacter, Configuration, Tool, "Head");
            ShootTick = GameTick;
        end

        function Script:Update(DeltaTime)
            local Character = LocalPlayer.Character;
            local Root = Character and Character:FindFirstChild("HumanoidRootPart");

            local GamePlayers, GameIgnore, GameTick = Utility:GetPlayers(), { Character, Camera }, tick();
            Utility.IgnoreList = GameIgnore;

            for Index, Function in self do
                if (Index == "Update") or typeof(Function) ~= "function" then
                    continue;
                end

                Function(Script, { GameTick, GamePlayers, GameIgnore, Character, Root }, DeltaTime);
            end
        end
    end

    -- Connections
    do
        RunService.RenderStepped:Connect(function(DeltaTime)
            Script:Update(DeltaTime);
        end)

        for Index, Remote in { MatchEvents.RoundConcluded, MatchEvents.RoundStarted } do
            Remote.OnClientEvent:Connect(function()
                Utility.Match = (Index % 2 == 0);
            end)
        end
    end
end
