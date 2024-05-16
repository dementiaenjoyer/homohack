--// Have fun pasting, made the code extra messy just for you 😁
--// Made by @dementia enjoyer

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "homohack", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

--// Defined

local Camera = workspace.CurrentCamera
local Players = workspace.Players
local Mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

--// Tables

local Tabs = {
    AimbotTab = Window:MakeTab({
        Name = "Aimbot",
    }),
    VisualTab = Window:MakeTab({
        Name = "Visuals",
    }),
    MiscTab = Window:MakeTab({
        Name = "Misc",
    })
}

local FeatureTable = {
    Combat = {
        SilentAim = false,
        TeamCheck = false,
        Hitpart = 7, --// 6 = Torso, 7 = Head
    },
    Visuals = {
        Box = {Enabled = false, Color = Color3.fromRGB(255, 255, 255)},
        Tracers = {Enabled = false, Color = Color3.fromRGB(255, 255, 255)},
        Chams = {Enabled = false, FillColor = Color3.fromRGB(255, 255, 255), OutlineColor = Color3.fromRGB(255, 255, 255), VisibleOnly = false, Transparency = .5},

        TeamCheck = false,
        UseTeamColor = false, --// Team colors dont apply to chams btw
    },
    Misc = {
        Bhop = true,
        Watermark = true,
    },
}

