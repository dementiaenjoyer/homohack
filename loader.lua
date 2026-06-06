--[[
    some things to know:
        this was rushed together and the entire goal is to expand executor support; compatability is prioritized over everything else
        changes will be made as time goes on, and this will eventually be cleaned up.
        the code isn't the best, and it's not supposed to be

    if you are some insufferable chud which starts sperging out when you see bad code, i recommend not scrolling down.
]]

local Directory = "Homohack";

-- Configuration
local Development = false;
local DebugMode = false;

local Game = game;

local DummyFunction = function( ... )
	local Callback = select( 1, ... );
	
	if ( type( Callback ) == "function" ) then
		return Callback( );
	end
	
	return ...;
end

local IsParallel = ( ( isparallel or is_parallel ) or DummyFunction );
local QueueOnTeleport = ( queue_on_teleport or DummyFunction );
local CloneReference = ( cloneref or DummyFunction );

local SetFastFlag = ( setfflag or DummyFunction );

-- Services
local UserInputService = CloneReference( Game : GetService( "UserInputService" ) );
local TeleportService = CloneReference( Game : GetService( "TeleportService" ) );

local HttpService = CloneReference( Game : GetService( "HttpService" ) );
local TextService = CloneReference( Game : GetService( "TextService" ) );

local RunService = CloneReference( Game : GetService( "RunService" ) );
local Players = CloneReference( Game : GetService( "Players" ) );

local CoreGui = ( RunService : IsStudio( ) and Players.LocalPlayer.PlayerGui ) or ( gethui or DummyFunction( function( )
	return CloneReference( Game : GetService( "CoreGui" ) );
end ) )( );

-- Cache
local EnumUserInputTypeMouseButton1 = Enum.UserInputType.MouseButton1;
local EnumFillDirectionVertical = Enum.FillDirection.Vertical;

local EnumTextYAlignment = Enum.TextYAlignment;
local EnumTextXAlignment = Enum.TextXAlignment;

local EnumTextYAlignmentBottom = EnumTextYAlignment.Bottom;
local EnumTextXAlignmentCenter = EnumTextXAlignment.Center;

local EnumSortOrderLayoutOrder = Enum.SortOrder.LayoutOrder;
local EnumZIndexBehaviorGlobal = Enum.ZIndexBehavior.Global;

local EnumTextXAlignmentLeft = EnumTextXAlignment.Left;
local EnumLineJoinModeMiter = Enum.LineJoinMode.Miter;

local EnumBorderModeMiddle = Enum.BorderMode.Middle;
local EnumBorderModeInset = Enum.BorderMode.Inset;

local ColorSequenceKeypointNew = ColorSequenceKeypoint.new;
local ColorSequenceNew = ColorSequence.new;

local UDim2FromOffset = UDim2.fromOffset;
local InstanceNew = Instance.new;

local Color3FromRGB = Color3.fromRGB;
local Color3New = Color3.new;

local HttpGet = Game.HttpGet;
local UDim2New = UDim2.new;

local StringUpper = string.upper;
local StringLower = string.lower;

local StringMatch = string.match;

local StringFind = string.find;
local StringGSub = string.gsub;
local StringSub = string.sub;

local Vector2New = Vector2.new;

local SetMetatable = setmetatable;
local LoadString = loadstring;

local ProtectedCall = pcall;

local ToNumber = tonumber;
local ToString = tostring;

local WriteFile = writefile;
local ReadFile = readfile;
local IsFile = isfile;

local UDim2FromScale = UDim2.fromScale;

local Color3FromHSV = Color3.fromHSV;
local Color3ToHSV = Color3.toHSV;

local UDimNew = UDim.new;

local TableInsert = table.insert;
local TableRemove = table.remove;

local MathClamp = math.clamp;
local MathFloor = math.floor;

local TableFind = table.find;
local OSTime = os.time;

local MathHuge = math.huge;

-- Constants
local WindowSize = Vector2New( 300, 193 );

local White = Color3New( 1, 1, 1 );
local Black = Color3New( 0, 0, 0 );

-- Variables
local KeySystems, InParallel = { }, { }; do
	KeySystems[ "PF Main" ] = 1;

	-- Scripts which need to be ran in parallel
	do
		InParallel[ "Scorched Earth" ] = 1;
		InParallel[ "Operation One" ] = 1;

        InParallel[ "Frontlines" ] = 1;
		InParallel[ "PF Main" ] = 1;
	end
end

local LocalPlayer = Players.LocalPlayer;
local Mouse = CloneReference( LocalPlayer : GetMouse( ) );

