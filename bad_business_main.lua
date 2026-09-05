--[[
    - Thanks to @iray888 for helping me solve an invalidation issue with the ragebot.
    - Thanks to @pubmain for coming up with the WalkSpeed method.
]]

local Game = game;

-- Services
local UserInputService = Game : GetService( "UserInputService" );
local SoundService = Game : GetService( "SoundService" );

local ScriptContext = Game : GetService( "ScriptContext" );
local TweenService = Game : GetService( "TweenService" );
local RunService = Game : GetService( "RunService" );

local Workspace = Game : GetService( "Workspace" );
local Players = Game : GetService( "Players" );

-- Cache
local ColorSequenceKeypointNew = ColorSequenceKeypoint.new;

local NumberSequenceNew = NumberSequence.new;
local ColorSequenceNew = ColorSequence.new;

local TweenInfoNew = TweenInfo.new;

local EnumEasingDirection = Enum.EasingDirection;
local EnumEasingStyle = Enum.EasingStyle;

local GetNamecallMethod = getnamecallmethod;
local DrawingImmediate = DrawingImmediate;
    local DrawingImmediateCircle = DrawingImmediate.Circle;

local GetThreadIdentity = getthreadidentity;
local SetThreadIdentity = setthreadidentity;

local GetRawMetatable = getrawmetatable;
local GetFunctionEnvironment = getfenv;

local CFrameIdentity = CFrame.identity;
local GetConnections = getconnections;

local HookMetaMethod = hookmetamethod;

local Vector3YAxis = Vector3.yAxis;
local CFrameAngles = CFrame.Angles;

local SetMetatable = setmetatable;

local HookFunction = hookfunction;
local InstanceNew = Instance.new;

local CheckCaller = checkcaller;
local GetUpValues = getupvalues;

local Vector3Zero = Vector3.zero;
local Vector2Zero = Vector2.zero;

local StringMatch = string.match;

local TableInsert = table.insert;
local TableUnpack = table.unpack;

local GetUpValue = getupvalue;

local Vector3New = Vector3.new;
local Vector2New = Vector2.new;

local StringFind = string.find;
local StringGSub = string.gsub;

local MathRandom = math.random;
local TableClear = table.clear;

local DebugInfo = debug.info;
local TableFind = table.find;

local Loadstring = loadstring;
local TaskDelay = task.delay;

local CFrameNew = CFrame.new;
local Color3New = Color3.new;

local TaskWait = task.wait;

local SetStack = setstack;
local GetStack = getstack;

local ToString = tostring;
local MathAbs = math.abs;
local Select = select;

local RawGet = rawget;
local TypeOf = typeof;

local Tick = tick;
local Next = next;

local MaxCastRange = 10 ^ 4;

-- Imports
local Linoria = Loadstring( Game : HttpGet( "https://raw.githubusercontent.com/dementiaenjoyer/UI-LIBRARIES/refs/heads/main/ud_linoria/new_font.lua" ) )( );
local Repository = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons";
    local ThemeManager = Loadstring( Game : HttpGet( `{ Repository }/ThemeManager.lua`) )( );
    local SaveManager = Loadstring( Game : HttpGet( `{ Repository }/SaveManager.lua`) )( );

local CacheObject = Loadstring( Game : HttpGet( "https://raw.githubusercontent.com/dementiaenjoyer/Roblox-CacheObject/refs/heads/main/Main.lua" ) )( );

-- Constants
const NonProjectileGeometry = Workspace.NonProjectileGeometry;

const CurrentCamera = Workspace.CurrentCamera;
const Characters = Workspace.Characters;
const Terrain = Workspace.Terrain;

const LocalPlayer = Players.LocalPlayer;
const Environment = getrenv( );

const White = Color3New( 1, 1, 1 );
const Black = Color3New( 0, 0, 0 );

-- Variables
local t_OnInteraction = {
    [ "RUST HEADSHOT" ] = 121566025787365,
    [ "SIT NN DOG" ] = 5902468562,

    [ "NEVERLOSE" ] = 139452805868562,

    [ "PVZ HIT" ] = 125904599927139,
    [ "PVZ SUN" ] = 7305309904,
};

local v_Center = Vector2Zero;

local t_IgnoreList = { };
local i_GameTick = 0;

local Modules = { }; do
    for Index, Value in GetConnections( LocalPlayer : FindFirstChild( "Challenges", true ).ChildAdded ) do
        local Function = Value.Function;

        if ( not Function ) then
            continue;
        end

        local TortoiseShell = GetUpValues( Function )[ 2 ];

        if ( not TortoiseShell ) then
            continue;
        end

        Modules = GetUpValue( GetRawMetatable( TortoiseShell ).__index, 1 );
    end
end

local m_Projectiles = Modules.Projectiles;
local m_Characters = Modules.Characters;

local m_Network = Modules.Network;
local m_Damage = Modules.Damage;

local m_Input = Modules.Input;
local m_Items = Modules.Items;
local m_Teams = Modules.Teams;

local m_UI = Modules.UI;

