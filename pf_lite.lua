-- made by dementia enjoyer

-- ui

local repository = "https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/";

local lib = loadstring(game:HttpGet(repository .. "Library.lua"))();
local thememng = loadstring(game:HttpGet(repository .. "addons/ThemeManager.lua"))();
local savemng = loadstring(game:HttpGet(repository .. "addons/SaveManager.lua"))();

local window = lib:CreateWindow({
    Title = "homohack | lite",
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
});

local tabs = {
    combat_tab = window:AddTab("Aimbot"),
    visuals_tab = window:AddTab("Visuals"),
    settings = window:AddTab("Settings"),
}

local aimbot_section = tabs.combat_tab:AddLeftGroupbox("aimbot"); do

    aimbot_section:AddToggle("aimbot_enabled", {
        Text = "Aimbot",
        Default = false,
        Tooltip = nil,
    });

    aimbot_section:AddToggle("prediction_enabled", {
        Text = "Prediction",
        Default = false,
        Tooltip = nil,
    });

    aimbot_section:AddToggle("fov_circle_enabled", {
        Text = "Fov circle",
        Default = false,
        Tooltip = nil,
    }):AddColorPicker("fov_circle_color", {
        Default = Color3.fromRGB(255, 255, 255), 
        Title = "Color",
        Transparency = 0,
    });

    aimbot_section:AddSlider("fov_value", {
        Text = "Fov value",
        Default = 50,
        Min = 0,
        Max = 1000,
        Rounding = 1,
        Compact = false,
    })

    aimbot_section:AddSlider("aimbot_speed", {
        Text = "Aimbot Speed",
        Default = 5,
        Min = 0,
        Max = 10,
        Rounding = 1,
        Compact = false,
    })

    aimbot_section:AddSlider("prediction_value", {
        Text = "Prediction Value",
        Default = 2,
        Min = 0,
        Max = 10,
        Rounding = 1,
        Compact = false,
    })

    aimbot_section:AddDropdown("hitpart_value", {
        Values = { "Head", "Torso" },
        Default = 1,
        Multi = false,
        Text = "Hitpart",
    })

end

local visuals_section = tabs.visuals_tab:AddLeftGroupbox("visuals"); do

    visuals_section:AddToggle("box_enabled", {
        Text = "Box",
        Default = false,
        Tooltip = nil,
    }):AddColorPicker("box_color", {
        Default = Color3.fromRGB(255, 255, 255), 
        Title = "Color",
        Transparency = 0,
    });

    visuals_section:AddToggle("tracer_enabled", {
        Text = "Tracer",
        Default = false,
        Tooltip = nil,
    }):AddColorPicker("tracer_color", {
        Default = Color3.fromRGB(255, 255, 255), 
        Title = "Color",
        Transparency = 0,
    });

end

local menu_section = tabs["settings"]:AddLeftGroupbox("Menu"); do

    menu_section:AddButton("Unload", function() lib:Unload() end)
    menu_section:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "End", NoUI = true, Text = "Menu keybind" })

    lib.ToggleKeybind = Options.MenuKeybind

    thememng:SetLibrary(lib)
    savemng:SetLibrary(lib)
    savemng:IgnoreThemeSettings()

    savemng:SetIgnoreIndexes({ "MenuKeybind" })
    thememng:SetFolder("homohack")
    savemng:SetFolder("homohack/pf-lite")

    savemng:BuildConfigSection(tabs["settings"])
    thememng:ApplyToTab(tabs["settings"])
    savemng:LoadAutoloadConfig()
    
end

-- services

local run_service = game:GetService("RunService");
local players = game:GetService("Players");
local user_input_service = game:GetService("UserInputService");
local teams = game:GetService("Teams");

-- variables

local vec2 = Vector2.new
local vec3_zero = Vector3.zero
local round = math.round

