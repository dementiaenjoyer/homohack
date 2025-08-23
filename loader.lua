local cloneref = cloneref or function(Service) return Service; end

-- Services
local function GetService(Service)
	return cloneref(game:GetService(Service));
end

local HttpService = GetService("HttpService");
local Players = GetService("Players");
local RunService = GetService("RunService");

-- Functions
local Loader = {};
Loader.SELECTED = "";

local Github = {}; do
	Github.USER_AGENT = "homohack";
	Github.ERROR = "Failed to retrieve";

	Github.OWNER = "dementiaenjoyer";
	Github.REPO = "homohack";
	Github.URL = "https://api.github.com";

	function Github:GetUpdate(Name)
		local Error = self.ERROR;
		local Success, Response = pcall(function()
			return game:HttpGet(string.format("%s/repos/%s/%s/commits?path=%s&per_page=1", self.URL, self.OWNER, self.REPO, HttpService:UrlEncode(Name)), false, {
				["User-Agent"] = self.USER_AGENT,
				["Accept"] = "application/vnd.github.v3+json"
			});
		end)

		if (not Success) then
			return Error;
		end

		local RetrievedCommits, Commits = pcall(function()
			return HttpService:JSONDecode(Response);
		end)

		if (not RetrievedCommits) then
			return Error;
		end

		if (typeof(Commits) ~= "table" or #Commits == 0) then
			return Error;
		end

		local LatestUpdate = Commits[1];

		if (not LatestUpdate or not LatestUpdate.commit) then
			return Error;
		end

		LatestUpdate = LatestUpdate.commit;

		return LatestUpdate.author.date, LatestUpdate.message;
	end

	function Github:GetAllFiles()
		local Success, Response = pcall(function()
			return game:HttpGet(string.format("%s/repos/%s/%s/contents/%s", self.URL, self.OWNER, self.REPO, ""), true, {
				["User-Agent"] = self.USER_AGENT,
				["Accept"] = "application/vnd.github.v3+json"
			});
		end)

		if (not Response) then
			return {};
		end

		local Success, Files = pcall(function()
			return HttpService:JSONDecode(Response);
		end)

		return Files;
	end
end

local Elements = {}; do
	function Elements:New(Class, Properties)
		local Object = Instance.new(Class);

		for Property, Value in Properties do
			Object[Property] = Value;
		end

		return Object;
	end
end

-- Variables
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = (RunService:IsStudio() and LocalPlayer.PlayerGui) or GetService("CoreGui");

local GothamFont = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal);