-- Classes
local PlayerObject = { }; do
    --[[
    local Hitboxes = { -- This is the same order the game has. I'd personally prefer for the longer lines to start at the top.
        "Abdomen",
        "Chest",
        "Head",
        "Hips",
        "LeftArm",
        "LeftFoot",
        "LeftForearm",
        "LeftForeleg",
        "LeftHand",
        "LeftLeg",
        "LeftShoulder",
        "Neck",
        "RightArm",
        "RightFoot",
        "RightForearm",
        "RightForeleg",
        "RightHand",
        "RightLeg",
        "RightShoulder"
    };

    local RandomizedNames = GetUpValues( GetConnections( Characters.ChildAdded )[ 1 ].Function )[ 6 ]; -- Thanks to wally on vermillion for this.
    ]]

    local SizeMap = { [ "UpperTorso" ] = Vector3New( 1.9, 1, 1.6 ), [ "Head" ] = Vector3New( 1.5, 1.6, 1.5 ) };
    local InventoryMap = { [ 2 ] = "Secondary", [ 1 ] = "Primary", [ 0 ] = "Equipped" };

    function PlayerObject : Initiate( Character, Player )
        local ClassObject = SetMetatable( { }, PlayerObject ); do
            ClassObject.Character = Character;
            ClassObject.Player = Player;
        end

        return ClassObject;
    end

    function PlayerObject : GetWeapon( Slot )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local Backpack = Character : FindFirstChild( "Backpack" );

        if ( not Backpack ) then
            return;
        end

        local Name = InventoryMap[ Slot ];

        if ( not Name ) then
            return;
        end

        local SlotObject = Backpack : FindFirstChild( Name );

        if ( not SlotObject ) then
            return;
        end

        return SlotObject.Value;
    end

    function PlayerObject : GetHitbox( Name )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local Parts = Character : FindFirstChild( "Hitbox" );

        if ( not Parts ) then
            return;
        end

        --return Parts : FindFirstChild( RandomizedNames[ TableFind( Hitboxes, Name ) or 3 ] )

        for _, Hitbox in Parts : QueryDescendants( "Part" ) do
            if ( Hitbox.Size ~= SizeMap[ Name ] ) then
                continue;
            end

            return Hitbox;
        end
    end

    function PlayerObject : __index( Index )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local ValueObject = Character : FindFirstChild( Index );

        if ( ValueObject ) then
            local ClassName = ValueObject.ClassName;

            if ( StringFind( ClassName, "Value" ) ) then
                return ValueObject.Value;
            end

            return ValueObject;
        end

        return RawGet( PlayerObject, Index );
    end

    function PlayerObject : GetPart( Name )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local Parts = Character : FindFirstChild( "Body" );

        if ( not Parts ) then
            return;
        end

        return Parts : FindFirstChild( Name );
    end

    function PlayerObject : IsProtected( )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local RootPart = Character : FindFirstChild( "Root" );

        if ( not RootPart ) then
            return;
        end

        local ShieldEmitter = RootPart : FindFirstChild( "ShieldEmitter" );

        return ( ShieldEmitter and ShieldEmitter.Enabled );
    end

    function PlayerObject : GetVelocity( )
        local Character = self.Character;

        if ( not Character ) then
            return;
        end

        local RootPart = Character : FindFirstChild( "Root" );

        if ( not RootPart ) then
            return;
        end

        return RootPart.AssemblyLinearVelocity;
    end

    function PlayerObject : GetTeam( )
        return m_Teams : GetPlayerTeam( self.Player );
    end

    PlayerObject.Character = nil;
    PlayerObject.Player = nil;
end

-- Utilities
local Projectiles = { }; do
    function Projectiles : GetDrop( Destination, Origin, Data )
        local Direction = ( Destination - Origin );

        local Distance = Vector3New( Direction.X, 0, Direction.Z ).Magnitude;
        local TimeToHit = self : TimeToHit( Distance, Data.Speed );

        return Destination + Vector3New( 0, ( .5 * Data.Gravity ) * ( TimeToHit ^ 2 ), 0 );
    end

    function Projectiles : TimeToHit( Distance, Speed )
        return Distance / Speed;
    end
end

local Entities = { }; do
    local Stamp = 0;

    function Entities : GetPlayers( )
        local Result = self.Players;

        if ( ( i_GameTick - Stamp ) > 3 ) or ( not Next( Result ) ) then
            Stamp = i_GameTick;

            for Player, Character in self.Characters do
                local Object = Result[ Player ];

                if ( Object and Object.Character == Character ) then
                    continue;
                end

                Result[ Player ] = PlayerObject : Initiate( Character, Player );
            end

            self.Players = Result;
        end

        return Result;
    end

    Entities.Characters = GetUpValue( m_Characters.GetCharacter, 1 );
    Entities.Players = { };
end

local Client = { }; do
    local Reticle = m_Input.Reticle;

    function Client : IsTeammateFFA( CharacterObject, ClientObject )
        ClientObject = ( ClientObject or self : GetObject( ) );

        if ( not ClientObject ) then
            return;
        end

        local ClientTeam = ClientObject : GetTeam( );

        return ( ( ClientTeam ~= "FFA" ) and ( CharacterObject : GetTeam( ) == ClientTeam ) ) or ( CharacterObject : IsProtected( ) );
    end

    function Client : GetIgnore( )
        local ClientObject = self : GetObject( );

        if ( not ClientObject ) then
            return { };
        end
        --NonProjectileGeometry
        return { ClientObject.Character, CurrentCamera };
    end

    function Client : GetObject( )
        return Entities.Players[ LocalPlayer ];
    end

    function Client : GetOrigin( )
        return Reticle : GetPosition( );
    end
end

local Setters = { }; do
    function Setters : Stepper( )
        v_Center = CurrentCamera.ViewportSize * .5;

        t_IgnoreList = Client : GetIgnore( );
        i_GameTick = Tick( );

        Entities : GetPlayers( );
    end
end