local camera = workspace.CurrentCamera;
local storage = { closest_player = nil, bodyparts = {
    Head = "rbxassetid://6179256256",
    Torso = "rbxassetid://4049240078"
}, esp_cache = {}};
local funcs = {}; do

    -- players

    function funcs.get_players()

        local entity_list = {};

        for _, team in workspace.Players:GetChildren() do
            for _, player in team:GetChildren() do
                if player:IsA("Model") then
                    entity_list[#entity_list+1] = player;
                end
            end
        end

        return entity_list;

    end

    function funcs.get_team(player)

        local helmet = player:FindFirstChildWhichIsA("Folder") and player:FindFirstChildWhichIsA("Folder"):FindFirstChildOfClass("MeshPart");
        if not helmet then
            return nil;
        end
        
        if helmet.BrickColor == BrickColor.new("Black") then
            return teams.Phantoms;
        end
        return teams.Ghosts;
        
    end

    function funcs.get_bodypart(player, bodypart_name)

        for _, bodypart in player:GetChildren() do
            if bodypart:IsA("BasePart") then

                local mesh = bodypart:FindFirstChildOfClass("SpecialMesh");
                if mesh then
                    if mesh.MeshId == storage.bodyparts[bodypart_name] then
                        return bodypart;
                    end
                end

            end
        end

        return nil;
    end

    function funcs.get_closest_player()

        local closest, closest_distance = nil, math.huge;

        for _, player in funcs.get_players() do

            if funcs.get_team(player) == players.LocalPlayer.Team then
                continue;
            end

            local torso = funcs.get_bodypart(player, "Torso");

            if not torso then
                continue;
            end

            local w2s, onscreen = camera:WorldToViewportPoint(torso.Position);
            local distance = (vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2) - vec2(w2s.X, w2s.Y)).Magnitude;

            if onscreen and (closest_distance > distance) and Options.fov_value.Value > distance then
                closest = player;

                closest_distance = distance;

            end

        end

        return closest
        
    end

    -- esp

    function funcs.cache_object(object)

        if storage.esp_cache[object] == nil then

            storage.esp_cache[object] = {
                box_square = Drawing.new("Square"),
                tracer_line = Drawing.new("Line"),
            };

        end
        
    end

    function funcs.uncache_object(object)

        if storage.esp_cache[object] then
    
            for _, cached_instance in storage.esp_cache[object] do
                cached_instance:Destroy();
                cached_instance = nil;
            end

            storage.esp_cache[object] = nil;

        end
        
    end

    -- math

    function funcs.get_velocity(part)

        local velocity = Vector3.zero;
        local start_pos = part.Position;
    
        local dt = run_service.RenderStepped:Wait();
        local current_pos = part.Position;
    
        local delta = current_pos - start_pos;
    
        return velocity:Lerp(delta / dt, 0.07); -- for some reason it becomes retarded if we dont lerp it

    end
    
    
end
--

local fov_circle = Drawing.new("Circle");
fov_circle.Filled = false;

-- main

local main_renderstepped = run_service.RenderStepped:Connect(function(dt)

    -- aimbot
    
    if Toggles.aimbot_enabled.Value and user_input_service:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then

        local closest_player = funcs.get_closest_player();

        if closest_player then

            local hitpart = funcs.get_bodypart(closest_player, Options.hitpart_value.Value);
            
            if hitpart then

                local pos = hitpart.Position + (Toggles.prediction_enabled.Value and funcs.get_velocity(hitpart) * Options.prediction_value.Value or vec3_zero);
                local w2s = camera:WorldToViewportPoint(pos);
                --
                local delta_x = (w2s.X - (camera.ViewportSize.X / 2)) * Options.aimbot_speed.Value;
                local delta_y = (w2s.Y - (camera.ViewportSize.Y / 2)) * Options.aimbot_speed.Value;
                --
                mousemoverel(delta_x, delta_y);

            end

        end
        
    end

    -- esp

    for _, player in funcs.get_players() do
        if funcs.get_team(player) ~= players.LocalPlayer.Team then
            
            funcs.cache_object(player);

        end
    end

    for player, cache in storage.esp_cache do
        if player and cache then

            local torso = funcs.get_bodypart(player, "Torso");
            
            if torso then

                local w2s, onscreen = camera:WorldToViewportPoint(torso.Position);
    
                --
        
                local box_square = cache.box_square;
                local tracer_line = cache.tracer_line;
        
                --
            
                if onscreen then
        
                    local scale = 1000 / (camera.CFrame.Position - torso.Position).Magnitude * 80 / camera.FieldOfView;
                    local box_scale = vec2(round(3 * scale), round(4 * scale))

                    -- box
        
                    box_square.Visible = Toggles.box_enabled.Value;
                    box_square.Color = Options.box_color.Value;
                    box_square.Thickness = 1;
                    box_square.Position = vec2(round(w2s.X - (box_square.Size.X / 2)), round(w2s.Y - (box_square.Size.Y / 2)));
                    box_square.Size = box_scale;
                    box_square.Filled = false;

                    -- tracers

                    tracer_line.Visible = Toggles.tracer_enabled.Value;
                    tracer_line.From = vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
                    tracer_line.To = vec2(round(box_square.Position.X + (box_square.Size.X / 2)), round(box_square.Position.Y + (box_square.Size.Y)));
                    tracer_line.Color = Options.tracer_color.Value;
            
                else
            
                    funcs.uncache_object(player);
                    
                end

            else

                funcs.uncache_object(player);
                
            end

        else

            funcs.uncache_object(player);

        end
    end

    -- settings

    fov_circle.Visible = Toggles.fov_circle_enabled.Value;
    fov_circle.Position = vec2(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2);
    fov_circle.Radius = Options.fov_value.Value;
    fov_circle.Color = Options.fov_circle_color.Value;
    
end)

lib:SetWatermarkVisibility(false);
lib.KeybindFrame.Visible = false;