-- Main
do
	local LoaderUI = Elements:New("ScreenGui", {
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		Parent = PlayerGui;
	});

	local Holder = Elements:New("Frame", {
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.fromRGB(16, 16, 16);
		Size = UDim2.new(0.271032, 0, 0.445187, 0);
		Position = UDim2.new(0.364177, 0, 0.27664, 0);
		BorderColor3 = Color3.fromRGB(0, 0, 0);
		Parent = LoaderUI;
	}); do
		local Bottom = Elements:New("Frame", {
			BorderSizePixel = 0;
			BackgroundColor3 = Color3.fromRGB(22, 22, 22);
			Size = UDim2.new(1, 0, 0.119911, 0);
			Position = UDim2.new(-4.20141e-07, 0, 0.878709, 0);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Parent = Holder;
		});

		local UIStroke_4 = Elements:New("UIStroke", {
			Color = Color3.fromRGB(45, 45, 45);
			Parent = Bottom;
		});

		local UICorner_4 = Elements:New("UICorner", {
			CornerRadius = UDim.new(0, 4);
			Parent = Bottom;
		});

		local LoadButton = Elements:New("TextButton", {
			TextWrapped = true;
			BorderSizePixel = 0;
			AutoButtonColor = false;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(24, 24, 24);
			FontFace = GothamFont;
			TextSize = 14;
			Size = UDim2.new(0.366775, 0, 0.725145, 0);
			Position = UDim2.new(0.614016, 0, 0.124863, 0);
			TextColor3 = Color3.fromRGB(255, 255, 255);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Text = "Load";
			Parent = Bottom;
		}); do
			local UICorner_3 = Elements:New("UICorner", {
				CornerRadius = UDim.new(0, 4);
				Parent = LoadButton;
			});

			local UIStroke_3 = Elements:New("UIStroke", {
				Color = Color3.fromRGB(45, 45, 45);
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Parent = LoadButton;
			});

			LoadButton.MouseButton1Click:Connect(function()
				local Selected = Loader.SELECTED;

				if (string.len(Selected) == 0) then
					return;
				end

				loadstring(game:HttpGet(`https://raw.githubusercontent.com/{Github.OWNER}/{Github.REPO}/refs/heads/main/{Selected}`))();

				return LoaderUI:Destroy();
			end)
		end

		local LastUpdate = Elements:New("TextLabel", {
			TextWrapped = true;
			BorderSizePixel = 0;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(24, 24, 24);
			FontFace = GothamFont;
			Position = UDim2.new(0.0247809, 0, 0.124863, 0);
			TextSize = 14;
			Size = UDim2.new(0.565022, 0, 0.725144, 0);
			TextColor3 = Color3.fromRGB(255, 255, 255);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Text = "Updated: Reselect to refresh.";
			Parent = Bottom;
		}); do
			local UICorner_5 = Elements:New("UICorner", {
				CornerRadius = UDim.new(0, 4);
				Parent = LastUpdate;
			});

			local UIStroke_5 = Elements:New("UIStroke", {
				Color = Color3.fromRGB(45, 45, 45);
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Parent = LastUpdate;
			});
		end

		local ScrollingFrame = Elements:New("ScrollingFrame", {
			BorderSizePixel = 0;
			MidImage = "rbxassetid://132155326";
			TopImage = "";
			Position = UDim2.new(-0.00295157, 0, 0.127748, 0);
			BackgroundTransparency = 1;
			AutomaticCanvasSize = Enum.AutomaticSize.Y;
			Active = true;
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			Size = UDim2.new(1.00295, 0, 0.75096, 0);
			ScrollBarImageColor3 = Color3.fromRGB(31, 31, 31);
			ScrollBarThickness = 8; 
			BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			BottomImage = "rbxassetid://0";
			Parent = Holder;
		}); do
			local UIPadding = Elements:New("UIPadding", {
				PaddingTop = UDim.new(0, 15);
				Parent = ScrollingFrame;
			});

			local UIGridLayout = Elements:New("UIGridLayout", {
				CellSize = UDim2.new(0.9, 0, 0.15, 0);
				SortOrder = Enum.SortOrder.LayoutOrder;
				HorizontalAlignment = Enum.HorizontalAlignment.Center;
				Parent = ScrollingFrame;
			});

			local BLACKLISTED_NAMES = {"LICENSE", "README.md", "loader.lua"};

			for _, Data in Github:GetAllFiles() do
				local Name = Data.name;

				if (not Name) or (Data.type ~= "file") or (table.find(BLACKLISTED_NAMES, Name)) then
					continue;
				end

				local Template = Elements:New("Frame", {
					BorderSizePixel = 0;
					BackgroundColor3 = Color3.fromRGB(24, 24, 24);
					Size = UDim2.new(0.0746269, 0, 0.118483, 0);
					BorderColor3 = Color3.fromRGB(0, 0, 0);
					Parent = ScrollingFrame;
				}); do
					local UIStroke_2 = Elements:New("UIStroke", {
						Color = Color3.fromRGB(45, 45, 45);
						Parent = Template;
					});

					local UICorner_2 = Elements:New("UICorner", {
						CornerRadius = UDim.new(0, 4);
						Parent = Template;
					});

					local TextButton = Elements:New("TextButton", {
						TextWrapped = true;
						BorderSizePixel = 0;
						TextScaled = true;
						BackgroundColor3 = Color3.fromRGB(255, 255, 255);
						FontFace = GothamFont;
						TextSize = 14;
						Size = UDim2.new(1, 0, 1, 0);
						TextColor3 = Color3.fromRGB(255, 255, 255);
						BorderColor3 = Color3.fromRGB(0, 0, 0);
						Text = `Select {string.upper(Name)}`;
						BackgroundTransparency = 1;
						Parent = Template;
					}); do
						TextButton.MouseButton1Click:Connect(function()
							Loader.SELECTED = Name;
							LastUpdate.Text = `Updated: {Github:GetUpdate(Name)}`;
						end)
					end
				end
			end
		end
	end

	local UIStroke = Elements:New("UIStroke", {
		Color = Color3.fromRGB(45, 45, 45);
		Parent = Holder;
	});

	local Top = Elements:New("Frame", {
		BorderSizePixel = 0;
		BackgroundColor3 = Color3.fromRGB(22, 22, 22);
		Size = UDim2.new(1, 0, 0.127896, 0);
		Position = UDim2.new(-3.86005e-07, 0, 0, 0);
		BorderColor3 = Color3.fromRGB(0, 0, 0);
		Parent = Holder;
	}); do
		local Title = Elements:New("TextLabel", {
			Text = "homohack";
			TextWrapped = true;
			BorderSizePixel = 0;
			TextScaled = true;
			BackgroundColor3 = Color3.fromRGB(255, 255, 255);
			FontFace = GothamFont;
			TextSize = 14;
			Size = UDim2.new(1, 0, 1, 0);
			TextColor3 = Color3.fromRGB(255, 255, 255);
			BorderColor3 = Color3.fromRGB(0, 0, 0);
			BackgroundTransparency = 1;
			Parent = Top;
		}); do
			local UIGradient = Elements:New("UIGradient", {
				Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 255, 0)), ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)) };
				Parent = Title;
			});
		end

		local UIDragDetector = Elements:New("UIDragDetector", {
			BoundingUI = LoaderUI;
			ReferenceUIInstance = Top;
			Parent = Holder;
		});

		local UICorner = Elements:New("UICorner", {
			CornerRadius = UDim.new(0, 4);
			Parent = Top;
		});

		local UIStroke_1 = Elements:New("UIStroke", {
			Color = Color3.fromRGB(45, 45, 45);
			Parent = Top;
		});
	end

	local UICorner_1 = Elements:New("UICorner", {
		CornerRadius = UDim.new(0, 4);
		Parent = Holder;
	});
end