local Weapon = { }; do
    function Weapon : GetBulletConfig( Config )
        return self.ProjectileData[ ( Config or self : GetConfig( ) ).Projectile.Template ];
    end

    function Weapon : Effects( )
        local WeaponModel = self : Get( );

        if ( not WeaponModel ) then
            return;
        end

        local Events = WeaponModel : FindFirstChild( "Events" );

        if ( not Events ) then
            return;
        end

        local OnEffect = GetConnections( Events.Shoot.Event )[ 1 ];
        local Callback = ( OnEffect and OnEffect.Function );

        if ( not Callback ) then
            return;
        end

        Callback( );
    end

    function Weapon : GetConfig( Model )
        local ThreadIdentity = GetThreadIdentity( );
        local WeaponModel = Model or self : Get( );

        SetThreadIdentity( 2 ); -- This part disgusts me.
            local Result = m_Items : GetConfig( WeaponModel );
        SetThreadIdentity( ThreadIdentity );

        return Result;
    end

    function Weapon : GetState( Model )
        return ( Model or self : Get( ) ) : FindFirstChild( "State" );
    end

    function Weapon : GenerateID( )
        local Counter = GetUpValue( m_Projectiles.GetID, 1 );

        if ( Counter >= 1000 ) then
            Counter = 0;
        end
        -- I do not like 'else' statements, feel free to freak out about this.
        if ( Counter < 1000 ) then
            Counter += 1;
        end

        return `{ LocalPlayer.Name }_{ ToString( Counter ) }`;
    end

    function Weapon : Get( )
        local ClientObject = Client : GetObject( );

        if ( not ClientObject ) then
            return;
        end

        return ClientObject : GetWeapon( 0 );
    end

    Weapon.ProjectileData = GetUpValue( m_Projectiles.InitProjectile, 1 );
end

local World = { }; do
    local Info = TweenInfoNew( .35, EnumEasingStyle.Quad, EnumEasingDirection.InOut );
    local TracerID = "rbxassetid://446111271";

    local Params = RaycastParams.new( );

    function World : BulletTracer( Destination, Ignore, Origin, Data )
        Params.FilterDescendantsInstances = Ignore;

        local Transparency = Data.Transparency;
        local Lifetime = Data.Lifetime;

        local Color1 = Data.Color1;
        local Color2 = Data.Color2;

        local Width = Data.Width;

        local HitCast = Workspace : Raycast( Origin, ( Destination - Origin ).Unit * 1000, Params );
        Destination = ( HitCast and HitCast.Position ) or Destination;

        local OriginAttachment = InstanceNew( "Attachment", Terrain );
        OriginAttachment.CFrame = CFrameNew( Origin );

        local EndAttachment = InstanceNew( "Attachment", Terrain );
        EndAttachment.CFrame = CFrameNew( Destination );

        local Beam = InstanceNew( "Beam", Terrain ); do
            Beam.Transparency = NumberSequenceNew( Transparency );
            Beam.Texture = TracerID;

            Beam.Attachment0 = OriginAttachment;
            Beam.Attachment1 = EndAttachment;

            Beam.Color = ColorSequenceNew( {
                ColorSequenceKeypointNew( 0, Color1 ),
                ColorSequenceKeypointNew( 1, Color2 )
            } );

            Beam.LightInfluence = 0;
            Beam.LightEmission = 1;

            Beam.Width0 = Width;
            Beam.Width1 = Width;

            Beam.FaceCamera = true;
            Beam.Enabled = true;
        end

        TaskDelay( Lifetime, function( )
            TweenService : Create( Beam, Info, {
                Width0 = 0,
                Width1 = 0
            } ) : Play( ); TaskWait( Info.Time );

            OriginAttachment : Destroy( );
            EndAttachment : Destroy( );
        end )
    end

    function World : PlaySound( AssetID, Volume, Pitch )
        local Sound = InstanceNew( "Sound", SoundService );
        Sound.PlayOnRemove = true;

        Sound.SoundId = `rbxassetid://{ AssetID }`;
        Sound.Volume = Volume;
        Sound.Pitch = Pitch;

        Sound : Destroy( );
    end
end

local Math = { }; do
    function Math : GetSmoothValue( Speed, Min, Max )
        return ( Min + MathAbs( ( ( i_GameTick * Speed ) % 2 ) - 1) * ( Max - Min ) );
    end
end

local Scanning = { }; do
    local Params = RaycastParams.new( );
    local ScanPoints = {
        Vector3New( 0, -1, 0 ),
        Vector3YAxis,

        Vector3New( -1, 0, 0 ),
        Vector3New( 1, 0, 0 ),

        Vector3New( 0, 0, -1 ),
        Vector3New( 0, 0, 1 )
    };

    local Slots = {
        [ "SilentAim" ] = 0,
        [ "Aimbot" ] = 0
    };

    function Scanning : GetOrigin( Destination, Character, Range, Base )
        Params.FilterDescendantsInstances = t_IgnoreList;

        for _, Point in ( Range > 1 and ScanPoints ) or {
            Vector3New( 1, 1, 1 )
        } do
            local Direction = Point * Range;
            local Origin = Base + Direction;

            if ( Workspace : Raycast( Base, Direction ) ) then
                continue;
            end

            local HitCast = Workspace : Raycast( Origin, ( Destination - Origin ).Unit * 1000, Params );
            local HitInstance = ( HitCast and HitCast.Instance );

            if ( not HitInstance ) or ( not HitInstance : IsDescendantOf( Character ) ) then
                continue;
            end

            return Origin;
        end
    end

    function Scanning : GetClosest2D( Range, Flags, Part )
        local Closest, ClosestDistance = nil, Range;
        local ClientObject = Client : GetObject( );

        for Player, Object in Entities.Players do
            if ( Flags.b_TeamCheck ) and Client : IsTeammateFFA( Object, ClientObject ) then
                continue;
            end

            local HitPart = Object : GetHitbox( Part );

            if ( not HitPart ) then
                continue;
            end

            local ScreenPosition, OnScreen = CurrentCamera : WorldToViewportPoint( HitPart.Position );

            if ( not OnScreen ) then
                continue;
            end

            local Distance = ( Vector2New( ScreenPosition.X, ScreenPosition.Y ) - v_Center ).Magnitude;

            if ( Distance <= ClosestDistance ) then
                ClosestDistance, Closest = Distance, { Object, HitPart };
            end
        end

        return Closest;
    end

    function Scanning : Stepper( )
        for Name, _ in Slots do
            local Enabled = Flags[ `Combat / { Name } / Enabled` ];

            if ( not Enabled ) then
                continue;
            end

            local Range = Flags[ `Combat / { Name } / Range / Value` ];
            local HitPart = Flags[ `Combat / { Name } / HitPart` ];

            self[ Name ] = self : GetClosest2D( Range.Value, {
                [ "b_TeamCheck" ] = true
            }, HitPart );
        end
    end
