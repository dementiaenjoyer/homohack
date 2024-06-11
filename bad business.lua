--// Made by dementia enjoyer <3

--// UI

local Repository = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(Repository .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(Repository .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(Repository .. 'addons/SaveManager.lua'))()

--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

--// Tables

local Functions = {
    Players = {},
    Esp = {},
    Math = {},
}

local Storage = {
    Aimbot = {
        ClosestPlayer = nil,
    },
    Drawing = {},
}

local Features = {
    Combat = {
        Aimbot = {Enabled = false, TeamCheck = false, Prediction = 0.1}
    },
    Visuals = {
        TeamCheck = false,
        Box = { Enabled = false, Color = Color3.fromRGB(255, 255, 255) },
        Health = { Enabled = false, Color = Color3.fromRGB(100, 255, 0) },
    }
}

--// Defined

local Players = workspace.Characters
local Camera = workspace.CurrentCamera

--// Drawing

local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255, 255, 255)
FOV.Visible = false
FOV.Transparency = 1
FOV.Radius = 100

--// Rest

local Window = Library:CreateWindow({
    Title = 'homohack | made by dementia enjoyer / @eldmonstret',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

local Tabs = {
    AimbotTab = Window:AddTab('Aimbot'),
    VisualsTab = Window:AddTab('Visuals'),
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local Sections = {
    AimbotSection = Tabs.AimbotTab:AddLeftGroupbox('Aimbot'),
    VisualsSection = Tabs.VisualsTab:AddLeftGroupbox('Visuals'),
}

do --// UI Elements

    do --// Aimbot

        Sections.AimbotSection:AddToggle('AimbotToggle', {
            Text = 'Aimbot',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                Features.Combat.Aimbot.Enabled = Value
            end
        })

        Sections.AimbotSection:AddToggle('TeamCheckAimbot', {
            Text = 'TeamCheck',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                Features.Combat.Aimbot.TeamCheck = Value
            end
        })
        
        Sections.AimbotSection:AddToggle('VisualiseRange', {
            Text = 'Visualise Range',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                FOV.Visible = Value
            end
        }):AddColorPicker('RangeColor', {
            Default = Color3.fromRGB(255, 255, 255),
            Title = 'Range Color', 
            Transparency = 0,
        
            Callback = function(Value)
                FOV.Color = Value
            end
        })

        Sections.AimbotSection:AddSlider('AimbotRange', {
            Text = 'Prediction',
            Default = 0.1,
            Min = 0,
            Max = 0.5,
            Rounding = 3,
            Compact = false,
        
            Callback = function(Value)
                Features.Combat.Aimbot.Prediction = Value
            end
        })
        
        Sections.AimbotSection:AddSlider('AimbotRange', {
            Text = 'Aimbot Range',
            Default = 100,
            Min = 0,
            Max = 500,
            Rounding = 1,
            Compact = false,
        
            Callback = function(Value)
                FOV.Radius = Value
            end
        })
        
    end

    do --// Visuals

        Sections.VisualsSection:AddToggle('Box', {
            Text = 'Box',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                Features.Visuals.Box.Enabled = Value
            end
        }):AddColorPicker('BoxColor', {
            Default = Color3.fromRGB(255, 255, 255),
            Title = 'Box Color', 
            Transparency = 0,
        
            Callback = function(Value)
                Features.Visuals.Box.Color = Value
            end
        })
        
        Sections.VisualsSection:AddToggle('Healthbar', {
            Text = 'Healthbar',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                Features.Visuals.Health.Enabled = Value
            end
        }):AddColorPicker('HealthbarColor', {
            Default = Color3.fromRGB(100, 255, 0),
            Title = 'Healthbar Color', 
            Transparency = 0,
        
            Callback = function(Value)
                Features.Visuals.Health.Color = Value
            end
        })

        Sections.VisualsSection:AddToggle('TeamCheck', {
            Text = 'TeamCheck',
            Default = false,
            Tooltip = 'This is a tooltip',
        
            Callback = function(Value)
                Features.Visuals.TeamCheck = Value
            end
        })
        
    end
    
end

do --// Logic

    do --// Functions

        do --// Players

            function Functions.Players.GetPlayers()
                local EntityList = {}
                local Children = Players:GetChildren()

                for i = 1, #Players:GetChildren() do
                    local Step = Children[i]
                    if Step:IsA("Model") then
                        table.insert(EntityList, Step)
                    end
                end
                return EntityList
                
            end

            function Functions.Players.IsTeammate(Player)

                if Player:FindFirstChild("Body") and Player["Body"]:FindFirstChild("Head") then
                    for i, Billboards in game:GetService("Players").LocalPlayer.PlayerGui:GetChildren() do
                        if Billboards:IsA("BillboardGui") and Billboards.Name == "NameGui" and Billboards.Adornee == Player["Body"]["Head"] then
                            return true
                        end
                    end
                end
                return false
                
            end
            
        end

        do --// Esp

            function Functions.Esp.Create(Player)

                if Player and not Storage.Drawing[Player] then

                    local Box = Drawing.new("Square")
                    Box.Transparency = 1
                    Box.Color = Color3.fromRGB(255, 255, 255)

                    local HealthBar = Drawing.new("Square")
                    HealthBar.Transparency = 1
                    HealthBar.Color = Color3.fromRGB(100, 255, 0)
                    HealthBar.Visible = true
                    HealthBar.Filled = true

                    Storage.Drawing[Player] = {
                        Box = Box,
                        Bar = HealthBar,
                    }

                end

            end

            function Functions.Esp.Clear(Player)
                if Storage.Drawing[Player] then
                    
                    local Drawings = Storage.Drawing[Player]

                    do --// Visibility

                        Drawings.Box.Visible = false
                        Drawings.Bar.Visible = false
                        
                    end
                    do --// Remove

                        Drawings.Box:Remove()
                        Drawings.Bar:Remove()

                    end

                    Storage.Drawing[Player] = nil

                end
            end

        end

        do --// Math

            function Functions.Math.Distance(Origin, End)

                return (Origin - End).Magnitude

            end

            function Functions.Math.GetClosestPlayer()
                local Player = nil
                local Closest = math.huge
            
                for i, Plrs in Functions.Players.GetPlayers() do
                    if Plrs and Plrs:FindFirstChild("Body") then
                        local Chest = Plrs.Body:FindFirstChild("Chest")
                        if Chest and (Features.Combat.Aimbot.TeamCheck and not Functions.Players.IsTeammate(Plrs)) or not Features.Combat.Aimbot.TeamCheck then
                            local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Chest.Position)
                            if OnScreen then
                                local Distance = Functions.Math.Distance(UserInputService:GetMouseLocation(), Vector2.new(ScreenPosition.X, ScreenPosition.Y))
                                if Distance < Closest and Distance < FOV.Radius then
                                    Player = Plrs
                                    Closest = Distance
                                end
                            end
                        end
                    end
                end
            
                return Player
            end
            
        end
        
    end

    do --// Loops

        for i, Player in Functions.Players.GetPlayers() do
            Functions.Esp.Create(Player)
        end
        
        RunService.RenderStepped:Connect(function()

            do --// Aimbot

                local Closest = Storage.Aimbot.ClosestPlayer

                if Features.Combat.Aimbot.Enabled and Storage.Aimbot.ClosestPlayer ~= nil then
                    if Closest ~= nil and Closest:FindFirstChild("Body") and Closest["Body"]:FindFirstChild("Head") then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Closest["Body"]["Head"].Position + (Closest["Body"]["Chest"].Velocity * Features.Combat.Aimbot.Prediction))
                    end
                end

                FOV.Position = UserInputService:GetMouseLocation()

            end

            do --// Visuals

                for Player, Drawings in Storage.Drawing do

                    --// Drawing

                    local Box = Drawings.Box
                    local Healthbar = Drawings.Bar

                    if Player ~= nil and Player:FindFirstChild("Body") and Player:FindFirstChild("Health") then
                        
                        --// Character

                        local Character = Player["Body"]
                        local Chest = Character["Chest"]

                        --// Stats

                        local Health = Player["Health"]
                        local MaxHealth = Health["MaxHealth"]

                        --// Rest

                        local ScreenPosition, OnScreen = Camera:WorldToViewportPoint(Chest.Position)
                        if OnScreen then

                            local Scale = 1000/Functions.Math.Distance(Camera.CFrame.Position, Chest.Position)*80/Camera.FieldOfView

                            do --// Box

                                Box.Visible = Features.Visuals.Box.Enabled and (not Features.Visuals.TeamCheck or not Functions.Players.IsTeammate(Player))
                                Box.Position = Vector2.new(ScreenPosition.X - (Box.Size.X / 2), ScreenPosition.Y - (Box.Size.Y / 2))
                                Box.Size = Vector2.new(3 * Scale, 4 * Scale)
                                Box.Color = Features.Visuals.Box.Color
                                
                            end

                            do --// Healthbar

                                Healthbar.Visible = Features.Visuals.Health.Enabled and (not Features.Visuals.TeamCheck or not Functions.Players.IsTeammate(Player))
                                Healthbar.Size = Vector2.new(2, Box.Size.Y * Health.Value / MaxHealth.Value)
                                Healthbar.Position = Vector2.new(Box.Position.X - 5, Box.Position.Y + (Box.Size.Y * (1 - Health.Value / MaxHealth.Value)))
                                Healthbar.Color = Features.Visuals.Health.Color

                            end

                        else

                            Box.Visible = false
                            Healthbar.Visible = false

                        end

                    end
                end
                
            end

        end)
        
    end

    do --// Connections

        Players.ChildAdded:Connect(function(Player)
            Functions.Esp.Create(Player)
        end)

        Players.ChildRemoved:Connect(function(Player)
            Functions.Esp.Clear(Player)
        end)

        UserInputService.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Storage.Aimbot.ClosestPlayer = Functions.Math.GetClosestPlayer()
            end
        end)

        UserInputService.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton2 then
                Storage.Aimbot.ClosestPlayer = nil
            end
        end)
        
    end
    
end

do --// UI

    Library:SetWatermarkVisibility(true)

    Library.KeybindFrame.Visible = true;
    
    Library:OnUnload(function()
        print('Unloaded!')
        Library.Unloaded = true
    end)
    
    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
    
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
    
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    
    SaveManager:IgnoreThemeSettings()
    
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
    ThemeManager:SetFolder('Homohack')
    SaveManager:SetFolder('Homohack/bad-business')
    
    SaveManager:BuildConfigSection(Tabs['UI Settings'])
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
    SaveManager:LoadAutoloadConfig()
    
end
