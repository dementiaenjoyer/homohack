--// Made by dementia enjoyer <3
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

--// Defined

local Players = workspace.Characters
local Camera = workspace.CurrentCamera

--// Drawing

local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255, 255, 255)
FOV.Visible = true
FOV.Transparency = 1

--// Rest

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
                        if Chest then
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

                if Storage.Aimbot.ClosestPlayer ~= nil then
                    if Closest ~= nil and Closest:FindFirstChild("Body") and Closest["Body"]:FindFirstChild("Head") then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Closest["Body"]["Head"].Position)
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

                                Box.Visible = true
                                Box.Position = Vector2.new(ScreenPosition.X - (Box.Size.X / 2), ScreenPosition.Y - (Box.Size.Y / 2))
                                Box.Size = Vector2.new(3 * Scale, 4 * Scale)
                                
                            end

                            do --// Healthbar

                                Healthbar.Visible = true
                                Healthbar.Size = Vector2.new(2, Box.Size.Y * Health.Value / MaxHealth.Value)
                                Healthbar.Position = Vector2.new(Box.Position.X - 5, Box.Position.Y + (Box.Size.Y * (1 - Health.Value / MaxHealth.Value)))

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