end

-- Features
local Ragebot = { }; do
    local Params, Stamp = RaycastParams.new( ), 0;
    local ProjectileData = Weapon.ProjectileData;

    function Ragebot : Shoot( Destination, HitPart, Origin, Effects, Configs )
        local Model = Weapon : Get( );

        if ( not Model ) then
            return;
        end

        local BulletConfig = Configs.Bullet;
        local GunConfig = Configs.Gun;

        local Direction = ( Destination - Origin );
        -- Direction += Vector3New( 0, Projectile.GravityCorrection * .001, 0 );

        local Distance = Direction.Magnitude;
        local Pellets = { }; do
            for Index = 1, GunConfig.Projectile.Amount do
                local PelletID = Weapon : GenerateID( );

                TableInsert( Pellets, {
                    Direction.Unit * Distance,
                    PelletID,

                    Projectiles : TimeToHit( Distance, BulletConfig.Speed ),
                } );
            end
        end

        local NetworkFire = m_Network.Fire; do
            NetworkFire( m_Network, "Item_Paintball", "Shoot", Model, Origin, Pellets );
            NetworkFire( m_Network, "Item_Paintball", "Reload", Model );
        end if ( Effects ) then
            Weapon : Effects( true );
        end

        for Index, Pellet in Pellets do
            local Hitboxes = HitPart.Parent;

            if ( not Hitboxes ) then
                continue;
            end

            TaskDelay( Pellet[ 3 ], NetworkFire, m_Network, "Projectiles", "__Hit", Pellet[ 2 ], Destination, HitPart, Vector3New( MathRandom( ), MathRandom( ), MathRandom( ) ), Hitboxes.Parent, "" );
        end
    end

    function Ragebot : GetTarget( Ignore, Origin, Flags, Range )
        local ClientObject = Client : GetObject( );

        if ( not ClientObject ) then
            return;
        end Params.FilterDescendantsInstances = Ignore;

        local BestOrigin, BestPart, ClosestDistance = nil, nil, Range; do
            for _, CharacterObject in Entities.Players do
                if ( Client : IsTeammateFFA( CharacterObject, ClientObject ) ) then
                    continue;
                end

                local HitPart = CharacterObject : GetHitbox( "Head" );

                if ( not HitPart ) then
                    continue;
                end

                local Character = CharacterObject.Character;
                local Destination = HitPart.Position;

                local NewOrigin = Scanning : GetOrigin( Destination, Character, ( Flags.b_OriginScan and Flags.b_OriginScanRange ) or 1, Origin );
                local FixatedOrigin = ( NewOrigin or Origin );

                local Direction = ( Destination - FixatedOrigin );

                if ( not NewOrigin ) then
                    local HitCast = Workspace : Raycast( FixatedOrigin, Direction.Unit * MaxCastRange, Params );
                    local HitInstance = ( HitCast and HitCast.Instance );

                    if ( not HitInstance ) or ( not HitInstance : IsDescendantOf( ( Flags.b_Strict and Character ) or Characters ) ) then
                        continue;
                    end
                end

                --[[
                local Direction = ( Destination - NewOrigin );

                local HitCast = Workspace : Raycast( NewOrigin, Direction.Unit * MaxCastRange, Params );
                local HitInstance = ( HitCast and HitCast.Instance );

                if ( not HitInstance ) or ( not HitInstance : IsDescendantOf( ( Strict and Character ) or Characters ) ) then -- Pass strict for guaranteed hits, but it is not needed.
                    continue;
                end
                ]]

                local Distance = Direction.Magnitude;

                if ( Distance <= ClosestDistance ) then
                    ClosestDistance, BestOrigin, BestPart = Distance, NewOrigin, HitPart;
                end
            end
        end

        return BestPart, BestOrigin;
    end

    function Ragebot : Stepper( )
        local Enabled = KeybindFlags[ "Combat / Ragebot / Enabled" ];

        if ( not Enabled ) then
            return;
        end

        local Model = Weapon : Get( );

        if ( not Model ) then
            return;
        end

        local Config = Weapon : GetConfig( State );
        local State = Weapon : GetState( Model );

        if ( not State ) then
            return;
        end

        local FireMode = State : FindFirstChild( "FireMode" );

        if ( not FireMode ) or ( i_GameTick - Stamp ) < ( 60 / ( ( Config.FireModes[ Config.FireModeList[ FireMode.Value ] ].FireRate or 1000 ) * Flags[ "Combat / Ragebot / FRM" ].Value ) ) then
            return;
        end Stamp = i_GameTick;

        local OriginScanFlag = "Combat / Ragebot / OriginScan /";
            local ShiftRange = Flags[ "Combat / Ragebot / ShiftRange" ];

            local OriginScanEnabled = Flags[ `{ OriginScanFlag } Enabled` ];
            local OriginScanRange = Flags[ `{ OriginScanFlag } Range` ];

            if ( not ShiftRange ) then
                OriginScanRange = OriginScanRange.Value;
            end

            if ( ShiftRange ) then
                OriginScanRange = Math : GetSmoothValue( 6, OriginScanRange.Min, OriginScanRange.Max );
            end

        local StrictScan = Flags[ "Combat / Ragebot / StrictScan" ];
        local Effects = Flags[ "Combat / Ragebot / Effects" ];

        -- Destination, HitPart, Origin, Effects, Configs
        local HitPart, Origin = self : GetTarget( t_IgnoreList, Client : GetOrigin( ), {
            [ "b_OriginScanRange" ] = OriginScanRange,
            [ "b_OriginScan" ] = OriginScanEnabled,

            [ "b_Strict" ] = StrictScan,
        }, 1000 );

        local Destination = ( HitPart and HitPart.Position );

        if ( not Destination ) or ( not Origin ) then
            return;
        end

        local BulletConfig = Weapon : GetBulletConfig( Config );

        if ( not BulletConfig ) then
            return;
        end

        self : Shoot( Destination, HitPart, Origin, Effects, {
            [ "Bullet" ] = BulletConfig,
            [ "Gun" ] = Config,
        } );
    end
