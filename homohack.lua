--// Made by @dementia enjoyer
--// Forgive me for the very shit code, gonna rewrite dis later and actually try to make it look good lol
--// join .gg/syAGdFKAZQ for updates and more scripts like this <3 \\--

local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'homohack (made by @eldmonstret / dementia enjoyer)',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

--// Defined

local Camera = workspace.CurrentCamera
local Players = workspace.Players
local Ignore = workspace.Ignore
local DeadBodies = workspace.Ignore.DeadBody
local Misc = Ignore.Misc

--// Roblox

local Vector3New = Vector3.new
local CFrameNew = CFrame.new

--// Services

local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

--// Tables

local Tabs = {
    AimbotTab = Window:AddTab('Aimbot'),
    VisualsTab = Window:AddTab('Visuals'),
    MiscTab = Window:AddTab('Misc'),
    Settings = Window:AddTab('Settings'),
}

local Sections = {

    --// Aimbot Tab

    Aimbot = Tabs.AimbotTab:AddLeftGroupbox('Aimbot'),
    AimbotSettings = Tabs.AimbotTab:AddRightGroupbox('Aimbot Settings'),
    
    --// Visuals Tab

    Visuals = Tabs.VisualsTab:AddLeftGroupbox('Visuals'),
    VisualSettings = Tabs.VisualsTab:AddRightGroupbox('Configuration'),

    Grenade = Tabs.VisualsTab:AddLeftGroupbox('Grenades'),
    Lighting = Tabs.VisualsTab:AddRightGroupbox('Lighting'),
    Misc = Tabs.MiscTab:AddLeftGroupbox('Misc'),
    Player = Tabs.MiscTab:AddLeftGroupbox('Player'),
}

local FeatureTable = {
    Combat = {
        SilentAim = {Enabled = false, Hitchance = 100, DummyRange = 0, DynamicFOV = false},
        WallCheck = false,
        TeamCheck = false,
        Hitpart = "Head", --// 6 = Torso, 7 = Head
    },
    Visuals = {

        --// Features \\--

        Box = {Enabled = false, Color = Color3.fromRGB(255, 255, 255)},
        Box3D = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), Method = "Flat"},
        Tracers = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), Origin = "Middle", End = "Head"}, --// 7 = head, 6 = torso (index)
        Chams = {Enabled = false, FillColor = Color3.fromRGB(255, 255, 255), OutlineColor = Color3.fromRGB(255, 255, 255), VisibleOnly = false, FillTransparency = 0, OutlineTransparency = 0},
        Dynamic = true,
        TeamCheck = false,
        UseTeamColor = false, --// Team colors dont apply to chams btw

        --// Other \\--

        Lighting = {
            OverrideAmbient = {Enabled = false, Color = Color3.fromRGB(255, 255, 255)},
        },

        Grenade = {
            GrenadeESP = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), Transparency = 0},
            TrailModifier = {Enabled = false, Color = Color3.fromRGB(255, 255, 255), TrailLifetime = 0.55},
        }

    },
    Misc = {
        Player = {
            Fly = {Enabled = false, Speed = 0},
            Bhop = false,
            JumpPowerModifier = {Enabled = false, Power = 50},
            HipHeight = 0,
        }
    },
}

local Storage = {
    Identifiers = {
        Head = Vector3.new(1,1,1),
        Torso = Vector3.new(2,2,1),
    },
    BoxIndex = {
        {1, 2}, {2, 3}, {3, 4}, {4, 1},
        {5, 6}, {6, 7}, {7, 8}, {8, 5},
        {1, 5}, {2, 6}, {3, 7}, {4, 8} 
    },
    ESP = {
        Boxes = {},
        Box3D = {},
        Tracers = {},
        Chams = {},
    },
    Other = {
        ViewportSize = Camera.ViewportSize,
        ClosestPlayer = nil,
    },
}

local Functions = {
    Normal = {},
    ESP = {},
}

--// Objects

local FOVCircle = Drawing.new("Circle")
do --// Drawing object properties

    do --// Circle

        FOVCircle.Transparency = 1
        FOVCircle.Visible = false
        FOVCircle.Color = Color3.fromRGB(255, 255, 255)
        FOVCircle.Radius = 0
        
    end
    
end

