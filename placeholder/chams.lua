--// small placeholder while i update :)
--// vars

local players = workspace.Players

--// services

local run_service = game:GetService("RunService")
local teams = game:GetService("Teams")
local plr_service = game:GetService("Players")

--// tables

local features = {
    chams = {teamcheck = true, color = {fill = Color3.fromRGB(121, 106, 255), outline = Color3.fromRGB(119, 121, 255)}, transparency = {fill = 0, outline = 0}}
}

--// functions

function get_players()
    local entity_list = {}
    for _, teams in players:GetChildren() do
        for _, player in teams:GetChildren() do
            if player:IsA("Model") then
                entity_list[#entity_list+1] = player
            end
        end
    end
    return entity_list
end

function is_ally(player)

    if not player then
        return
    end

    local helmet = player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart")

    if not helmet then
        return
    end

    if helmet.BrickColor == BrickColor.new("Black") then
        return teams.Phantoms == plr_service.LocalPlayer.Team, teams.Phantoms
    end

    return teams.Ghosts == plr_service.LocalPlayer.Team, teams.Ghosts

end

--// logic

run_service.RenderStepped:Connect(function(delta)

    for _, player in get_players() do

        if not player:FindFirstChildWhichIsA("Highlight") then

            local is_ally, team = is_ally(player)

            if (features.chams.teamcheck and not is_ally) or not features.chams.teamcheck then
                
                local highlight = Instance.new("Highlight", player)
            
                highlight.FillColor = features.chams.color.fill
                highlight.OutlineColor = features.chams.color.outline
            
                highlight.FillTransparency = features.chams.transparency.fill
                highlight.OutlineTransparency = features.chams.transparency.outline

            end
            
        end

    end

end)
