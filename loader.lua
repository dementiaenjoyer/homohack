-- this code is awful so dont mind it plz
local players = game:GetService("Players");
local run_service = game:GetService("RunService");
local user_input_service = game:GetService("UserInputService");
local tween_service = game:GetService("TweenService");
local core_gui = game:GetService("CoreGui");

local loader = Instance.new("ScreenGui", core_gui);

local games = {
	{ name = "Phantom Forces", link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/pf_lite_rewrite_demo"},
	{ name = "Bad Business", link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/main/bad_business.lua" },
	{ name = "Fisch", link = "https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/fisch.lua"},
    { name = "Frontlines" },
	{ name = "Scorched Earth"},
};

local custom_callbacks = {
	["Scorched Earth"] = function()
		local teleport_service = game:GetService("TeleportService");

		if (game.GameId == 4785126950) then
			players.LocalPlayer:Kick("Run the scorched earth script inside of another game, like 'a literal baseplate'. Homohack will teleport you");
			return;
		end

        setfflag("DebugRunParallelLuaOnMainThread", "True");

		teleport_service:Teleport(13794093709, players.LocalPlayer);
		queue_on_teleport([[
    		repeat task.wait() until game:IsLoaded();
    		loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/scorched_earth.lua"))();
		]]);
	end,

    ["Frontlines"] = function()
        local success = false;

        if (run_on_actor) then
            success = true;

            run_on_actor(getactors()[1], [=[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/frontlines.lua"))();
            ]=]);
        elseif (run_on_thread and getactorthreads) then
            success = true;

            run_on_thread(getactorthreads()[1], [=[
                loadstring(game:HttpGet("https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/frontlines.lua"))();
            ]=]);
        end

        if (not success) then
            players.LocalPlayer:Kick("Your executor does not support 'run_on_actor' or 'run_on_thread'");
        end
    end
};

local holder_stroke = Instance.new("UIStroke");
holder_stroke.Color = Color3.fromRGB(24, 24, 24);
holder_stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;

-- ui
do
	local dragging = false;
	local mouse_start = nil;
	local frame_start = nil;
	
	local main = Instance.new("Frame", loader); do
		main.BackgroundColor3 = Color3.fromRGB(12, 12, 12);
		main.BorderColor3 = Color3.fromRGB(0, 0, 0);
		main.BorderSizePixel = 0;
		main.Position = UDim2.new(0.427201211, 0, 0.393133998, 0);
		main.Size = UDim2.new(0.145, 0, 0.267, 0, 0);
	end
	
	local title = Instance.new("TextLabel", main); do
		title.BackgroundColor3 = Color3.fromRGB(13, 13, 13);
		title.BorderColor3 = Color3.fromRGB(0, 0, 0);
		title.BorderSizePixel = 0;
		title.Position = UDim2.new(0.0361463465, 0, 0.0199999996, 0);
		title.Size = UDim2.new(0.926784515, 0, 0.112490386, 0);
		title.Font = Enum.Font.RobotoMono;
		title.Text = "homohack";
		title.TextColor3 = Color3.fromRGB(255, 255, 255);
		title.TextStrokeTransparency = 0.000;
		title.TextWrapped = true;
		title.TextSize = 18;
		
		title.InputBegan:Connect(function(input)
			if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragging = true;
				mouse_start = user_input_service:GetMouseLocation();
				frame_start = main.Position;
			end
		end)

		user_input_service.InputChanged:Connect(function(input)
			if (dragging and input.UserInputType == Enum.UserInputType.MouseMovement) then
				local delta = user_input_service:GetMouseLocation() - mouse_start;
				tween_service:Create(main, TweenInfo.new(0.1), {Position = UDim2.new(frame_start.X.Scale, frame_start.X.Offset + delta.X, frame_start.Y.Scale, frame_start.Y.Offset + delta.Y)}):Play();
			end
		end)
		
		user_input_service.InputEnded:Connect(function(input)
			if (dragging) then
				dragging = false;
			end
		end)
	end
	
	local ui_stroke = Instance.new("UIStroke", main); do
		ui_stroke.Thickness = 2;
		ui_stroke.Color = Color3.fromRGB(255, 255, 255);
	end
	
	local ui_gradient = Instance.new("UIGradient", ui_stroke); do
		ui_gradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 70, 73)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
		});
	end

	local ui_corner = Instance.new("UICorner", title); do
		ui_corner.CornerRadius = UDim.new(0, 2);
	end

	local holder = Instance.new("Frame", main); do
		holder.BackgroundColor3 = Color3.fromRGB(13, 13, 13);
		holder.BorderColor3 = Color3.fromRGB(0, 0, 0);
		holder.BorderSizePixel = 0;
		holder.Position = UDim2.new(0.0361457169, 0, 0.167407826, 0);
		holder.Size = UDim2.new(0.926784515, 0, 0.781875908, 0);
	end
	
	local stroke = holder_stroke:Clone(); do
		stroke.Parent = holder;
	end

	local ui_corner_2 = Instance.new("UICorner", holder); do
		ui_corner_2.CornerRadius = UDim.new(0, 4);
	end

	local scrolling_frame = Instance.new("ScrollingFrame", holder); do
		scrolling_frame.Active = true;
		scrolling_frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		scrolling_frame.BackgroundTransparency = 1.000;
		scrolling_frame.BorderColor3 = Color3.fromRGB(0, 0, 0);
		scrolling_frame.BorderSizePixel = 0;
		scrolling_frame.Position = UDim2.new(0, 0, 3.04931473e-06, 0);
		scrolling_frame.Size = UDim2.new(1, 0, 0.999999821, 0);
		scrolling_frame.CanvasSize = UDim2.new(0, 0, 5, 0);
	end

	local ui_padding = Instance.new("UIPadding", scrolling_frame); do
		ui_padding.PaddingTop = UDim.new(0, 10);
	end

	local ui_grid_layout = Instance.new("UIGridLayout", scrolling_frame); do
		ui_grid_layout.HorizontalAlignment = Enum.HorizontalAlignment.Center;
		ui_grid_layout.SortOrder = Enum.SortOrder.LayoutOrder;
		ui_grid_layout.CellPadding = UDim2.new(0, 10, 0, 10);
		ui_grid_layout.CellSize = UDim2.new(0, 165, 0, 25);
	end
	
	local heartbeat = nil;

	for _, supported_game in games do
		local name = supported_game.name;
		local text_button = Instance.new("TextButton", scrolling_frame); do
			text_button.MouseButton1Click:Connect(function()
				local custom_callback = custom_callbacks[name];
				
				if (not custom_callback) then
					loadstring(game:HttpGet(supported_game.link))();
                else
                    custom_callback();
				end

                heartbeat:Disconnect();
                loader:Destroy();
			end);
			
			text_button.Text = `load {supported_game.name}`;
			text_button.BackgroundColor3 = Color3.fromRGB(14, 14, 14);
			text_button.BorderColor3 = Color3.fromRGB(0, 0, 0);
			text_button.BorderSizePixel = 0;
			text_button.Size = UDim2.new(0.14958863, 0, 0.0553709865, 0);
			text_button.Font = Enum.Font.RobotoMono;
			text_button.TextColor3 = Color3.fromRGB(255, 255, 255);
			text_button.TextSize = 12.000;
			text_button.TextWrapped = true;
		end

		local stroke = holder_stroke:Clone(); do
			stroke.Parent = text_button;
		end

		local ui_corner_3 = Instance.new("UICorner", text_button); do
			ui_corner_3.CornerRadius = UDim.new(0, 4);
		end
	end
	
	heartbeat = run_service.Heartbeat:Connect(function()
		ui_gradient.Rotation += 4;
	end)
end