end

local Visuals = { }; do
    local CachedObjects = { };

    function Visuals : Players( )
        local ClientObject = Client : GetObject( );

        if ( not ClientObject ) then
            return;
        end

        local Configuration = { }; do
            local MasterSwitch = Flags[ "Visuals / Players / Enabled" ];

            if ( not MasterSwitch ) then
                return TableClear( CachedObjects );
            end

            -- Health Bar
            do
                local Enabled = Flags[ "Visuals / Players / HealthBar / Enabled" ];

                if ( Enabled ) then
                    Configuration[ "HealthBar" ] = Flags[ "Visuals / Players / HealthBar / Color" ].Value;
                end
            end

            -- Weapon
            do
                local Enabled = Flags[ "Visuals / Players / Weapon / Enabled" ];

                if ( Enabled ) then
                    Configuration[ "Tool" ] = Flags[ "Visuals / Players / Weapon / Color" ].Value;
                end
            end

            -- Name
            do
                local Enabled = Flags[ "Visuals / Players / Name / Enabled" ];

                if ( Enabled ) then
                    Configuration[ "Name" ] = Flags[ "Visuals / Players / Name / Color" ].Value;
                end
            end

            -- Box
            do
                local Enabled = Flags[ "Visuals / Players / Box / Enabled" ];

                if ( Enabled ) then
                    Configuration[ "Box" ] = Flags[ "Visuals / Players / Box / Color" ].Value;
                end
            end

            CacheObject.Configuration = Configuration;
        end

        for Player, CharacterObject in Entities.Players do
            if ( Client : IsTeammateFFA( CharacterObject, ClientObject ) ) then
                continue;
            end

            local RootPart = CharacterObject.Root;

            if ( not RootPart ) then
                continue;
            end

            local Character = CharacterObject.Character;

            if ( not Character ) then
                continue;
            end

            local Health = CharacterObject.Health;
            local Name = Player.Name;

            local Object = CachedObjects[ Player ] or CacheObject : Initiate( Name, function( Self )
                CachedObjects[ Player ] = Self;
            end ); do
                Object.MaxHealth = 150;
                Object.Health = Health;

                if ( Health >= 1 ) then
                    local Weapon = CharacterObject : GetWeapon( 0 );
                    local Size = Character : GetExtentsSize( );

                    Object : Respawn( );

                    Object.Position = RootPart.Position;
                    Object.Offset = -Vector3YAxis;

                    Object.Tool = ToString( Weapon or "Unknown" );
                    Object.Size = Size;
                end

                if ( Health <= 0 ) then
                    Object : Died( );
                end

                Object : Stepper( );
            end
        end
    end

    function Visuals : Screen( )
        local NumSides = 16;

        -- Silent Range
        do
            local Enabled = Flags[ "Combat / SilentAim / Range / Enabled" ];

            if ( Enabled ) then
                local Color = Flags[ "Combat / SilentAim / Range / Color" ].Value;
                local Range = Flags[ "Combat / SilentAim / Range / Value" ].Value;

                DrawingImmediateCircle( v_Center, Range, Black, 1, NumSides, 3 ); -- Outline
                DrawingImmediateCircle( v_Center, Range, Color, 1, NumSides, 1 ); -- Main
            end
        end
    end

    function Visuals : Stepper( )
        self : Players( );
        self : Screen( );
    end
end

local Player = { }; do
    function Player : Stepper( )
        self : Fly( );
    end

    function Player : Fly( )
        local ClientObject = Client : GetObject( );

        if ( not ClientObject ) then
            return;
        end

        local RootPart = ClientObject.Root;

        if ( not RootPart ) then
            return;
        end

        local Speed = Flags[ "Misc / Fly / Speed" ].Value * 3;
        local Enabled = Flags[ "Misc / Fly / Enabled" ];

        local MoveDirection = Vector3Zero; do
            local CoordinateFrame = CurrentCamera.CFrame;

            local RightVector = CoordinateFrame.RightVector;
            local LookVector = CoordinateFrame.LookVector;

            if ( UserInputService : IsKeyDown( "LeftControl" ) ) then
                MoveDirection -= Vector3YAxis;
            end

            if ( UserInputService : IsKeyDown( "Space" ) ) then
                MoveDirection += Vector3YAxis;
            end

            if ( UserInputService : IsKeyDown( "W" ) ) then
                MoveDirection += LookVector;
            end

            if ( UserInputService : IsKeyDown( "S" ) ) then
                MoveDirection -= LookVector;
            end

            if ( UserInputService : IsKeyDown( "A" ) ) then
                MoveDirection -= RightVector;
            end

            if ( UserInputService : IsKeyDown( "D" ) ) then
                MoveDirection += RightVector;
            end
        end

        local Anchored = Enabled and ( MoveDirection.Magnitude == 0 );
        RootPart.Anchored = Anchored;

        if Enabled and ( not Anchored ) then
            RootPart.Velocity = ( MoveDirection * Speed );
        end
    end
end