local Watermark = Instance.new("ScreenGui", game.CoreGui)
do --// Properties & Rest

    local Main = Instance.new("Frame", Watermark)
    local UICorner = Instance.new("UICorner", Main)
    local Gradient = Instance.new("Frame", Main)
    local UIGradient = Instance.new("UIGradient", Gradient)
    local TextLabel = Instance.new("TextLabel", Main)
    
    do --// Properties
        Watermark.Enabled = false
        Watermark.Name = "Watermark"
    
        Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Main.BorderSizePixel = 0
        Main.Position = UDim2.new(0.00550314458, 0, 0.00746268639, 0)
        Main.Size = UDim2.new(0.245283023, 0, 0.043532338, 0)
        
        UICorner.CornerRadius = UDim.new(0, 2)
        
        Gradient.Name = "Gradient"
        Gradient.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Gradient.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Gradient.BorderSizePixel = 0
        Gradient.Size = UDim2.new(1, 0, 0.0857142881, 0)
        
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(43, 255, 114)), ColorSequenceKeypoint.new(0.38, Color3.fromRGB(255, 112, 150)), ColorSequenceKeypoint.new(0.51, Color3.fromRGB(85, 170, 255)), ColorSequenceKeypoint.new(0.71, Color3.fromRGB(85, 36, 255)), ColorSequenceKeypoint.new(0.77, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 139, 44))}
        UIGradient.Parent = Gradient
        
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0, 0, 0.0857142881, 0)
        TextLabel.Size = UDim2.new(1, 0, 0.914285719, 0)
        TextLabel.Font = Enum.Font.RobotoMono
        TextLabel.Text = "homohack | made by @dementia enjoyer"
        TextLabel.TextColor3 = Color3.fromRGB(247, 247, 247)
        TextLabel.TextSize = 12.000
        TextLabel.TextWrapped = true
        TextLabel.TextScaled = true
    end
end

--// Rest