-- Functions
local GitHub = { }; do
    local BlacklistedFiles, UpdateCache = { }, { }; do
        BlacklistedFiles[ "homohack.lua" ] = 1;
        BlacklistedFiles[ "loader.lua" ] = 1;
    end

    local Owner = "dementiaenjoyer";
    local UserAgent = "homohack";

    function GitHub : GetUpdate( Name )
        if ( Development ) then
            return "10 days";
        end

        local Cache = UpdateCache[ Name ];
        local Result = "Unknown";

        if ( Cache ) then
            return Cache;
        end

        local Success, Response = ProtectedCall( function( )
            local EndPoint = `https://api.github.com/repos/{ Owner }/{ UserAgent }/commits?path={ HttpService:UrlEncode( Name ) }&per_page=1`;

            return HttpGet( Game, EndPoint, true, {
                [ "Accept" ] = "application/vnd.github.v3+json",
                [ "User-Agent" ] = UserAgent,
            } );
        end )

        if ( not Success ) or ( not Response ) then
            return Result;
        end

        local CommitSuccess, Commits = ProtectedCall( function( )
            return HttpService : JSONDecode( Response );
        end )

        if ( not CommitSuccess ) or ( type( Commits ) ~= "table" ) or ( #Commits == 0 ) then
            return Result;
        end

        local LatestCommit = Commits[ 1 ];

        local Commit = LatestCommit and LatestCommit.commit;
        local Author = Commit and Commit.author;

        if ( not Commit ) or ( not Author ) then
            return Result;
        end

        -- Trigger warning: poetry (claude blessed me up with this, no point in spending time on it)
        do
            local function PluralOrNah( Value, Unit )
                return `{ Value } { Unit }{ Value == 1 and "" or "s" }`;
            end

            local Year, Month, Day, Hour, Min, Sec = StringMatch( Author.date, "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)Z" );

            if ( not Year ) then
                return Result;
            end

            local Delta = OSTime( ) - OSTime( {
                [ "month" ] = ToNumber( Month ),
                [ "year" ] = ToNumber( Year ),
                
                [ "hour" ] = ToNumber( Hour ),
                [ "day" ] = ToNumber( Day ),
                
                [ "min" ] = ToNumber( Min ),
                [ "sec" ] = ToNumber( Sec ),
            } );

            if ( Delta >= 31557600 ) then
                Result = PluralOrNah( MathFloor( Delta / 31557600 ), "year" );
            end

            if ( Delta >= 2629800 ) and ( Delta < 31557600 ) then
                Result = PluralOrNah( MathFloor( Delta / 2629800 ), "month" );
            end

            if ( Delta >= 604800 ) and ( Delta < 2629800 ) then
                Result = PluralOrNah( MathFloor( Delta / 604800 ), "week" );
            end

            if ( Delta >= 86400 ) and ( Delta < 604800 ) then
                Result = PluralOrNah( MathFloor( Delta / 86400 ), "day" );
            end

            if ( Delta >= 3600 ) and ( Delta < 86400 ) then
                Result = PluralOrNah( MathFloor( Delta / 3600 ), "hour" );
            end

            if ( Delta >= 60 ) and ( Delta < 3600 ) then
                Result = PluralOrNah( MathFloor( Delta / 60 ), "minute" );
            end

            if ( Delta < 60 ) then
                Result = PluralOrNah( Delta, "second" );
            end
        end

        UpdateCache[ Name ] = Result;

        return Result;
    end

    function GitHub : GetScripts( )
        local Result = { };

        if ( Development ) then
            local OperationOne = { }; do
                OperationOne[ "name" ] = "operation_one.lua";
                OperationOne[ "type" ] = "file";

                TableInsert( Result, OperationOne );
            end

            local PFMain = { }; do
                PFMain[ "name" ] = "pf_main.lua";
                PFMain[ "type" ] = "file";

                TableInsert( Result, PFMain );
            end

            local Empty = { }; do
                Empty[ "name" ] = "empty.lua";
                Empty[ "type" ] = "file";

                TableInsert( Result, Empty );
            end
            
            Result.OperationOne = OperationOne;
            Result.Empty = Empty;

            self.Scripts = Result;

            return Result;
        end

        local ContentSuccess, ContentResponse = ProtectedCall( function( )
            local EndPoint = `https://api.github.com/repos/{ Owner }/{ UserAgent }/contents`;

			return HttpGet( Game, EndPoint, true, {
				[ "Accept" ] = "application/vnd.github.v3+json",
                [ "User-Agent" ] = UserAgent,
			} );
		end )

		if ( not ContentSuccess ) or ( not ContentResponse )  then
			return Result;
		end

		local Success, Scripts = ProtectedCall( function()
			return HttpService : JSONDecode( ContentResponse );
		end )

        if ( not Success ) then
            return LocalPlayer : Kick( `It seems like GitHub has ratelimited you, please re-execute the script with a VPN. ({ Scripts })` );
        end

        for Index, Value in Scripts do
            local Name = Value.name;
            local Type = Value.type;

            if ( not Name ) or ( not Type ) or ( Type ~= "file" ) or BlacklistedFiles[ Name ] then
                continue;
            end

            if ( StringSub( Name, StringFind( Name, "%." ) or 0 ) ~= ".lua" ) then
                continue;
            end

            TableInsert( Result, Value );
        end

        self.Scripts = Result;

        return Result;
    end

    GitHub.Scripts = { };
end

local Loader = { }; do
	Loader.Scripts = { [ 1 ] = { name = "Getting scripts .. If it stays like this, re-execute the script with a VPN.", failed = true } };
    Loader.Actor = nil;

    function Loader : Execute( Source, Parallel )
		if ( not Source ) or ( not Flags ) then
			return;
		end
		
		local Success, Result = ProtectedCall( function( )
            local CompatabilityMode = Flags[ "Main / CompatabilityMode" ].Value; do
                if ( CompatabilityMode ) then -- DrawingImmediate wrapper
                    -- One shotgun shell please!
                    Source = ( ( 'getgenv( ).DrawingImmediate = loadstring( game : HttpGet( "https://raw.githubusercontent.com/dementiaenjoyer/homohack/refs/heads/main/Compatability/DrawingImmediate.lua" ) )( );\n' .. "\n" ).. [[
                    local CoreGui = game : GetService( "CoreGui" );

                    local Folder = CoreGui : WaitForChild( "TopBarApp", 9e9 );
                    local TopBar = Folder : WaitForChild( "TopBarApp", 9e9 );

                    while ( not TopBar.Enabled ) do
                        task.wait( .5 );
                    end

                    local Icon = TopBar : WaitForChild( "MenuIconHolder", 9e9 );
                    
                    while ( true ) do
                        local StateOverlayRound = TopBar : FindFirstChild( "StateOverlayRound", true );

                        if ( StateOverlayRound ) and ( StateOverlayRound.Visible ) then
                            break;
                        end

                        task.wait( .5 );
                    end

                    ]] .. Source );

                    if ( DebugMode ) then
                        writefile( "HHACK.txt", Source );
                    end
                end
            end local ForceParallelFlag = "DebugRunParallelLuaOnMainThread";

            local Key = `{ Directory }/Key.hhack`;
			local Actor = self.Actor;

            if ( IsFile( Key ) ) then
                Source = `getgenv( ).script_key = "{ ReadFile( Key ) or "" }"\n` .. Source;
            end
			
			if ( Actor ) and ( not IsParallel( ) ) and ( not CompatabilityMode ) then
				local LoadFunction = run_on_thread; do
                    local Type = type( Actor );

                    if ( Type == "Instance" ) or ( Type == "userdata" ) or ( not LoadFunction ) then
                        LoadFunction = run_on_actor;
                    end
                end

				local Executed, Output = ProtectedCall( function( )
					return ( LoadFunction or DummyFunction )( Actor, Source );
				end )
				
				if ( not Executed ) then
					return LocalPlayer : Kick( `Failed to run script in parallel, your executor is likely not supported: { Output }` );
				end

                return;
			end

            if ( CompatabilityMode and Parallel ) then
                local SetterType = self : GetFlagSetType( true );

				if ( not SetterType ) then
					return LocalPlayer : Kick( "Last compatability resort failed, your executor cannot run scripts in parallel." );
				end

				SetFastFlag( ForceParallelFlag, SetterType );
                QueueOnTeleport( Source );

                return TeleportService : TeleportToPlaceInstance( Game.PlaceId, Game.JobId, LocalPlayer );
            end

            LoadString( Source )( );
		end )
		
		if ( not Success ) then
            return LocalPlayer : Kick( `Failed to run script: { Result }` );
		end
	end

	function Loader : GetFlagSetType( Value )
		local FastFlag, Counter = "BaseWrapVerticesModified", 0; -- [[ BOOLEAN ]]

		local function GetDataType( Param )
			if ( ProtectedCall( function( )	SetFastFlag( FastFlag, Param ) end ) ) then
				return Param;
			end
			
			local Result = nil; do
				Counter += 1;
				
                if ( Counter >= 3 ) then
					Result = GetDataType( Value );
				end

				if ( Counter < 3 ) then
					Result = GetDataType( StringGSub( Param, "^%l", StringUpper ) );
				end
			end
			
			return Result;
		end
		
		return GetDataType( ToString( Value ) );
	end

    function Loader : FormatString( Value )
        if ( not Value ) or ( #Value <= 0 ) then
            return "";
        end

        return StringGSub( StringGSub( StringGSub( StringMatch( Value, "([^/%]]+)%.lua" ) or Value, "%.lua$", "" ), "([%a%d]+)", function( String )
            if ( #String <= 2 ) then
                return StringUpper( String )
            end

            return StringUpper( StringSub( String, 1, 1 ) ) .. StringLower( StringSub( String, 2 ) );
        end ), "_+", " " );
    end

    function Loader : GetScriptNames( )
        local Result = { };

        for Name, _ in self.Scripts do
            TableInsert( Result, Name );
        end

        return Result;
    end

    function Loader : GetScripts( )
        local Scripts = GitHub : GetScripts( );

        if ( not Scripts ) or ( #Scripts <= 0 ) then
            return;
        end

        self.Scripts = ( function( )
            local Result = { };

            for Index, Data in Scripts do
                Result[ self : FormatString( Data.name or "" ) ] = Data;
            end

            return Result;
        end )( );
    end

	function Loader : GetActor( )
		local GetDeletedActors = getdeletedactors;
		local GetActorThreads = getactorthreads;
		
		if ( not GetActorThreads ) and ( not GetDeletedActors ) then
			return;
		end
		
		local Actors = GetActorThreads and GetActorThreads( ) or GetDeletedActors( );
		
		if ( not Actors ) then
			return;
		end
		
		self.Actor = Actors[ 1 ];
	end
	
	Loader : GetScripts( );
    Loader : GetActor( );
end

-- Classes
local Library = { }; do
    Library.__index = Library;

    local StandardGradient = ColorSequenceNew( {
        ColorSequenceKeypointNew( 0, White );
        ColorSequenceKeypointNew( 1, Color3FromRGB( 120, 120, 120 ) );
    } );

    function Library : Initiate( Parent )
        local Self = setmetatable( { }, Library );

        Self.BackgroundColor = Color3FromRGB( 12, 12, 12 );

        Self.AccentColor = Color3FromRGB( 174, 147, 255 );
        Self.OutlineColor = Color3FromRGB( 29, 29, 29 );

        Self.FontColor = Color3FromRGB( 255, 255, 255 );
        Self.MainColor = Color3FromRGB( 16, 16, 16 );
        
        Self.Black = Color3New( 0, 0, 0 );
        Self.Font = Enum.Font.Code;

        Self.OpenedFrames = { };
        Self.RegistryMap = { };
        
        Self.Signals = { };
        Self.Windows = { };
        
        Self.Toggles = { };
        Self.Options = { };

        local ScreenGui = InstanceNew( "ScreenGui" ); do
            ScreenGui.ZIndexBehavior = EnumZIndexBehaviorGlobal;
            ScreenGui.Parent = Parent or LocalPlayer.PlayerGui;
        end

        Self.AccentColorDark = Self : GetDarkerColor( Self.AccentColor );
        Self.ScreenGui = ScreenGui;

        return Self;
    end

    function Library : Create( Class, Properties )
        local Instance = type( Class ) == "string" and InstanceNew( Class ) or Class;

        for Key, Value in next, Properties do
            Instance[ Key ] = Value;
        end

        return Instance;
    end

    function Library : CreateLabel( Properties )
        local Label = self : Create( "TextLabel", {
            BackgroundTransparency = 1;
            Font = self.Font;
            TextColor3 = self.FontColor;
            TextSize = 16;
            TextStrokeTransparency = 1;
        } );

        self : Create( "UIStroke", {
            Color = Color3New( 0, 0, 0 );
            Thickness = 1;
            LineJoinMode = EnumLineJoinModeMiter;
            Parent = Label;
        } );

        self.RegistryMap[ Label ] = { TextColor3 = "FontColor" };

        return self : Create( Label, Properties );
    end

    function Library : GetDarkerColor( Color )
        local H, S, V = Color3ToHSV( Color );
        return Color3FromHSV( H, S, V / 1.5 );
    end

    function Library : MouseIsOverOpenedFrame( )
        for Frame in next, self.OpenedFrames do
            local Position = Frame.AbsolutePosition;
            local Size = Frame.AbsoluteSize;

            local WithinX = Mouse.X >= Position.X and Mouse.X <= Position.X + Size.X;
            local WithinY = Mouse.Y >= Position.Y and Mouse.Y <= Position.Y + Size.Y;

            if ( WithinX and WithinY ) then
                return true;
            end
        end
    end

    function Library : OnHighlight( HoverInstance, ColorInstance, OnState, OffState )
        HoverInstance.MouseEnter : Connect( function( )
            for Property, Value in next, OnState do
                ColorInstance[ Property ] = self[ Value ] or Value;
            end
        end );

        HoverInstance.MouseLeave : Connect( function( )
            for Property, Value in next, OffState do
                ColorInstance[ Property ] = self[ Value ] or Value;
            end
        end );
    end

    function Library : MakeDraggable( Frame, Cutoff )
        Frame.Active = true;

        Frame.InputBegan : Connect( function( Input )
            if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                return;
            end

            local Offset = Vector2New( Mouse.X - Frame.AbsolutePosition.X, Mouse.Y - Frame.AbsolutePosition.Y );

            if ( Offset.Y > ( Cutoff or 40 ) ) then
                return;
            end

            while UserInputService : IsMouseButtonPressed( EnumUserInputTypeMouseButton1 ) do
                Frame.Position = UDim2New( 0, Mouse.X - Offset.X, 0, Mouse.Y - Offset.Y );
                RunService.RenderStepped : Wait( );
            end
        end );
    end

    function Library : SafeCallback( Callback, ... )
        if ( not Callback ) then
            return;
        end

        local Success, Error = pcall( Callback, ... );

        if ( not Success ) then
            warn( Error );
        end
    end

    function Library : GiveSignal( Signal )
        TableInsert( self.Signals, Signal );
    end

    function Library : Unload( )
        for Index = #self.Signals, 1, -1 do
            TableRemove( self.Signals, Index ) : Disconnect( );
        end

        self.ScreenGui : Destroy( );
    end

    function Library : AddToolTip( InfoString, HoverInstance )
        local Tooltip = self : Create( "Frame", {
            BackgroundColor3 = self.MainColor;
            BorderColor3 = self.OutlineColor;
            Size = UDim2FromOffset( 0, 0 );
            ZIndex = 100;
            Visible = false;
            Parent = self.ScreenGui;
        } );

        self : CreateLabel( {
            Position = UDim2FromOffset( 3, 1 );
            Size = UDim2New( 1, -6, 1, -2 );
            TextSize = 13;
            Text = InfoString;
            TextXAlignment = EnumTextXAlignmentLeft;
            ZIndex = 101;
            Parent = Tooltip;
        } );

        local TextBounds = TextService : GetTextSize( InfoString, 13, self.Font, Vector2New( MathHuge, MathHuge ) );
        Tooltip.Size = UDim2FromOffset( TextBounds.X + 8, TextBounds.Y + 4 );

        local IsHovering = false;

        HoverInstance.MouseEnter : Connect( function( )
            if ( self : MouseIsOverOpenedFrame( ) ) then
                return;
            end

            IsHovering = true;
            Tooltip.Visible = true;

            while ( IsHovering ) do
                Tooltip.Position = UDim2FromOffset( Mouse.X + 14, Mouse.Y + 10 );
                RunService.Heartbeat : Wait( );
            end
        end );

        HoverInstance.MouseLeave : Connect( function( )
            IsHovering = false;
            Tooltip.Visible = false;
        end );
    end

    function Library : Resize( NewSize )
        for _, Holder in next, self.Windows do
            Holder.Size = NewSize;
        end
    end

    function Library : CreateWindow( Config )
        if ( type( Config ) ~= "table" ) then
            Config = { Title = tostring( Config ) };
        end

        Config.Title = Config.Title or "Window";
        
        Config.Size = type( Config.Size ) == "UDim2" and Config.Size or UDim2FromOffset( 320, 400 );
        Config.Position = type( Config.Position ) == "UDim2" and Config.Position or UDim2FromOffset( 175, 50 );

        local Object = self;
        local Window = { };

        local Holder = self : Create( "Frame", {
            BackgroundTransparency = 1;
            BorderSizePixel = 0;
            Position = Config.Position;
            Size = Config.Size;
            ZIndex = 1;
            Parent = self.ScreenGui;
        } );

        TableInsert( self.Windows, Holder );

        local Outer = self : Create( "Frame", {
            BackgroundColor3 = self.Black;
            BorderSizePixel = 0;
            Size = UDim2FromScale( 1, 1 );
            ZIndex = 1;
            Parent = Holder;
        } );

        self : MakeDraggable( Holder, 22 );

        local Inner = self : Create( "Frame", {
            BackgroundColor3 = self.MainColor;
            BorderColor3 = self.AccentColor;
            BorderMode = EnumBorderModeInset;
            Position = UDim2New( 0, 1, 0, 1 );
            Size = UDim2New( 1, -2, 1, -2 );
            ZIndex = 1;
            Parent = Outer;
        } );

        self : CreateLabel( {
            Size = UDim2New( 1, -14, 0, 22 );
            Position = UDim2New( 0, 7, 0, 0 );
            Text = Config.Title;
            TextXAlignment = EnumTextXAlignmentCenter;
            ZIndex = 2;
            Parent = Inner;
        } );

        self : Create( "Frame", {
            BackgroundColor3 = self.AccentColor;
            BorderSizePixel = 0;
            Position = UDim2New( 0, 0, 0, 22 );
            Size = UDim2New( 1, 0, 0, 1 );
            ZIndex = 3;
            Parent = Inner;
        } );

        local Scroll = self : Create( "ScrollingFrame", {
            BackgroundColor3 = self.BackgroundColor;
            BorderColor3 = self.OutlineColor;
            Position = UDim2New( 0, 6, 0, 28 );
            Size = UDim2New( 1, -12, 1, -34 );
            CanvasSize = UDim2New( 0, 0, 0, 0 );
            ScrollBarThickness = 3;
            ScrollBarImageColor3 = self.AccentColor;
            TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
            BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
            ZIndex = 2;
            Parent = Inner;
        } );

        local Layout = self : Create( "UIListLayout", {
            Padding = UDimNew( 0, 6 );
            FillDirection = EnumFillDirectionVertical;
            SortOrder = EnumSortOrderLayoutOrder;
            Parent = Scroll;
        } );

        self : Create( "UIPadding", {
            PaddingLeft = UDimNew( 0, 6 );
            PaddingRight = UDimNew( 0, 6 );
            PaddingTop = UDimNew( 0, 6 );
            Parent = Scroll;
        } );

        Layout : GetPropertyChangedSignal( "AbsoluteContentSize" ) : Connect( function( )
            Scroll.CanvasSize = UDim2FromOffset( 0, Layout.AbsoluteContentSize.Y + 12 );
        end );

        --{ Window } Methods
        do
            function Window : AddBlank( Size )
                Object : Create( "Frame", {
                    BackgroundTransparency = 1;
                    Size = UDim2New( 1, 0, 0, Size );
                    ZIndex = 1;
                    Parent = Scroll;
                } );
            end

            function Window : AddDivider( )
                local DividerOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    Size = UDim2New( 1, -4, 0, 5 );
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 6;
                    Parent = DividerOuter;
                } );
            end

            function Window : AddLabel( Text, DoesWrap )
                local Label = { };

                local TextLabel = Object : CreateLabel( {
                    Size = UDim2New( 1, -4, 0, 15 );
                    TextSize = 14;
                    RichText = true;
                    Text = Text;
                    TextWrapped = DoesWrap or false;
                    TextXAlignment = EnumTextXAlignmentLeft;
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                function Label : SetText( NewText )
                    TextLabel.Text = NewText;
                end

                Label.GuiObject = TextLabel;

                return Label;
            end

            function Window : AddToggle( Index, Info )
                local Toggle = {
                    Value = Info.Default or false;
                    Type = "Toggle";
                    Callback = Info.Callback or function( ) end;
                };

                local ToggleOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    Size = UDim2New( 0, 13, 0, 13 );
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                local ToggleInner = Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 6;
                    Parent = ToggleOuter;
                } );

                Object.RegistryMap[ ToggleInner ] = { BackgroundColor3 = "MainColor"; BorderColor3 = "OutlineColor" };

                Object : CreateLabel( {
                    Size = UDim2New( 0, 216, 1, 0 );
                    Position = UDim2New( 1, 6, 0, 0 );
                    TextSize = 14;
                    Text = Info.Text;
                    TextXAlignment = EnumTextXAlignmentLeft;
                    ZIndex = 6;
                    Parent = ToggleInner;
                } );

                local HitRegion = Object : Create( "Frame", {
                    BackgroundTransparency = 1;
                    Size = UDim2New( 0, 170, 1, 0 );
                    ZIndex = 8;
                    Parent = ToggleOuter;
                } );

                Object : OnHighlight( HitRegion, ToggleOuter, { BorderColor3 = "AccentColor" }, { BorderColor3 = "Black" } );

                function Toggle : Display( )
                    ToggleInner.BackgroundColor3 = Toggle.Value and Object.AccentColor or Object.MainColor;
                    ToggleInner.BorderColor3 = Toggle.Value and Object.AccentColorDark or Object.OutlineColor;
                end

                function Toggle : SetValue( Bool )
                    Toggle.Value = not not Bool;
                    Toggle : Display( );
                    Object : SafeCallback( Toggle.Callback, Toggle.Value );

                    if ( Toggle.Changed ) then
                        Toggle.Changed( Toggle.Value );
                    end
                end

                function Toggle : OnChanged( Fn )
                    Toggle.Changed = Fn;
                    Fn( Toggle.Value );
                end

                HitRegion.InputBegan : Connect( function( Input )
                    if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                        return;
                    end

                    if ( Object : MouseIsOverOpenedFrame( ) ) then
                        return;
                    end

                    Toggle : SetValue( not Toggle.Value );
                end );

                Toggle : Display( );
                Object.Toggles[ Index ] = Toggle;

                return Toggle;
            end

            function Window : AddButton( Info )
                local ButtonOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    Size = UDim2New( 1, -4, 0, 20 );
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                local ButtonInner = Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 6;
                    Parent = ButtonOuter;
                } );

                Object : Create( "UIGradient", {
                    Color = StandardGradient;
                    Rotation = 90;
                    Parent = ButtonInner;
                } );

                local Label = Object : CreateLabel( {
                    Size = UDim2FromScale( 1, 1 );
                    TextSize = 14;
                    Text = Info.Text or "Button";
                    ZIndex = 7;
                    Parent = ButtonInner;
                } );

                Object : OnHighlight( ButtonOuter, ButtonOuter, { BorderColor3 = "AccentColor" }, { BorderColor3 = "Black" } );

                if ( type( Info.Tooltip ) == "string" ) then
                    Object : AddToolTip( Info.Tooltip, ButtonOuter );
                end
                
                local Callback = Info.Func;

                ButtonOuter.InputBegan : Connect( function( Input )
                    if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                        return;
                    end

                    if ( Object : MouseIsOverOpenedFrame( ) ) then
                        return;
                    end

                    Object : SafeCallback( Callback );
                end );

                return {
                    Callback = Callback,

                    Outer = ButtonOuter;
                    Inner = ButtonInner;

                    Label = Label;
                };
            end

            function Window : AddDropdown( Index, Info )
                local Dropdown = {
                    Values = Info.Values;
                    Value = Info.Multi and { } or nil;
                    Multi = Info.Multi;
                    Type = "Dropdown";
                    Callback = Info.Callback or function( ) end;
                };

                local MaxItems = 8;

                if ( Info.Text ) then
                    Object : CreateLabel( {
                        Size = UDim2New( 1, 0, 0, 10 );
                        TextSize = 14;
                        Text = Info.Text;
                        TextXAlignment = EnumTextXAlignmentLeft;
                        TextYAlignment = EnumTextYAlignmentBottom;
                        ZIndex = 5;
                        Parent = Scroll;
                    } );
                end

                local DropdownOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    Size = UDim2New( 1, -4, 0, 20 );
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                local DropdownInner = Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 6;
                    Parent = DropdownOuter;
                } );

                Object : Create( "UIGradient", {
                    Color = StandardGradient;
                    Rotation = 90;
                    Parent = DropdownInner;
                } );

                local Arrow = Object : Create( "ImageLabel", {
                    AnchorPoint = Vector2New( 0, 0.5 );
                    BackgroundTransparency = 1;
                    Position = UDim2New( 1, -16, 0.5, 0 );
                    Size = UDim2New( 0, 12, 0, 12 );
                    Image = "http://www.roblox.com/asset/?id=6282522798";
                    ZIndex = 8;
                    Parent = DropdownInner;
                } );

                local ItemList = Object : CreateLabel( {
                    Position = UDim2New( 0, 5, 0, 0 );
                    Size = UDim2New( 1, -5, 1, 0 );
                    TextSize = 14;
                    Text = "--";
                    TextXAlignment = EnumTextXAlignmentLeft;
                    TextWrapped = true;
                    ZIndex = 7;
                    Parent = DropdownInner;
                } );

                Object : OnHighlight( DropdownOuter, DropdownOuter, { BorderColor3 = "AccentColor" }, { BorderColor3 = "Black" } );

                local ListOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    ZIndex = 20;
                    Visible = false;
                    Parent = Object.ScreenGui;
                } );

                local ListInner = Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 21;
                    Parent = ListOuter;
                } );

                local ListScrolling = Object : Create( "ScrollingFrame", {
                    BackgroundTransparency = 1;
                    BorderSizePixel = 0;
                    CanvasSize = UDim2New( 0, 0, 0, 0 );
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 21;
                    TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
                    BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
                    ScrollBarThickness = 3;
                    ScrollBarImageColor3 = Object.AccentColor;
                    Parent = ListInner;
                } );

                Object : Create( "UIListLayout", {
                    Padding = UDimNew( 0, 0 );
                    FillDirection = EnumFillDirectionVertical;
                    SortOrder = EnumSortOrderLayoutOrder;
                    Parent = ListScrolling;
                } );

                local function RecalculatePosition( )
                    ListOuter.Position = UDim2FromOffset( DropdownOuter.AbsolutePosition.X, DropdownOuter.AbsolutePosition.Y + 21 );
                end

                local function RecalculateSize( Y )
                    ListOuter.Size = UDim2FromOffset( DropdownOuter.AbsoluteSize.X, Y or ( MaxItems * 20 + 2 ) );
                end

                RecalculatePosition( );
                RecalculateSize( );

                DropdownOuter : GetPropertyChangedSignal( "AbsolutePosition" ) : Connect( RecalculatePosition );
                DropdownOuter : GetPropertyChangedSignal( "AbsoluteSize" ) : Connect( function( )
                    RecalculateSize( ListOuter.AbsoluteSize.Y );
                end );

                function Dropdown : Display( )
                    local DisplayString = "";

                    if ( Dropdown.Multi ) then
                        for _, Value in next, Dropdown.Values do
                            if ( Dropdown.Value[ Value ] ) then
                                DisplayString ..= Value .. ", ";
                            end
                        end

                        DisplayString = DisplayString : sub( 1, #DisplayString - 2 );
                    else
                        DisplayString = Dropdown.Value or "";
                    end

                    ItemList.Text = DisplayString == "" and "--" or DisplayString;
                end

                function Dropdown : GetActiveCount( )
                    if ( not Dropdown.Multi ) then
                        return Dropdown.Value and 1 or 0;
                    end

                    local Count = 0;

                    for _ in next, Dropdown.Value do
                        Count += 1;
                    end

                    return Count;
                end

                function Dropdown : BuildList( )
                    for _, Child in next, ListScrolling : GetChildren( ) do
                        if ( not Child : IsA( "UIListLayout" ) ) then
                            Child : Destroy( );
                        end
                    end

                    local Count = 0;
                    local Buttons = { };

                    for _, Value in next, Dropdown.Values do
                        Count += 1;

                        local EntryFrame = Object : Create( "Frame", {
                            BackgroundColor3 = Object.MainColor;
                            BorderColor3 = Object.OutlineColor;
                            BorderMode = EnumBorderModeMiddle;
                            Size = UDim2New( 1, -1, 0, 20 );
                            ZIndex = 23;
                            Active = true;
                            Parent = ListScrolling;
                        } );

                        local EntryLabel = Object : CreateLabel( {
                            Active = false;
                            Size = UDim2New( 1, -6, 1, 0 );
                            Position = UDim2New( 0, 6, 0, 0 );
                            TextSize = 14;
                            Text = Value;
                            TextXAlignment = EnumTextXAlignmentLeft;
                            ZIndex = 25;
                            Parent = EntryFrame;
                        } );

                        Object : OnHighlight( EntryFrame, EntryFrame, { BorderColor3 = "AccentColor"; ZIndex = 24 }, { BorderColor3 = "OutlineColor"; ZIndex = 23 } );

                        local Entry = { };

                        function Entry : UpdateButton( )
                            local IsSelected = Dropdown.Multi and Dropdown.Value[ Value ] or ( Dropdown.Value == Value );
                            EntryLabel.TextColor3 = IsSelected and Object.AccentColor or Object.FontColor;
                        end

                        Entry : UpdateButton( );

                        EntryLabel.InputBegan : Connect( function( Input )
                            if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                                return;
                            end

                            local IsSelected = Dropdown.Multi and Dropdown.Value[ Value ] or ( Dropdown.Value == Value );
                            local NewSelected = not IsSelected;

                            if ( not NewSelected and Dropdown : GetActiveCount( ) == 1 and not Info.AllowNull ) then
                                return;
                            end

                            if ( Dropdown.Multi ) then
                                Dropdown.Value[ Value ] = NewSelected or nil;
                            else
                                Dropdown.Value = NewSelected and Value or nil;

                                for _, EntryItem in next, Buttons do
                                    EntryItem : UpdateButton( );
                                end
                            end

                            Entry : UpdateButton( );
                            Dropdown : Display( );

                            Object : SafeCallback( Dropdown.Callback, Dropdown.Value );

                            if ( Dropdown.Changed ) then
                                Dropdown.Changed( Dropdown.Value );
                            end
                        end );

                        Buttons[ EntryFrame ] = Entry;
                    end

                    ListScrolling.CanvasSize = UDim2FromOffset( 0, Count * 20 + 1 );
                    RecalculateSize( MathClamp( Count * 20, 0, MaxItems * 20 ) + 1 );
                end

                function Dropdown : SetValues( NewValues )
                    if ( NewValues ) then
                        Dropdown.Values = NewValues;
                    end

                    Dropdown : BuildList( );
                end

                function Dropdown : Open( )
                    ListOuter.Visible = true;
                    Object.OpenedFrames[ ListOuter ] = true;
                    Arrow.Rotation = 180;
                end

                function Dropdown : Close( )
                    ListOuter.Visible = false;
                    Object.OpenedFrames[ ListOuter ] = nil;
                    Arrow.Rotation = 0;
                end

                function Dropdown : SetValue( Value )
                    if ( Dropdown.Multi ) then
                        local Filtered = { };

                        for Item in next, Value do
                            if ( TableFind( Dropdown.Values, Item ) ) then
                                Filtered[ Item ] = true;
                            end
                        end

                        Dropdown.Value = Filtered;
                    else
                        Dropdown.Value = TableFind( Dropdown.Values, Value ) and Value or nil;
                    end

                    Dropdown : BuildList( );
                    Dropdown : Display( );

                    Object : SafeCallback( Dropdown.Callback, Dropdown.Value );

                    if ( Dropdown.Changed ) then
                        Dropdown.Changed( Dropdown.Value );
                    end
                end

                function Dropdown : OnChanged( Fn )
                    Dropdown.Changed = Fn;
                    Fn( Dropdown.Value );
                end

                DropdownOuter.InputBegan : Connect( function( Input )
                    if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                        return;
                    end

                    if ( Object : MouseIsOverOpenedFrame( ) ) then
                        return;
                    end

                    if ( ListOuter.Visible ) then
                        Dropdown : Close( );
                    else
                        Dropdown : Open( );
                    end
                end );

                Object : GiveSignal( UserInputService.InputBegan : Connect( function( Input )
                    if ( Input.UserInputType ~= EnumUserInputTypeMouseButton1 ) then
                        return;
                    end

                    local Position = ListOuter.AbsolutePosition;
                    local Size = ListOuter.AbsoluteSize;

                    local OutsideX = Mouse.X < Position.X or Mouse.X > Position.X + Size.X;
                    local OutsideY = Mouse.Y < ( Position.Y - 21 ) or Mouse.Y > Position.Y + Size.Y;

                    if ( OutsideX or OutsideY ) then
                        Dropdown : Close( );
                    end
                end ) );

                if ( Info.Default ) then
                    if ( Info.Multi ) then
                        local DefaultList = type( Info.Default ) == "table" and Info.Default or { Info.Default };

                        for _, Value in next, DefaultList do
                            if ( TableFind( Dropdown.Values, Value ) ) then
                                Dropdown.Value[ Value ] = true;
                            end
                        end
                    elseif ( TableFind( Dropdown.Values, Info.Default ) ) then
                        Dropdown.Value = Info.Default;
                    end
                end

                Dropdown : BuildList( );
                Dropdown : Display( );

                Object.Options[ Index ] = Dropdown;

                return Dropdown;
            end

            function Window : AddInput( Index, Info )
                local Textbox = {
                    Value = Info.Default or "";
                    Numeric = Info.Numeric or false;
                    Finished = Info.Finished or false;
                    Type = "Input";
                    Callback = Info.Callback or function( ) end;
                };

                local InputLabel = Object : CreateLabel( {
                    Size = UDim2New( 1, -4, 0, 15 );
                    TextSize = 14;
                    Text = Info.Text or "Input";
                    TextXAlignment = EnumTextXAlignmentLeft;
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                local BoxOuter = Object : Create( "Frame", {
                    BackgroundColor3 = Object.Black;
                    BorderColor3 = Object.Black;
                    Size = UDim2New( 1, -4, 0, 20 );
                    ZIndex = 5;
                    Parent = Scroll;
                } );

                local BoxInner = Object : Create( "Frame", {
                    BackgroundColor3 = Object.MainColor;
                    BorderColor3 = Object.OutlineColor;
                    BorderMode = EnumBorderModeInset;
                    Size = UDim2FromScale( 1, 1 );
                    ZIndex = 6;
                    Parent = BoxOuter;
                } );

                Object.RegistryMap[ BoxInner ] = { BackgroundColor3 = "MainColor"; BorderColor3 = "OutlineColor" };

                Object : Create( "UIGradient", {
                    Color = StandardGradient;
                    Rotation = 90;
                    Parent = BoxInner;
                } );

                Object : OnHighlight( BoxOuter, BoxOuter, { BorderColor3 = "AccentColor" }, { BorderColor3 = "Black" } );

                if ( type( Info.Tooltip ) == "string" ) then
                    Object : AddToolTip( Info.Tooltip, BoxOuter );
                end

                local ClipContainer = Object : Create( "Frame", {
                    BackgroundTransparency = 1;
                    ClipsDescendants = true;
                    Position = UDim2New( 0, 5, 0, 0 );
                    Size = UDim2New( 1, -5, 1, 0 );
                    ZIndex = 7;
                    Parent = BoxInner;
                } );

                local InputBox = Object : Create( "TextBox", {
                    BackgroundTransparency = 1;
                    Position = UDim2FromOffset( 0, 0 );
                    Size = UDim2FromScale( 5, 1 );
                    Font = Object.Font;
                    PlaceholderColor3 = Color3FromRGB( 190, 190, 190 );
                    PlaceholderText = Info.Placeholder or "";
                    Text = Info.Default or "";
                    TextColor3 = Object.FontColor;
                    TextSize = 14;
                    TextStrokeTransparency = 1;
                    TextXAlignment = EnumTextXAlignmentLeft;
                    ZIndex = 7;
                    Parent = ClipContainer;
                } );

                local function UpdateScroll( )
                    local Padding = 2;
                    local RevealWidth = ClipContainer.AbsoluteSize.X;

                    if ( not InputBox : IsFocused( ) or InputBox.TextBounds.X <= RevealWidth - 2 * Padding ) then
                        InputBox.Position = UDim2New( 0, Padding, 0, 0 );
                        return;
                    end

                    local Cursor = InputBox.CursorPosition;

                    if ( Cursor == -1 ) then
                        return;
                    end

                    local Substring = InputBox.Text : sub( 1, Cursor - 1 );
                    local TextWidth = TextService : GetTextSize( Substring, InputBox.TextSize, InputBox.Font, Vector2New( MathHuge, MathHuge ) ).X;
                    local CursorPixel = InputBox.Position.X.Offset + TextWidth;

                    if ( CursorPixel < Padding ) then
                        InputBox.Position = UDim2FromOffset( Padding - TextWidth, 0 );
                    elseif ( CursorPixel > RevealWidth - Padding - 1 ) then
                        InputBox.Position = UDim2FromOffset( RevealWidth - TextWidth - Padding - 1, 0 );
                    end
                end

                task.spawn( UpdateScroll );

                InputBox : GetPropertyChangedSignal( "CursorPosition" ) : Connect( UpdateScroll );
                InputBox : GetPropertyChangedSignal( "Text" ) : Connect( UpdateScroll );

                InputBox.FocusLost : Connect( UpdateScroll );
                InputBox.Focused : Connect( UpdateScroll );

                function Textbox : SetValue( Text )
                    if ( Info.MaxLength and #Text > Info.MaxLength ) then
                        Text = Text : sub( 1, Info.MaxLength );
                    end

                    if ( Textbox.Numeric and not tonumber( Text ) and #Text > 0 ) then
                        Text = Textbox.Value;
                    end

                    Textbox.Value = Text;
                    InputBox.Text = Text;

                    Object : SafeCallback( Textbox.Callback, Textbox.Value );

                    if ( Textbox.Changed ) then
                        Textbox.Changed( Textbox.Value );
                    end
                end

                if ( Textbox.Finished ) then
                    InputBox.FocusLost : Connect( function( Enter )
                        if ( not Enter ) then
                            return;
                        end

                        Textbox : SetValue( InputBox.Text );
                    end );
                else
                    InputBox : GetPropertyChangedSignal( "Text" ) : Connect( function( )
                        Textbox : SetValue( InputBox.Text );
                    end );
                end

                function Textbox : OnChanged( Fn )
                    Textbox.Changed = Fn;
                    Fn( Textbox.Value );
                end

                local OriginalLabelSize = InputLabel.Size;
                local OriginalBoxSize = BoxOuter.Size;
                local IsVisible = true;

                function Textbox : SetVisibility( Bool )
                    if ( Bool == IsVisible ) then
                        return;
                    end

                    IsVisible = Bool;

                    if ( Bool ) then
                        InputLabel.Size = OriginalLabelSize;
                        BoxOuter.Size = OriginalBoxSize;

                        InputLabel.Visible = true;
                        BoxOuter.Visible = true;
                    else
                        InputLabel.Visible = false;
                        BoxOuter.Visible = false;

                        InputLabel.Size = UDim2New( 1, -4, 0, 0 );
                        BoxOuter.Size = UDim2New( 1, -4, 0, 0 );
                    end
                end

                Object.Options[ Index ] = Textbox;

                return Textbox;
            end

            function Window : Unload( )
                Object : Unload( );
            end
        end

        Window.Holder = Holder;

        return Window;
    end
end

-- Main
do
    local LibraryObject = Library : Initiate( CoreGui ); do
        if ( Development ) then
            LibraryObject.OutlineColor = Color3FromRGB( 255, 159, 159 );
        end

        LibraryObject.BackgroundColor = Color3FromRGB( 12, 12, 12 );

        LibraryObject.FontColor = Color3FromRGB( 255, 255, 255 );
        LibraryObject.MainColor = Color3FromRGB( 16, 16, 16 );

        Flags = SetMetatable( { }, {
            __index = function( Self, Index )
                return LibraryObject.Toggles[ Index ] or LibraryObject.Options[ Index ];
            end
        } );
    end

	local Actor = Loader.Actor;
	
	local SizeX = WindowSize.X;
	local SizeY = WindowSize.Y;
	
	-- Don't do suspect stuff to me, thanks
	local UDim2Size = UDim2FromOffset( SizeX, SizeY );
	local Window = LibraryObject : CreateWindow( {
		[ "Title" ] = "homohack",
		[ "Size" ] = UDim2Size,
	} );

	local Script = Window : AddDropdown( "Main / Script", {
		[ "Text" ] = "Script",
        [ "Values" ] = { },
	} );

	Window : AddDivider( ); do
		local UpdateStamp = Window : AddLabel( "Updated: 4 days ago" );
		local LoadIndicator = Window : AddLabel( `Can Load: { ( Actor and "Yes" ) or "No" }` );

		local InputBox = Window : AddInput( "Main / ScriptKey", {
			[ "Placeholder" ] = "Enter your key here";
            [ "Default" ] = ( function( )
                local Path = `{ Directory }/Key.hhack`;

                if ( IsFile( Path ) ) then
                    return ReadFile( Path );
                end

                return "";
            end )( ),

			[ "Text" ] = "Key",
		} );

		function Script : Callback( )
            local ScriptCache = Loader.Scripts[ Script.Value ];
			local GuiObject = LoadIndicator.GuiObject;
			
			if ( not GuiObject ) or ( not ScriptCache ) then
				return;
			end

            local MaxSize = UDim2FromOffset( SizeX, SizeY + 68 );

			local Name = Script.Value;
			local Size = UDim2Size;
			
			-- Horrible hardcoded sizes (ill fix later..)
			do
				local IsJew = KeySystems[ Name ];-- One shotgun shell please!

                if ( not IsJew ) and ( InParallel[ Name ] ) then-- One shotgun shell please!
                    Size = UDim2FromOffset( SizeX, SizeY + 21 );-- One shotgun shell please!
				end-- One shotgun shell please!

                if ( IsJew ) then-- One shotgun shell please!
					Size = MaxSize;-- One shotgun shell please!
				end-- One shotgun shell please!
			end
			
			InputBox : SetVisibility( Size == MaxSize );
			LibraryObject : Resize( Size );
			
			GuiObject.Visible = InParallel[ Name ];

            -- Don't use 'Script.Value' for this, we format the name to make it look cleaner for the dropdown.
            UpdateStamp : SetText( `Updated: { GitHub : GetUpdate( ScriptCache.name ) } ago` );
		end

        Script : SetValues( Loader : GetScriptNames( ) );
        Script : SetValue( "PF Main" );
	end Window : AddDivider( );

	Window : AddToggle( "Main / CompatabilityMode", {
		[ "Text" ] = "Compatability Mode",
        [ "Default" ] = false,
    } );

	Window : AddToggle( "Main / AutoLoad", {
		[ "Text" ] = "Auto Load",
	} );

    -- Destination
    do
        local SaveFile = `{ Directory }/AutoLoad.hhack`;
        local LoadButton = Window : AddButton( {
            [ "Func" ] = function( Name )
                Name = ( Name or Script.Value );

                local ScriptCache = Loader.Scripts[ Name ];
                local DownloadURL = ( ScriptCache and ScriptCache.download_url );

                if ( not DownloadURL ) then
                    return;
                end

                local Success, Content = ProtectedCall( function( )
                    return HttpGet( Game, DownloadURL );
                end )

                if ( not Success ) then
                    return;
                end

                local AutoLoad = Flags[ "Main / AutoLoad" ].Value; do
                    if ( AutoLoad ) then
                        WriteFile( SaveFile, Name );
                    end
                end

                local Key = Flags[ "Main / ScriptKey" ].Value; do
                    if ( #Key > 0 ) then
                        WriteFile( `{ Directory }/Key.hhack`, Key );
                    end
                end

                LibraryObject : Unload( );
                Loader : Execute( Content, InParallel[ Name ] );
            end,

            [ "Text" ] = "Load",
        } );

        if ( IsFile( SaveFile ) ) then
            LoadButton.Callback( ReadFile( SaveFile ) );
        end
    end
end