-- Interface
do
    local Window = Library : CreateWindow( {
        Title = "Homohack | Bad Business ( @dementia_enjoyr )",
        -- Size = UDim2FromOffset( 590, 600 ),

        AutoShow = true,
        Center = true,

        MenuFadeTime = .5,
        TabPadding = 7,
    } );

    local CombatTab = Window : AddTab( "Combat" ); do
        local SilentGroup = CombatTab : AddRightGroupbox( "Silent Aim" ); do
            SilentGroup : AddToggle( "Combat / SilentAim / Enabled", {
                Text = "Enabled",
                Default = false,
            } );

            SilentGroup : AddDivider( );

            SilentGroup : AddToggle( "Combat / SilentAim / Prediction / Velocity", {
                Text = "Predict Velocity",
                Default = false,
            } );

            SilentGroup : AddToggle( "Combat / SilentAim / Prediction / Gravity", {
                Text = "Predict Gravity",
                Default = false,
            } );

            SilentGroup : AddDivider( );

            SilentGroup : AddToggle( "Combat / SilentAim / Range / Enabled", {
                Text = "Visualize Range",
                Default = false,
            } ) : AddColorPicker( "Combat / SilentAim / Range / Color", {
                Default = White,

                Title = "Color",
            } );

            SilentGroup : AddSlider( "Combat / SilentAim / Range / Value", {
                Text = "Value",
                Default = 0,

                Max = 500,
                Min = 0,

                Compact = false,
                Rounding = 1,
            } );

            SilentGroup : AddDivider( );

            SilentGroup : AddDropdown( "Combat / SilentAim / HitPart", {
                Text = "Hit Part",

                Values = {
                    "UpperTorso",
                    "Head",
                },

                Multi = false,
                Default = 2,
            } );
        end

        local RagebotGroup = CombatTab : AddLeftGroupbox( "Ragebot" ); do
            RagebotGroup : AddToggle( "Combat / Ragebot / Enabled", {
                Text = "Enabled",
                Default = false,
            } ) : AddKeyPicker( "Combat / Ragebot / Key", {
                SyncToggleState = false,
                NoUI = false,

                Text = "Ragebot",
                Mode = "Always",

                Default = "X",
            } );

            RagebotGroup : AddDivider( );

            RagebotGroup : AddToggle( "Combat / Ragebot / ShiftRange", {
                Tooltip = "Will smoothly move the max range between the minimum and maximum range value to make sure it checks every possible range for hits.",
                Text = "Shift Range",
                Default = false,
            } );

            RagebotGroup : AddToggle( "Combat / Ragebot / StrictScan", {
                Tooltip = "Makes sure the hitcast hits the target, rather than a player in general. Will almost guarantee hits when it shoots.",
                Text = "Strict Scan",

                Default = false,
            } );

            RagebotGroup : AddDivider( );

            RagebotGroup : AddToggle( "Combat / Ragebot / OriginScan / Enabled", {
                Text = "Origin Scan",
                Default = true,
            } );

            RagebotGroup : AddSlider( "Combat / Ragebot / OriginScan / Range", {
                Text = "Range",
                Default = 16,

                Max = 20,
                Min = 1,

                Compact = false,
                Rounding = 1,
            } );

            RagebotGroup : AddDivider( );

            RagebotGroup : AddToggle( "Combat / Ragebot / Effects", {
                Text = "Effects",
                Default = true,
            } );

            RagebotGroup : AddSlider( "Combat / Ragebot / FRM", {
                Text = "FireRate Multiplier",
                Default = 1,

                Max = 10,
                Min = .1,

                Compact = false,
                Rounding = 2,
            } );
        end
    end

    local VisualsTab = Window : AddTab( "Visuals" ); do
        local BTGroup = VisualsTab : AddRightGroupbox( "Bullet Tracers" ); do
            BTGroup : AddToggle( "Visuals / BulletTracers / Enabled", {
                Text = "Enabled",
                Default = false,
            } ) : AddColorPicker( "Visuals / BulletTracers / Color1", {
                Default = White,

                Title = "Color 1",
            } ) : AddColorPicker( "Visuals / BulletTracers / Color2", {
                Default = White,

                Title = "Color 2",
            } );

            BTGroup : AddDivider( );

            BTGroup : AddSlider( "Visuals / BulletTracers / Lifetime", {
                Text = "Lifetime",
                Default = .1,

                Max = 10,
                Min = .1,

                Compact = false,
                Rounding = 1,
            } );

            BTGroup : AddSlider( "Visuals / BulletTracers / Width", {
                Text = "Width",
                Default = .1,

                Max = 10,
                Min = .1,

                Compact = false,
                Rounding = 1,
            } );
        end

        local PlayersGroup = VisualsTab : AddLeftGroupbox( "Players" ); do
            PlayersGroup : AddToggle( "Visuals / Players / Enabled", {
                Text = "Enabled",
                Default = false,
            } );

            PlayersGroup : AddDivider( );

            PlayersGroup : AddToggle( "Visuals / Players / HealthBar / Enabled", {
                Text = "Healthbar",
                Default = false,
            } ) : AddColorPicker( "Visuals / Players / HealthBar / Color", {
                Default = White,

                Title = "Color",
            } );

            PlayersGroup : AddToggle( "Visuals / Players / Weapon / Enabled", {
                Text = "Weapon",
                Default = false,
            } ) : AddColorPicker( "Visuals / Players / Weapon / Color", {
                Default = White,

                Title = "Color",
            } );

            PlayersGroup : AddToggle( "Visuals / Players / Name / Enabled", {
                Text = "Name",
                Default = false,
            } ) : AddColorPicker( "Visuals / Players / Name / Color", {
                Default = White,

                Title = "Color",
            } );

            PlayersGroup : AddToggle( "Visuals / Players / Box / Enabled", {
                Text = "Box",
                Default = false,
            } ) : AddColorPicker( "Visuals / Players / Box / Color", {
                Default = White,

                Title = "Color",
            } );
        end
    end

    local MiscTab = Window : AddTab( "Misc" ); do
        local VMGroup = MiscTab : AddLeftGroupbox( "View Model" ); do
            VMGroup : AddToggle( "Misc / ViewModel / NoSway", {
                Text = "No Sway",
                Default = false,
            } );

            VMGroup : AddToggle( "Misc / ViewModel / NoBob", {
                Text = "No Bob",
                Default = false,
            } );

            VMGroup : AddDivider( );

            for _, Value in { "Roll", "X", "Y", "Z" } do
                VMGroup : AddSlider( `Misc / ViewModel / Offset / { Value }`, {
                    Text = `Offset { Value }`,
                    Default = 0,

                    Min = -10,
                    Max = 10,

                    Compact = false,
                    Rounding = 1,
                } );
            end do
                VMGroup : AddDivider( );

                VMGroup : AddToggle( "Misc / ViewModel / Offset / AnimateRoll / Enabled", {
                    Text = "Animate Roll",
                    Default = false,
                } );

                VMGroup : AddSlider( "Misc / ViewModel / Offset / AnimateRoll / Speed", {
                    Text = "Speed",
                    Default = 1,

                    Min = 1,
                    Max = 10,

                    Compact = false,
                    Rounding = 1,
                } );
            end
        end

        local WSGroup = MiscTab : AddRightGroupbox( "Walk Speed" ); do
            WSGroup : AddToggle( "Misc / WalkSpeed / Enabled", {
                Text = "Enabled",
                Default = false,
            } );

            WSGroup : AddDivider( );

            WSGroup : AddSlider( "Misc / WalkSpeed / Value", {
                Text = "Speed",
                Default = 1,

                Max = 10,
                Min = 1,

                Compact = false,
                Rounding = 1,
            } );
        end

        local FlyGroup = MiscTab : AddRightGroupbox( "Fly" ); do
            FlyGroup : AddToggle( "Misc / Fly / Enabled", {
                Text = "Enabled",
                Default = false,
            } );

            FlyGroup : AddDivider( );

            FlyGroup : AddSlider( "Misc / Fly / Speed", {
                Text = "Speed",
                Default = 1,

                Max = 100,
                Min = 1,

                Compact = false,
                Rounding = 1,
            } );
        end

        for Index, Value in { "Kill Sounds", "Hit Sounds" } do
            local Group = MiscTab[ `Add{ ( Index % 2 == 0 and "Right" ) or "Left" }Groupbox` ]( MiscTab, Value ); do
                Group : AddToggle( `Misc / { Value } / Enabled`, {
                    Text = "Enabled",
                    Default = false,
                } );

                Group : AddDivider( );

                Group : AddDropdown( `Misc / { Value } / Sound`, {
                    Text = "Sound",

                    Values = ( function()
                        local Result = { };

                        for Index in t_OnInteraction do
                            TableInsert( Result, Index );
                        end

                        return Result;
                    end )( ),

                    Multi = false,
                    Default = 1,
                } );
            end
        end
    end

    local SettingsTab = Window : AddTab( "Settings" ); do
        local SettingsGroup = SettingsTab : AddLeftGroupbox( "Settings" ); do
            SettingsGroup : AddToggle( "Settings / Keylist", {
                Text = "Keybind List",
                Default = false,

                Callback = function( Value )
                    Library.KeybindFrame.Visible = Value;
                end
            } );

            SettingsGroup : AddToggle( "Settings / Watermark", {
                Text = "Watermark",
                Default = true,

                Callback = function( Value )
                    Library : SetWatermarkVisibility( Value );
                end
            } );

            SettingsGroup : AddLabel( "Keybind" ) : AddKeyPicker( "Settings / Key" , {
                Text = "Keybind",
                Default = "End",

                NoUI = true,
            } );

            Library : SetWatermark( "homohack | dementia enjoyer" );
            Library.ToggleKeybind = Options[ "Settings / Key" ];
        end

        ThemeManager : SetLibrary( Library );
        SaveManager : SetLibrary( Library );

        SaveManager : IgnoreThemeSettings( );

        SaveManager : SetFolder( "Homohack/BB-Main" );
        ThemeManager : SetFolder( "Homohack" );

        SaveManager : BuildConfigSection( SettingsTab );
        ThemeManager : ApplyToTab( SettingsTab );

        SaveManager : LoadAutoloadConfig( );
    end

    Flags = SetMetatable( { }, {
        [ "__index" ] = function( Self, Index )
            local FlagData = ( Toggles[ Index ] or Options[ Index ] );
            local Value = FlagData and FlagData.Value;

            if ( TableFind( { "KeyPicker", "ColorPicker", "Slider" }, ( FlagData and FlagData.Type ) or "hello" ) ) then
                Value = FlagData;
            end

            return Value;
        end
    } );

    KeybindFlags = SetMetatable( { }, {
        [ "__index" ] = function( Self, Index )
            return Flags[ Index ] and Flags[ StringGSub( Index, "/ Enabled", "/ Key" ) ] : GetState( );
        end
    } );