local Storage = {
    Index = {
        Head = 7,
        Torso = 6,
    },
    ESP = {
        Boxes = {},
        Tracers = {},
        Chams = {},
    },
    Other = {
        ViewportSize = Camera.ViewportSize
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
        Watermark.Enabled = FeatureTable.Misc.Watermark
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

    do --// Notifications

        OrionLib:MakeNotification({
            Name = "whats good buddy",
            Content = "Enjoy the script! and if you decide pasting, i made the code extra messy just for you!",
            Time = 5
        })
        
    end

    do --// Elements

        do --// Aimbot Tab

            Tabs.AimbotTab:AddToggle({
                Name = "Silent Aim",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Combat.SilentAim = Value
                end    
            })

            Tabs.AimbotTab:AddToggle({
                Name = "TeamCheck",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Combat.TeamCheck = Value
                end    
            })
    
            Tabs.AimbotTab:AddToggle({
                Name = "Visualise Range",
                Default = false,
                Callback = function(Value)
                    FOVCircle.Visible = Value
                end    
            })
    
            Tabs.AimbotTab:AddDropdown({
                Name = "Hitpart",
                Default = "Head",
                Options = {"Head", "Torso"},
                Callback = function(Value)
                    FeatureTable.Combat.Hitpart = Storage.Index[Value]
                end    
            })
    
            Tabs.AimbotTab:AddSlider({
                Name = "Range",
                Min = 0,
                Max = 1000,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 1,
                Callback = function(Value)
                    FOVCircle.Radius = Value
                end
            })
            
    
        end

        do --// Visuals Tab

            Tabs.VisualTab:AddToggle({
                Name = "Box",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Visuals.Box.Enabled = Value
                end    
            })

            Tabs.VisualTab:AddToggle({
                Name = "Tracer",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.Enabled = Value
                end    
            })

            Tabs.VisualTab:AddToggle({
                Name = "Chams",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.Enabled = Value
                end    
            })

            Tabs.VisualTab:AddToggle({
                Name = "Team Check",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Visuals.TeamCheck = Value
                end    
            })

            Tabs.VisualTab:AddToggle({
                Name = "Team Colors",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Visuals.UseTeamColor = Value
                end    
            })

            Tabs.VisualTab:AddColorpicker({
                Name = "Box Color",
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(Value)
                    FeatureTable.Visuals.Box.Color = Value
                end	  
            })

            Tabs.VisualTab:AddColorpicker({
                Name = "Tracer Color",
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(Value)
                    FeatureTable.Visuals.Tracers.Color = Value
                end	  
            })

            Tabs.VisualTab:AddColorpicker({
                Name = "Fill Color",
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.FillColor = Value
                end	  
            })

            Tabs.VisualTab:AddColorpicker({
                Name = "Outline Color",
                Default = Color3.fromRGB(255, 255, 255),
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.OutlineColor = Value
                end	  
            })

            Tabs.VisualTab:AddSlider({
                Name = "Cham transparency",
                Min = 0,
                Max = 1,
                Default = 0,
                Color = Color3.fromRGB(255,255,255),
                Increment = 0.1,
                Callback = function(Value)
                    FeatureTable.Visuals.Chams.Transparency = Value
                end
            })

        end

        do --// Misc Tab

            Tabs.MiscTab:AddToggle({
                Name = "Watermark",
                Default = false,
                Callback = function(Value)
                    Watermark.Enabled = Value
                end    
            })

            Tabs.MiscTab:AddToggle({
                Name = "BHop",
                Default = false,
                Callback = function(Value)
                    FeatureTable.Misc.Bhop = Value
                end    
            })

        end
        
    end
    
    do --// Logic

        do --// Functions

            do --// Regular
                function Functions.Normal:GetTeam(Player)
                    if Player ~= nil and Player.Parent ~= nil and Player:FindFirstChildOfClass("Folder") then
                        local Helmet = Player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")
                        if Helmet then
                            if Helmet.BrickColor == BrickColor.new("Black") then
                                return game.Teams.Phantoms
                            else
                                return game.Teams.Ghosts
                            end
                        end
                    end
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
        
                function Functions.Normal:Measure(Origin, End)
                    return (Origin - End).Magnitude
                end
    
                function Functions.Normal:GetGun()
                    for i,Viewmodel in Camera:GetChildren() do
                        if Viewmodel:IsA("Model") and not Viewmodel.Name:find("Arm") then
                            return Viewmodel
                        end
                    end
                    return nil
                end
            end
    
            do --// Aimbot
                
                function Functions.Normal:getClosestPlayer()
                    local Player = nil
                    local Distance = math.huge
                    for i,Players in Functions.Normal:GetPlayers() do
                        if Players ~= nil then
                            local Hitpart = Players:GetChildren()[FeatureTable.Combat.Hitpart]
                            local Screen = Camera:WorldToViewportPoint(Hitpart.Position)
                            local MeasureDistance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Screen.X, Screen.Y)).Magnitude
                            if MeasureDistance < Distance and MeasureDistance <= FOVCircle.Radius*1.25 then --// not how  you actually get an accurate circle but i dont care lol...
                                Player = Players
                                Distance = MeasureDistance
                            end
                        end
                    end
                    return Player
                end
    
            end
    
            do --// ESP
                function Functions.ESP:Create(Player)
        
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
    
                            if FeatureTable.Combat.SilentAim then
                                local Target = Functions.Normal:getClosestPlayer()
                                if Target ~= nil and (FeatureTable.Combat.TeamCheck and Functions.Normal:GetTeam(Target) ~= game.Players.LocalPlayer.Team or not FeatureTable.Combat.TeamCheck) then

                                    local Hitpart = Target:GetChildren()[FeatureTable.Combat.Hitpart]
                                    local Gun = Functions.Normal:GetGun()
                            
                                    if Hitpart and Gun then
                                        for i, Stuff in pairs(Gun:GetChildren()) do
                                            local Joints = Stuff:GetJoints()
                                            if Stuff.Name:find("SightMark") or Stuff.Name:find("FlameSUP") or Stuff.Name:find("Flame") then
                                                Joints[1].C0 = Joints[1].Part0.CFrame:ToObjectSpace(CFrame.lookAt(Joints[1].Part1.Position, Hitpart.Position))
                                            end
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
                    
                                    if FeatureTable.Visuals.Box.Enabled and Player:IsDescendantOf(workspace) then
                                        local Torso = Player:GetChildren()[6]
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

                        do --// Tracer ESP

                            for i,Player in Storage.ESP.Tracers do --// Tracer logic (obviously once again)
                                if typeof(Player) == "Instance" then
    
                                    local Tracer = Storage.ESP.Tracers[i-1]
                    
                                    if FeatureTable.Visuals.Tracers.Enabled and Player:IsDescendantOf(workspace) then
                                        local Torso = Player:GetChildren()[6]
                                        if Torso ~= nil then
                                            local Position, OnScreen = Camera:WorldToViewportPoint(Torso.Position) --// Convert to screen pos since we're rendering the boxes on the screen (duh)
    
                                            local Team = Functions.Normal:GetTeam(Player)
                                            local TeamColor = Team.TeamColor
                    
                                            if OnScreen and FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck then
                                                
                                                Tracer.From = Vector2.new(Storage.Other.ViewportSize.X/2,Storage.Other.ViewportSize.Y/2) --// Set origin to center of screen cuz screen size divided by 2 is center
                                                Tracer.To = Vector2.new(Position.X, Position.Y)
                                                
                                                if FeatureTable.Visuals.UseTeamColor then --// emm
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
                            
                                    if FeatureTable.Visuals.Chams.Enabled and (FeatureTable.Visuals.TeamCheck and tostring(Team) ~= game.Players.LocalPlayer.Team.Name or not FeatureTable.Visuals.TeamCheck) then
                                        
                                        if not Highlight then
                                            Highlight = Instance.new("Highlight", Player)
                                        end
                            
                                        Highlight.Enabled = true
                                        Highlight.Adornee = Player
                                        Highlight.FillColor = FeatureTable.Visuals.Chams.FillColor
                                        Highlight.OutlineColor = FeatureTable.Visuals.Chams.OutlineColor
                                        Highlight.FillTransparency = FeatureTable.Visuals.Chams.Transparency
                                        Highlight.OutlineTransparency = FeatureTable.Visuals.Chams.Transparency
                                        Highlight.DepthMode = FeatureTable.Visuals.Chams.VisibleOnly and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
                  
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
    
                        do --// Bhop

                            if FeatureTable.Misc.Bhop and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                                local LocalPlayer = workspace.Ignore:FindFirstChild("RefPlayer")
                                if LocalPlayer then
                                    local Humanoid = LocalPlayer:FindFirstChildOfClass("Humanoid")
                                    if Humanoid then
                                        Humanoid.Jump = true
                                    end
                                end
                            end

                        end
                        
                    end

                    do --// Extra
                        FOVCircle.Position = Vector2.new(Storage.Other.ViewportSize.X/2, Storage.Other.ViewportSize.Y/2)
                    end
    
                end
            end)
    
        end
    
        do --// Connections
            
            Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
                Storage.Other.ViewportSize = Camera.ViewportSize
            end)
            
        end
    
        --// Made by @dementia enjoyer 😁
    
    end
    
end

OrionLib:Init()