do --// Main
    Library:Notify("I am aware of the optimization issues, they will be fixed in the near future", 5)

    do --// Elements

        do --// Aimbot Tab

            Sections.Aimbot:AddToggle('SilentAim', {
                Text = 'Silent Aim',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Combat.SilentAim.Enabled = Value
                end
            })

            Sections.Aimbot:AddToggle('VisualiseRange', {
                Text = 'Visualise Range',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FOVCircle.Visible = Value
                end
            }):AddColorPicker('VisualiseRangeColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Range Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FOVCircle.Color = Value
                end
            })

            Sections.Aimbot:AddToggle('DynamicRange', {
                Text = 'Dynamic Range',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Combat.SilentAim.DynamicFOV = Value
                end
            })
            Sections.Aimbot:AddSlider('AimbotRange', {
                Text = 'Range',
                Default = 0,
                Min = 0,
                Max = 1000,
                Rounding = 1,
                Compact = false,

                Callback = function(Value)
                    FeatureTable.Combat.SilentAim.DummyRange = Value --// im not gonna use flags, but feel free to switch to it :D
                end
            })

            Sections.Aimbot:AddDropdown('Aimpart', {
                Values = { 'Head', 'Torso', 'Random' },
                Default = 1,
                Multi = false,
            
                Text = 'Aim Part',
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Combat.Hitpart = Value
                end
            })

            --// Aimbot Settings

            Sections.AimbotSettings:AddToggle('WallCheck', {
                Text = 'Wall Check',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Combat.WallCheck = Value
                end
            })

            Sections.AimbotSettings:AddToggle('TeamCheck', {
                Text = 'Team Check',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Combat.TeamCheck = Value
                end
            })

            Sections.AimbotSettings:AddSlider('Hitchance', {
                Text = 'Hitchance',
                Default = 100,
                Min = 0,
                Max = 100,
                Rounding = 1,
                Compact = false,
            
                Callback = function(Value)
                    FeatureTable.Combat.SilentAim.Hitchance = Value
                end
            })
    
        end

        do --// Visuals Tab

            Sections.Visuals:AddToggle('Box', {
                Text = 'Box',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Box.Enabled = Value
                end
            }):AddColorPicker('BoxColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Box Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Box.Color = Value
                end
            })

            Sections.Visuals:AddToggle('Box3D', {
                Text = '3D Box',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Box3D.Enabled = Value
                end
            }):AddColorPicker('Box3DColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Box 3D Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Box3D.Color = Value
                end
            })

            Sections.Visuals:AddToggle('Tracers', {
                Text = 'Tracers',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.Enabled = Value
                end
            }):AddColorPicker('TracerColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Tracer Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.Color = Value
                end
            })

            Sections.Visuals:AddToggle('Chams', {
                Text = 'Chams',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.Enabled = Value
                end
            }):AddColorPicker('FillColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Fill Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.FillColor = Value
                end
            }):AddColorPicker('OutlineColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Outline Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.OutlineColor = Value
                end
            })

            --// Settings

            Sections.VisualSettings:AddToggle('ChamsVisOnly', {
                Text = 'Chams Visible Only',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.VisibleOnly = Value
                end
            })

            Sections.VisualSettings:AddToggle('TeamCheck', {
                Text = 'Team Check',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.TeamCheck = Value
                end
            })

            Sections.VisualSettings:AddToggle('TeamColors', {
                Text = 'Use Team Colors',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.UseTeamColor = Value
                end
            })

            Sections.VisualSettings:AddSlider('ChamFillTransparency', {
                Text = 'Cham Fill Transparency',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = false,

                Callback = function(Value)
                    FeatureTable.Visuals.Chams.FillTransparency = Value
                end
            })

            Sections.VisualSettings:AddSlider('ChamOutlineTransparency', {
                Text = 'Cham Outline Transparency',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = false,

                Callback = function(Value)
                    FeatureTable.Visuals.Chams.OutlineTransparency = Value
                end
            })

            Sections.VisualSettings:AddDropdown('Box3DSize', {
                Values = { 'Flat', 'Full' },
                Default = 1,
                Multi = false,
            
                Text = 'Box 3D Size',
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Box3D.Method = Value
                end
            })

            Sections.VisualSettings:AddDropdown('TracerOrigin', {
                Values = { 'Top', 'Middle', 'Bottom', 'Gun' },
                Default = 2,
                Multi = false,
            
                Text = 'Tracer Origin',
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.Origin = Value
                end
            })

            Sections.VisualSettings:AddDropdown('TracerEnd', {
                Values = { 'Head', 'Torso' },
                Default = 1,
                Multi = false,
            
                Text = 'Tracer End',
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.End = Value
                end
            })

            --// Lighting Section

            Sections.Lighting:AddToggle('OverrideAmbient', {
                Text = 'Override Ambient',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Lighting.OverrideAmbient.Enabled = Value
                end
            }):AddColorPicker('AmbientColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Ambient Color',
                Transparency = 0,
            
                Callback = function(Value)
                    if FeatureTable.Visuals.Lighting.OverrideAmbient.Enabled then
                        FeatureTable.Visuals.Lighting.OverrideAmbient.Color = Value
    
                        do --// Properties
                            
                            Functions.Normal:SetAmbient("Ambient", Value)
                            Functions.Normal:SetAmbient("OutdoorAmbient", Value)
                            Functions.Normal:SetAmbient("ColorShift_Top", Value)
                            Functions.Normal:SetAmbient("ColorShift_Bottom", Value)
                            
                        end
                    end
                end
            })

            --// Grenade Section

            Sections.Grenade:AddToggle('Grenade', {
                Text = 'Grenade ESP',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Grenade.GrenadeESP.Enabled = Value
                end
            }):AddColorPicker('GrenadeColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Grenade Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Grenade.GrenadeESP.Color = Value
                end
            })

            Sections.Grenade:AddToggle('TrailModifier', {
                Text = 'Trail Modifier',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Grenade.TrailModifier.Enabled = Value
                end
            }):AddColorPicker('TrailColor', {
                Default = Color3.fromRGB(255, 255, 255),
                Title = 'Trail Color',
                Transparency = 0,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Grenade.TrailModifier.Color = Value
                end
            })

            Sections.Grenade:AddSlider('TrailLifetime', {
                Text = 'Trail Lifetime',
                Default = 0.55,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            
                Callback = function(Value)
                    FeatureTable.Visuals.Grenade.TrailModifier.TrailLifetime = Value
                end
            })

        end

        do --// Misc Tab

            Sections.Misc:AddToggle('Watermark', {
                Text = 'Watermark',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    Watermark.Enabled = Value
                end
            })

            --// Player section

            Sections.Player:AddToggle('Fly', {
                Text = 'Fly',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.Fly.Enabled = Value
                end
            })

            Sections.Player:AddToggle('Bhop', {
                Text = 'Bhop',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.Bhop = Value
                end
            })

            Sections.Player:AddToggle('JumpModifier', {
                Text = 'Override Jump Power',
                Default = false,
                Tooltip = nil,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.JumpPowerModifier.Enabled = Value
                end
            })

            Sections.Player:AddSlider('JumpPower', {
                Text = 'Jump Power',
                Default = 0,
                Min = 0,
                Max = 80,
                Rounding = 1,
                Compact = false,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.JumpPowerModifier.Power = Value
                end
            })

            Sections.Player:AddSlider('HipHeight', {
                Text = 'Hip Height',
                Default = 0,
                Min = 0,
                Max = 50,
                Rounding = 1,
                Compact = false,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.HipHeight = Value
                end
            })

            Sections.Player:AddSlider('FlySpeed', {
                Text = 'Fly Speed',
                Default = 0,
                Min = 0,
                Max = 50,
                Rounding = 1,
                Compact = false,
            
                Callback = function(Value)
                    FeatureTable.Misc.Player.Fly.Speed = Value
                end
            })

        end
        
    end
    
    do --// Logic

        do --// Functions

            do --// Regular

                do --// Lighting

                    function Functions.Normal:SetAmbient(Property, Value)
                        if FeatureTable.Visuals.Lighting.OverrideAmbient.Enabled then
                            Lighting[Property] = Value
                        end
                    end
                    
                end

                do --// Players

                    function Functions.Normal:GetTeam(Player)
                        if Player ~= nil and Player.Parent ~= nil and Player:FindFirstChildOfClass("Folder") then
                            local Helmet = Player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
                            if Helmet then
                                if Helmet.BrickColor == BrickColor.new("Black") then
                                    return game.Teams.Phantoms
                                end
                                return game.Teams.Ghosts
                            end
                        end
                    end
                    function Functions.Normal:GetPlayerBodyparts(Player)
                        local Head
                        local Torso
                        local Children = Player:GetChildren()
                        local HeadSize = Storage.Identifiers.Head
                        local TorsoSize = Storage.Identifiers.Torso
                    
                        for i = 1, #Children do
                            local Child = Children[i]
                            if Child:IsA("BasePart") then
                                if Child.Size == HeadSize then
                                    Head = Child
                                elseif Child.Size == TorsoSize then
                                    Torso = Child
                                end
                            end
                        end
                    
                        return { Head = Head, Torso = Torso }
                    end                                      

                    function Functions.Normal:GetPlayers()
                        local PlayerList = {}
                        for i,Teams in Players:GetChildren() do
                            for i,Players in Teams:GetChildren() do
                                table.insert(PlayerList, Players)
                            end
                        end
                        return PlayerList
                    end
                    
                end
                
                do --// LocalPlayer
                    function Functions.Normal:GetGun()
                        for i,Viewmodel in Camera:GetChildren() do
                            if Viewmodel:IsA("Model") and not Viewmodel.Name:find("Arm") then
                                return Viewmodel
                            end
                        end
                        return nil
                    end
                end

                do --// Math

                    function Functions.Normal:Measure(Origin, End)
                        return (Origin - End).Magnitude
                    end

                    function Functions.Normal:GetLength(Table) --// This isnt even math btw, but its not related to any of the other sections so whatever lol
                        local Int = 0
                        for WhatTheSigma in Table do
                            Int += 1
                        end
                        return Int
                    end

                end
    
            end
    
            do --// Aimbot
                
                function Functions.Normal:getClosestPlayer()
                    local Player = nil
                    local Hitpart = nil
                    local Distance = math.huge
                
                    for i, Players in Functions.Normal:GetPlayers() do
                        if Players ~= nil then
                            local Bodyparts = Functions.Normal:GetPlayerBodyparts(Players)

                            local Screen = Camera:WorldToViewportPoint(Bodyparts.Torso.Position)
                            local MeasureDistance = (Vector2.new(Storage.Other.ViewportSize.X / 2, Storage.Other.ViewportSize.Y / 2) - Vector2.new(Screen.X, Screen.Y)).Magnitude
                
                            local PlayerIsVisible = (not FeatureTable.Combat.WallCheck) or Functions.Normal:PlayerVisible(Players, Camera.CFrame.Position, Bodyparts.Torso.Position, {Misc, Ignore, Players:FindFirstChildOfClass("Folder")})
                
                            if MeasureDistance < Distance and MeasureDistance <= FOVCircle.Radius * 1.25 and PlayerIsVisible then
                                Player = Players
                                Distance = MeasureDistance
                
                                if tostring(FeatureTable.Combat.Hitpart):find("Random") then
                                    print("Random")
                                    local Keys = {}
                
                                    do --// WhatTheSigma
                                        for WhatTheSigma in Storage.Identifiers do
                                            table.insert(Keys, WhatTheSigma)
                                        end
                                    end
                
                                    local Index = math.random(1, Functions.Normal:GetLength(Keys))
                                    local Rndm = Keys[Index]
                                    if Rndm ~= "Random" then
                                        Hitpart = Bodyparts[Rndm]
                                    end
                                else
                                    Hitpart = Bodyparts[FeatureTable.Combat.Hitpart]
                                end
                            end
                        end
                    end
                
                    return {Closest = Player, Hitpart = Hitpart}
                end

                function Functions.Normal:PlayerVisible(Player, Origin, End, Ignorelist)

                    local Params = RaycastParams.new()
                    do --// Param Properties

                        Params.FilterDescendantsInstances = Ignorelist
                        Params.FilterType = Enum.RaycastFilterType.Exclude
                        Params.IgnoreWater = true
                        
                    end

                    local CastRay = workspace:Raycast(Origin, End - Origin, Params)
                    if CastRay and CastRay.Instance then
                        if CastRay.Instance:IsDescendantOf(Player) then
                            return true
                        end
                    end
                    return false
        
                end
    
            end
    
            do --// ESP
                function Functions.ESP:Create(Player)
        
                    if FeatureTable.Visuals.Box.Enabled then

                        if not table.find(Storage.ESP.Boxes, Player) then
        
                            local Box = Drawing.new("Square")
                            Box.Color = Color3.fromRGB(255,255,255)
                            Box.Transparency = 1
                            Box.Visible = true
                            Box.Thickness = 1
                            Box.ZIndex = 2
                            
                            do --// Table insert
            
                                table.insert(Storage.ESP.Boxes, Box)
                                table.insert(Storage.ESP.Boxes, Player)
            
                            end
                    
                        end

                    end
                    if FeatureTable.Visuals.Tracers.Enabled then

                        if not table.find(Storage.ESP.Tracers, Player) then
        
                            local Tracer = Drawing.new("Line")
                            Tracer.Transparency = 1
                            Tracer.Visible = true
                            Tracer.Color = Color3.fromRGB(255,255,255)
                            
                            do --// Table insert
            
                                table.insert(Storage.ESP.Tracers, Tracer)
                                table.insert(Storage.ESP.Tracers, Player)
            
                            end
                    
                        end
                        
                    end
                    if FeatureTable.Visuals.Box3D.Enabled then
                        if not table.find(Storage.ESP.Box3D, Player) then
                            local Lines = {}
                            
                            for i = 1, 12 do
                                local Line = Drawing.new("Line")
                                Line.Transparency = 1
                                Line.Color = Color3.fromRGB(255, 255, 255)
                                Line.Visible = false
                                table.insert(Lines, Line)
                            end
                    
                            do --// Table insert
                                table.insert(Storage.ESP.Box3D, Lines)
                                table.insert(Storage.ESP.Box3D, Player)
                            end
                        end
                    end
        
                end
    
                function Functions.ESP:ClearTable(esps, esptable, index)
                    for i = 1, #esps do
                        esps[i]:Destroy()
                    end
                    do --// Table clear
                        table.remove(esptable, index)
                        table.remove(esptable, index-1)
                    end
                end

            end
    
        end
    
        do --// Loops
    
            task.spawn(function()
                while task.wait() do --// gl working with the dogshit code, skids :D
    
                    do --// Combat
    
                        do --// Aimbot
    
                            if FeatureTable.Combat.SilentAim.Enabled then

                                local Enemy = Storage.Other.ClosestPlayer
                                local Target = Enemy.Closest
                                if Target ~= nil and (FeatureTable.Combat.TeamCheck and Functions.Normal:GetTeam(Target) ~= game.Players.LocalPlayer.Team or not FeatureTable.Combat.TeamCheck) then

                                    local Hitpart = Enemy.Hitpart
                                    local Gun = Functions.Normal:GetGun()

                                    if Hitpart and Gun then
                                        for i, GunParts in Gun:GetChildren() do
                                            pcall(function()
                                                local Joints = GunParts:GetJoints()
                                                if GunParts.Name:find("SightMark") or GunParts.Name:find("FlameSUP") or GunParts.Name:find("Flame") then
                                                    local Vector = Vector3New()
                                    
                                                    do --// Hitchance

                                                        local Chance = FeatureTable.Combat.SilentAim.Hitchance
                                                        if Chance < 100 then --// Pretty awful but it works
                                                            local MissChance = (100 - Chance) / 100
                                                            local x = math.random() * 3 - 1
                                                            local y = math.random() * 3 - 1
                                                            local z = math.random() * 3 - 1 
                                                            Vector = Vector3New(x, y, z) * MissChance
                                                        end

                                                    end
                                    
                                                    Joints[1].C0 = Joints[1].Part0.CFrame:ToObjectSpace(CFrame.lookAt(Joints[1].Part1.Position, (Hitpart.Position + Vector)))
                                                end
                                            end)
                                        end
                                    end

                                end

                            end
                            
    
                        end
    
                    end
    
                    do --// Visuals

                        for i,Players in Functions.Normal:GetPlayers() do --// bro... so p1000
                            Functions.ESP:Create(Players)
                        end
    
                        do --// Box ESP
    
                            for i,Player in Storage.ESP.Boxes do --// Box logic (obviously)
                                if typeof(Player) == "Instance" then
    
                                    local Box = Storage.ESP.Boxes[i-1]
                    
                                    if FeatureTable.Visuals.Box.Enabled and Player:IsDescendantOf(workspace) and not tostring(Player:GetFullName()):find(tostring(DeadBodies)) then
                                        local Bodyparts = Functions.Normal:GetPlayerBodyparts(Player)
                                        local Torso = Bodyparts.Torso
                                        if Torso ~= nil then
                                            local Position, OnScreen = Camera:WorldToViewportPoint(Torso.Position) --// Convert to screen pos since we're rendering the boxes on the screen (duh)
    
                                            local Team = Functions.Normal:GetTeam(Player)
                                            local TeamColor = Team.TeamColor
                    
                                            if OnScreen and FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck then
                    
                                                local PosX = Position.X - (Box.Size.X / 2)
                                                local PosY = Position.Y - (Box.Size.Y / 2)
                                                local Scale = 1000/(Camera.CFrame.Position - Torso.Position).Magnitude*80/Camera.FieldOfView --// Very simple box distance scale
                                                
                                                Box.Position = Vector2.new(PosX, PosY)
                                                Box.Size = Vector2.new(2 * Scale, 3 * Scale)
                                                Box.Visible = true

                                                if FeatureTable.Visuals.UseTeamColor then --// 😭
                                                    if tostring(TeamColor) == "Bright blue" then
                                                        Box.Color = Color3.fromRGB(0, 162, 255)
                                                    elseif tostring(TeamColor) == "Bright orange" then
                                                        Box.Color = Color3.fromRGB(255, 162, 0)
                                                    end
                                                else
                                                    Box.Color = FeatureTable.Visuals.Box.Color
                                                end
                    
                                            else
                    
                                                Functions.ESP:ClearTable({Box}, Storage.ESP.Boxes, i)
                    
                                            end
                    
                                        else
                    
                                            Functions.ESP:ClearTable({Box}, Storage.ESP.Boxes, i)
                    
                                        end
                                    else
                    
                                        Functions.ESP:ClearTable({Box}, Storage.ESP.Boxes, i)
                    
                                    end
                                end
                            end

                        end

                        do --// 3D Box
                            for i, Player in Storage.ESP.Box3D do
                                if typeof(Player) == "Instance" then
                                    local Objects = Storage.ESP.Box3D[i-1]
                                    
                                    if Objects then
                                        if FeatureTable.Visuals.Box3D.Enabled then
                                            local Bodyparts = Functions.Normal:GetPlayerBodyparts(Player)
                                            local Torso = Bodyparts.Torso
                                            local Team = Functions.Normal:GetTeam(Player)
                                            
                                            if Player and Torso and not tostring(Player:GetFullName()):find(tostring(DeadBodies)) and Team and Team.TeamColor then
                                                local a, Visible = Camera:WorldToViewportPoint(Torso.Position)
                                                local TeamColor = Team.TeamColor
                                                local Size = Vector3.new(2, 3, 1.5)
                                                local Corners = {
                                                    Torso.CFrame * CFrameNew(-Size.X, Size.Y, -Size.Z),
                                                    Torso.CFrame * CFrameNew(Size.X, Size.Y, -Size.Z),
                                                    Torso.CFrame * CFrameNew(Size.X, -Size.Y, -Size.Z),
                                                    Torso.CFrame * CFrameNew(-Size.X, -Size.Y, -Size.Z),
                                                    Torso.CFrame * CFrameNew(-Size.X, Size.Y, Size.Z),
                                                    Torso.CFrame * CFrameNew(Size.X, Size.Y, Size.Z),
                                                    Torso.CFrame * CFrameNew(Size.X, -Size.Y, Size.Z),
                                                    Torso.CFrame * CFrameNew(-Size.X, -Size.Y, Size.Z)
                                                }
                                                
                                                if FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck then
                                                    if FeatureTable.Visuals.Box3D.Method == "Flat" then
                                                        for iA = 1, 4 do
                                                            local Line = Objects[iA]
                                                            Line.Visible = Visible
                                                            if Visible then
                                                                local Next = (iA % 4) + 1
                                                                local ScreenPos1 = Camera:WorldToViewportPoint(Corners[iA].Position)
                                                                local ScreenPos2 = Camera:WorldToViewportPoint(Corners[Next].Position)
                                                                
                                                                Line.From = Vector2.new(ScreenPos1.X, ScreenPos1.Y)
                                                                Line.To = Vector2.new(ScreenPos2.X, ScreenPos2.Y)
                                                                
                                                                if FeatureTable.Visuals.UseTeamColor then
                                                                    if tostring(TeamColor) == "Bright blue" then
                                                                        Line.Color = Color3.fromRGB(0, 162, 255)
                                                                    elseif tostring(TeamColor) == "Bright orange" then
                                                                        Line.Color = Color3.fromRGB(255, 162, 0)
                                                                    end
                                                                else
                                                                    Line.Color = FeatureTable.Visuals.Box3D.Color
                                                                end
                                                            end
                                                        end
                                                    else
                                                        for iB = 1, 12 do
                                                            local Line = Objects[iB]
                                                            Line.Visible = Visible
                                                            
                                                            if Visible then
                                                                local b = Storage.BoxIndex[iB]
                                                                local c = Camera:WorldToViewportPoint(Corners[b[1]].Position)
                                                                local d = Camera:WorldToViewportPoint(Corners[b[2]].Position)
                                                                
                                                                Line.From = Vector2.new(c.X, c.Y)
                                                                Line.To = Vector2.new(d.X, d.Y)
                                                                
                                                                if FeatureTable.Visuals.UseTeamColor then
                                                                    if tostring(TeamColor) == "Bright blue" then
                                                                        Line.Color = Color3.fromRGB(0, 162, 255)
                                                                    elseif tostring(TeamColor) == "Bright orange" then
                                                                        Line.Color = Color3.fromRGB(255, 162, 0)
                                                                    end
                                                                else
                                                                    Line.Color = FeatureTable.Visuals.Box3D.Color
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    Functions.ESP:ClearTable(Objects, Storage.ESP.Box3D, i)
                                                end
                                            else
                                                Functions.ESP:ClearTable(Objects, Storage.ESP.Box3D, i)
                                            end
                                        else
                                            Functions.ESP:ClearTable(Objects, Storage.ESP.Box3D, i)
                                        end
                                    end
                                end
                            end
                        end
                        do --// Tracer ESP

                            for i,Player in Storage.ESP.Tracers do --// Tracer logic (obviously once again)
                                if typeof(Player) == "Instance" then
    
                                    local Tracer = Storage.ESP.Tracers[i-1]
                    
                                    if FeatureTable.Visuals.Tracers.Enabled and Player:IsDescendantOf(workspace) then
                                        local Bodyparts = Functions.Normal:GetPlayerBodyparts(Player)
                                        local Target = Bodyparts[FeatureTable.Visuals.Tracers.End]
                                        if Target ~= nil and not tostring(Player:GetFullName()):find(tostring(DeadBodies)) then
                                            local Position, OnScreen = Camera:WorldToViewportPoint(Target.Position) --// Convert to screen pos since we're rendering the boxes on the screen (duh)
    
                                            local Team = Functions.Normal:GetTeam(Player)
                                            local TeamColor = Team.TeamColor
                    
                                            if OnScreen and FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck then
                                                
                                                local Origin = FeatureTable.Visuals.Tracers.Origin
                                                local Value
                                                if Origin ~= "Gun" then

                                                    if Origin == "Top" then
                                                        Value = 0 
                                                    elseif Origin == "Middle" then
                                                        Value = Storage.Other.ViewportSize.Y / 2
                                                    elseif Origin == "Bottom" then
                                                        Value = Storage.Other.ViewportSize.Y
                                                    end

                                                    Tracer.From = Vector2.new(Storage.Other.ViewportSize.X / 2, Value)
                                                    Tracer.To = Vector2.new(Position.X, Position.Y)

                                                else

                                                    local Gun = Functions.Normal:GetGun()
                                                    if Gun ~= nil and Gun:FindFirstChild("Flame") then
                                                        local TipPosition = Camera:WorldToViewportPoint(Gun["Flame"].Position) or Camera:WorldToViewportPoint(Gun["FlameSUP"].Position)
                                                        Tracer.From = Vector2.new(TipPosition.X, TipPosition.Y)
                                                        Tracer.To = Vector2.new(Position.X, Position.Y)
                                                    else
                                                        Functions.ESP:ClearTable({Tracer}, Storage.ESP.Tracers, i)
                                                    end

                                                end

                                                if FeatureTable.Visuals.UseTeamColor then
                                                    if tostring(TeamColor) == "Bright blue" then
                                                        Tracer.Color = Color3.fromRGB(0, 162, 255)
                                                    elseif tostring(TeamColor) == "Bright orange" then
                                                        Tracer.Color = Color3.fromRGB(255, 162, 0)
                                                    end
                                                else
                                                    Tracer.Color = FeatureTable.Visuals.Tracers.Color
                                                end
                    
                                            else
                    
                                                Functions.ESP:ClearTable({Tracer}, Storage.ESP.Tracers, i)
                    
                                            end
                    
                                        else
                    
                                            Functions.ESP:ClearTable({Tracer}, Storage.ESP.Tracers, i)
                    
                                        end
                                    else
                    
                                        Functions.ESP:ClearTable({Tracer}, Storage.ESP.Tracers, i)
                    
                                    end
                                end
                            end
                            
                        end

                        do --// Cham ESP

                            for i, Player in Functions.Normal:GetPlayers() do
                                if Player ~= nil then
                                    
                                    local Highlight = Player:FindFirstChildOfClass("Highlight")
                                    local Team = Functions.Normal:GetTeam(Player)
                                    local TeamColor = Team.TeamColor
                            
                                    if not tostring(Player:GetFullName()):find(tostring(DeadBodies)) and FeatureTable.Visuals.Chams.Enabled and (FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck) then
                                        
                                        if not Highlight then
                                            Highlight = Instance.new("Highlight", Player)
                                        end
                            
                                        Highlight.Enabled = true
                                        Highlight.Adornee = Player
                                        Highlight.FillColor = FeatureTable.Visuals.Chams.FillColor
                                        Highlight.OutlineColor = FeatureTable.Visuals.Chams.OutlineColor
                                        Highlight.FillTransparency = FeatureTable.Visuals.Chams.FillTransparency
                                        Highlight.OutlineTransparency = FeatureTable.Visuals.Chams.OutlineTransparency
                                        Highlight.DepthMode = FeatureTable.Visuals.Chams.VisibleOnly and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop

                                        if FeatureTable.Visuals.UseTeamColor then --// 😭
                                            if tostring(TeamColor) == "Bright blue" then
                                                Highlight.FillColor = Color3.fromRGB(0, 162, 255)
                                                Highlight.OutlineColor = Color3.fromRGB(0, 162, 255)
                                            elseif tostring(TeamColor) == "Bright orange" then
                                                Highlight.FillColor = Color3.fromRGB(255, 162, 0)
                                                Highlight.OutlineColor = Color3.fromRGB(255, 162, 0)
                                            end
                                        else
                                            Highlight.FillColor = FeatureTable.Visuals.Chams.FillColor
                                            Highlight.OutlineColor = FeatureTable.Visuals.Chams.OutlineColor
                                        end
                  
                                    else

                                        if Highlight then
                                            Highlight:Destroy()
                                        end

                                    end
									
                                end
                            end
                            
                        end
    
                    end

                    do --// Misc

                        do --// Player

                            local LocalPlayer = Ignore:FindFirstChild("RefPlayer")
                            if LocalPlayer then
                                local Humanoid = LocalPlayer:FindFirstChildOfClass("Humanoid")

                                do --// Player Modifications

                                    if Humanoid then
    
                                        if FeatureTable.Misc.Player.JumpPowerModifier.Enabled then
                                            Humanoid.JumpPower = FeatureTable.Misc.Player.JumpPowerModifier.Power
                                        end
                                        if FeatureTable.Misc.Player.Fly.Enabled then

                                            local Direction = Vector3New()

                                            if LocalPlayer then

                                                local LookVector = Camera.CFrame.LookVector * Vector3New(1, 0, 1)
                                                local Directions = { --// Very optimized real!
                                                    [Enum.KeyCode.W] = LookVector,
                                                    [Enum.KeyCode.S] = -LookVector,
                                                    [Enum.KeyCode.D] = Vector3New(-LookVector.Z, 0, LookVector.X),
                                                    [Enum.KeyCode.A] = Vector3New(LookVector.Z, 0, -LookVector.X),
                                                    [Enum.KeyCode.Space] = Vector3New(0, 5 * 5, 0),
                                                    [Enum.KeyCode.LeftControl] = Vector3New(0, -5 * 5, 0)
                                                }
                                                
                                                for Key, Dir in Directions do
                                                    if UserInputService:IsKeyDown(Key) then
                                                        Direction = Direction + Dir
                                                    end
                                                end
                                                
                                                if Direction.Magnitude > 0 then
                                                    Direction = Direction.Unit
                                                    LocalPlayer.HumanoidRootPart.Velocity = Direction * FeatureTable.Misc.Player.Fly.Speed
                                                    LocalPlayer.HumanoidRootPart.Anchored = false
                                                else
                                                    LocalPlayer.HumanoidRootPart.Velocity = Vector3New()
                                                    LocalPlayer.HumanoidRootPart.Anchored = true
                                                end

                                            end

                                        end
                                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) and FeatureTable.Misc.Player.Bhop then
                                            Humanoid.Jump = true
                                        end
                                        Humanoid.HipHeight = FeatureTable.Misc.Player.HipHeight
                                    
                                    end
                                    
                                end

                            end
                            
                        end
                        
                    end

                    do --// Extra

                        Storage.Other.ClosestPlayer = Functions.Normal:getClosestPlayer()
                        
                        do --// FOV Circle

                            local Dynamic = FeatureTable.Combat.SilentAim.DummyRange / math.tan(math.rad(Camera.FieldOfView / 2))
                            FOVCircle.Position = Vector2.new(Storage.Other.ViewportSize.X/2, Storage.Other.ViewportSize.Y/2)

                            if FeatureTable.Combat.SilentAim.DynamicFOV then
                                FOVCircle.Radius = Dynamic
                            else
                                FOVCircle.Radius = FeatureTable.Combat.SilentAim.DummyRange
                            end
                            
                        end

                    end
    
                end
            end)
    
        end
    
        do --// Connections
            
            Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                Storage.Other.ViewportSize = Camera.ViewportSize
            end)

            do --// Lighting (I love this part)

                Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
                    Functions.Normal:SetAmbient("Ambient", FeatureTable.Visuals.Lighting.OverrideAmbient.Color)
                end)

                Lighting:GetPropertyChangedSignal("OutdoorAmbient"):Connect(function()
                    Functions.Normal:SetAmbient("OutdoorAmbient", FeatureTable.Visuals.Lighting.OverrideAmbient.Color)
                end)

                Lighting:GetPropertyChangedSignal("ColorShift_Top"):Connect(function()
                    Functions.Normal:SetAmbient("ColorShift_Top", FeatureTable.Visuals.Lighting.OverrideAmbient.Color)
                end)

                Lighting:GetPropertyChangedSignal("ColorShift_Bottom"):Connect(function()
                    Functions.Normal:SetAmbient("ColorShift_Bottom", FeatureTable.Visuals.Lighting.OverrideAmbient.Color)
                end)
                
            end

            Misc.ChildAdded:Connect(function(Child)
                if tostring(Child.Name):find("Trigger") then 
                    if FeatureTable.Visuals.Grenade.GrenadeESP.Enabled then
                        local Billboard = Instance.new("BillboardGui", Child)
                        local Frame = Instance.new("Frame", Billboard)
                        local UICorner = Instance.new("UICorner", Frame)
                        
                        do --// Properties
                            do --// BillboardGui
                                Billboard.Enabled = true
                                Billboard.AlwaysOnTop = true
                                Billboard.Size = UDim2.new(1, 0, 1, 0)
                                Billboard.Adornee = Child
                            end
                            do --// Frame
                                Frame.Size = UDim2.new(1, 0, 1, 0)
                                Frame.BackgroundTransparency = FeatureTable.Visuals.Grenade.GrenadeESP.Transparency
                                Frame.BackgroundColor3 = FeatureTable.Visuals.Grenade.GrenadeESP.Color
                            end
                            do --// UICorner
                                UICorner.CornerRadius = UDim.new(0, 50)
                            end
                        end
                    end
                    if FeatureTable.Visuals.Grenade.TrailModifier.Enabled then
                        local Trail = Child:WaitForChild("Trail")
                        Trail.Lifetime = FeatureTable.Visuals.Grenade.TrailModifier.TrailLifetime
                        Trail.Color = ColorSequence.new(FeatureTable.Visuals.Grenade.TrailModifier.Color)
                    end
                end
            end)
            
            
        end
    
        --// Made by @dementia enjoyer 😁
    
    end
    
end

Library:OnUnload(function()
    Library.Unloaded = true
end)

local MenuGroup = Tabs['Settings']:AddLeftGroupbox('Menu')
MenuGroup:AddButton('Unload', function() Library:Unload() end)

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ 'MenuKeybind' })
ThemeManager:SetFolder('Homohack')
SaveManager:SetFolder('Homohack/PhantomForces')

SaveManager:BuildConfigSection(Tabs['Settings'])
ThemeManager:ApplyToTab(Tabs['Settings'])
SaveManager:LoadAutoloadConfig()