end

-- Hooks
do
    -- Vector3
    do
        local __Namecall = nil; __Namecall = HookMetaMethod( Vector3Zero, "__namecall", function( Self, ... )
            local Method = GetNamecallMethod( );
            local Stack = GetStack( 3 );

            if ( Flags[ "Misc / WalkSpeed / Enabled" ] ) and ( DebugInfo( 3, "l" ) == 955 ) and ( Method == "Lerp" ) and ( #Stack >= 4 ) then
                SetStack( 3, 4, Stack[ 4 ] * Flags[ "Misc / WalkSpeed / Value" ].Value ); -- To make it a bit clearer as to what we are doing here: Vector3.Lerp is called after the result of GetMovementInput (Which returns the current MovementVector) has been assigned to a variable, we replace that value with the same value but multiplied by 3 via the stack to increase our walkspeed.
            end

            return __Namecall( Self, ... );
        end )
    end

    -- Network
    do
        local __Fire = nil; __Fire = HookFunction( m_Network.Fire, function( Self, Category, Event, ... )
            local Arguments = { ... };

            if ( Category == "Item_Paintball" ) and ( Event == "Shoot" ) then
                local OurCaller = CheckCaller( );
                local Stack = GetStack( 3 );

                local Pellets = Stack[ 5 ];
                local Origin = Stack[ 4 ];

                if ( OurCaller ) then -- Stack indexes change if it's our caller, better to do this.
                    Pellets = Arguments[ 3 ];
                    Origin = Arguments[ 2 ];
                end

                if ( TypeOf( Pellets ) == "table" ) and ( TypeOf( Origin ) == "Vector3" ) then
                    local f_BulletTracersEnabled = Flags[ "Visuals / BulletTracers / Enabled" ];
                        local f_BulletTracersLifetime = Flags[ "Visuals / BulletTracers / Lifetime" ].Value;
                        local f_BulletTracersWidth = Flags[ "Visuals / BulletTracers / Width" ].Value;

                        local f_BulletTracersColor1 = Flags[ "Visuals / BulletTracers / Color1" ];
                        local f_BulletTracersColor2 = Flags[ "Visuals / BulletTracers / Color2" ];

                    local ScanData = ( not OurCaller ) and Scanning.SilentAim;

                    local HitPart = ( ScanData and ScanData[ 2 ] );
                    local Object = ( ScanData and ScanData[ 1 ] );

                    for Index, Data in Pellets do
                        local Destination = ( HitPart and HitPart.Position ) or Origin + Data[ 1 ];

                        if ( HitPart ) then
                            local PredictionFlag = "Combat / SilentAim / Prediction /";

                            local PredictVelocity = Flags[ `{ PredictionFlag } Velocity` ];
                            local PredictGravity = Flags[ `{ PredictionFlag } Gravity` ];

                            local BulletConfig = Weapon : GetBulletConfig( );

                            if ( PredictVelocity ) then
                                Destination = Projectiles : GetDrop( Destination, Origin, BulletConfig );
                            end

                            if ( PredictGravity ) then
                                Destination += ( Object : GetVelocity( ) or Vector3Zero ) * Projectiles : TimeToHit( ( Destination - Origin ).Magnitude, BulletConfig.Speed );
                            end

                            Data[ 1 ] = ( Destination - Origin ).Unit * MaxCastRange;
                        end

                        if ( f_BulletTracersEnabled ) then
                            World : BulletTracer( Destination, t_IgnoreList, Origin, {
                                [ "Transparency" ] = ( f_BulletTracersColor1.Transparency * .5 ) + ( f_BulletTracersColor2.Transparency * .5 ),

                                [ "Color1" ] = f_BulletTracersColor1.Value,
                                [ "Color2" ] = f_BulletTracersColor2.Value,

                                [ "Lifetime" ] = f_BulletTracersLifetime,
                                [ "Width" ] = f_BulletTracersWidth,
                            } );
                        end
                    end
                end
            end

            return __Fire( Self, Category, Event, TableUnpack( Arguments ) );
        end )
    end

    -- CFrame
    do
        local __Namecall = nil; __Namecall = HookMetaMethod( CFrameIdentity, "__namecall", function( Self, ... )
            local Method = GetNamecallMethod( );

            if ( Method == "VectorToObjectSpace" ) and ( Select( 1, ... ) == CurrentCamera.CFrame.LookVector ) then -- ItemAnimateScript
                local BaseFlag = `Misc / ViewModel /`

                if ( Flags[ `{ BaseFlag } NoSway` ] ) then
                    SetStack( 3, 1, 0 );
                end

                if ( Flags[ `{ BaseFlag } NoBob` ] ) then
                    SetStack( 3, 4, CFrameIdentity );
                    SetStack( 3, 2, 0 );
                end
            end

            return __Namecall( Self, ... );
        end )
    end

    -- Game
    do
        local __NewIndex = nil; __NewIndex = HookMetaMethod( Game, "__newindex", function( Self, Index, Value )
            local Parent = Self.Parent;

            if ( Index == "CFrame" ) and ( Parent and Parent : FindFirstChild( "RightHand" ) ) and ( Self == Parent : FindFirstChild( "Root" ) ) then
                local BaseFlag = "Misc / ViewModel / Offset /";

                local X = Flags[ `{ BaseFlag } X` ].Value;
                local Y = Flags[ `{ BaseFlag } Y` ].Value;
                local Z = Flags[ `{ BaseFlag } Z` ].Value;

                local Roll = Flags[ `{ BaseFlag } Roll` ]; do
                    local AnimateEnabled = Flags[ `{ BaseFlag } AnimateRoll / Enabled` ];
                    local AnimateSpeed = Flags[ `{ BaseFlag } AnimateRoll / Speed` ];

                    if ( not AnimateEnabled ) then
                        Roll = Roll.Value;
                    end

                    if ( AnimateEnabled ) then
                        Roll = Math : GetSmoothValue( AnimateSpeed.Value * .1, AnimateSpeed.Min, AnimateSpeed.Max );
                    end
                end

                Value *= CFrameNew( X, Y, Z ) * CFrameAngles( 0, 0, Roll );
            end

            return __NewIndex( Self, Index, Value );
        end )
    end
end

-- Main
do
    DrawingImmediate.GetPaint( 1 ) : Connect( function( )
        Visuals : Stepper( );
    end )

    RunService.PreRender : Connect( function( )
        Scanning : Stepper( );

        Ragebot : Stepper( );
        Setters : Stepper( );

        Player : Stepper( );
    end )

    for Index, Value in { "Kill Sounds", "Hit Sounds" } do
        m_Damage[ `Character{ ( Index % 2 == 0 and "Damaged" ) or "Killed" }` ] : Connect( function( Victim, History, TheBoss, ... )
            if ( Value == "Kill Sounds" ) and ( TheBoss ~= LocalPlayer ) then
                return;
            end

            local Enabled = Flags[ `Misc / { Value } / Enabled` ];

            if ( Enabled ) then
                World : PlaySound( t_OnInteraction[ Flags[ `Misc / { Value } / Sound` ] ], 10, 1 );
            end
        end )
    end
end
