--[[
    some things to know:
        this was rushed together and the entire goal is to expand executor support; Compatibility is prioritized over everything else
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
		return Callback;
	end
	
	return ...;
end

local IdentifyExecutor = ( ( identifyexecutor or getexecutorname ) or DummyFunction( function( )
    return "SOMETHING OTHER THAN POTASSIUM, ENABLE COMPATIBILITY MODEW!!!!!!";
end ) );

local IsParallel = ( ( isparallel or is_parallel ) or DummyFunction );
local QueueOnTeleport = ( queue_on_teleport or DummyFunction );

local CloneReference = ( cloneref or DummyFunction );
local SetFastFlag = ( setfflag or DummyFunction );

-- Services
local TeleportService = CloneReference( Game : GetService( "TeleportService" ) );
local HttpService = CloneReference( Game : GetService( "HttpService" ) );

local RunService = CloneReference( Game : GetService( "RunService" ) );
local Players = CloneReference( Game : GetService( "Players" ) );

local CoreGui = ( RunService : IsStudio( ) and Players.LocalPlayer.PlayerGui ) or ( gethui or DummyFunction( function( )
	return CloneReference( Game : GetService( "CoreGui" ) );
end ) )( );

-- Cache
local UDim2FromOffset = UDim2.fromOffset;

local Color3FromRGB = Color3.fromRGB;
local Color3New = Color3.new;

local HttpGet = Game.HttpGet;

local TaskDefer = task.defer;
local TaskWait = task.wait;

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

local TableInsert = table.insert;
local TablePack = table.pack;

local MathFloor = math.floor;
local OSTime = os.time;

-- Constants
local ExecutorName = TablePack( IdentifyExecutor( ) )[ 1 ];
local WindowSize = Vector2New( 300, 223.7 );

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

		local Success, Scripts = ProtectedCall( function( )
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
	Loader.Scripts = { [ "Getting scripts .. If it stays like this, re-execute the script with a VPN." ] = 1 };
    Loader.Actor = nil;

    function Loader : Execute( Source, Parallel )
		if ( not Source ) or ( not Flags ) then
			return;
		end
		
		local Success, Result = ProtectedCall( function( )
            local CompatibilityMode = Flags[ "Main / CompatibilityMode / Enabled" ].Value; do
                if ( CompatibilityMode ) then
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
                    end task.wait( 5 ); -- W HOTFIX (For games like Scorched Earth ...)

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

            if ( not IsParallel( ) ) and ( Parallel ) then
                if ( Actor ) and ( not CompatibilityMode ) then
                    local Type = type( Actor );

                    if ( Type == "Instance" ) or ( Type == "userdata" ) or ( Type == "thread" ) then
                        local LoadFunction = run_on_thread; do
                            if ( not LoadFunction ) then
                                LoadFunction = run_on_actor;
                            end
                        end

                        local Executed, Output = ProtectedCall( function( )
                            return ( LoadFunction or DummyFunction )( Actor, Source );
                        end )
                        
                        if ( not Executed ) then
                            return LocalPlayer : Kick( `Failed to run script in parallel, your executor is likely not supported: { Output }` );
                        end
                    end

                    return;
                end

                if ( CompatibilityMode ) then
                    local SetterType = self : GetFlagSetType( true );
                    
                    if ( not SetterType ) then
                        return LocalPlayer : Kick( "Last Compatibility resort failed, your executor cannot run scripts in parallel." );
                    end

                    SetFastFlag( ForceParallelFlag, SetterType );
                    QueueOnTeleport( Source );

                    if ( Flags[ "Main / CompatibilityMode / Rejoin" ].Value ) then
                        TeleportService : TeleportToPlaceInstance( Game.PlaceId, Game.JobId, LocalPlayer );
                    end

                    return
                end
            end

            LoadString( Source )( );
		end )
		
		if ( not Success ) then
            return LocalPlayer : Kick( `Failed to run script: { Result }` );
		end
	end

	function Loader : GetFlagSetType( Value )
		local FastFlag, Counter = "BaseWrapVerticesModified", 0; -- [[ BOOLEAN ]]
        local ValueString = ToString( Value );

        for Index, Formatted in { Value, ValueString, StringGSub( ValueString, "^%l", StringUpper ) } do
            local Success = ProtectedCall( function( )
                return SetFastFlag( FastFlag, Formatted );
            end )
            
            if ( Success ) then
                return Formatted;
            end
        end
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
            self : GetScripts( );

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

        local GetActors = getactors;
		
		if ( not GetActorThreads ) and ( not GetDeletedActors ) and ( not GetActors ) then
			return;
		end
		
		local Actors = ( ( GetActorThreads and GetActorThreads( ) ) or ( GetDeletedActors and GetDeletedActors( ) ) ) or GetActors( );

		if ( not Actors ) then
			return;
		end
		
		self.Actor = Actors[ 1 ];
	end
	
	Loader : GetScripts( );
    Loader : GetActor( );
end

-- Classes
local Library = LoadString( Game : HttpGet( "https://raw.githubusercontent.com/dementiaenjoyer/Tiny-Linoria/refs/heads/main/Source.lua" ) )( );

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
				local IsJew = KeySystems[ Name ];

                if ( not IsJew ) and ( InParallel[ Name ] ) then
                    Size = UDim2FromOffset( SizeX, SizeY + 21 );
				end

                if ( IsJew ) then
					Size = MaxSize;
				end
			end
			
			InputBox : SetVisibility( Size == MaxSize );
			LibraryObject : Resize( Size );
			
			GuiObject.Visible = InParallel[ Name ];

            -- Don't use 'Script.Value' for this, we format the name to make it look cleaner for the dropdown.
            UpdateStamp : SetText( `Updated: { GitHub : GetUpdate( ScriptCache.name ) } ago` );
		end do
            local function Callback( )
                Script : SetValues( Loader : GetScriptNames( ) );
            end

            Callback( ); TaskDefer( function( )
                while ( TaskWait( 1 ) ) do
                    Callback( );
                end
            end )
        end

        Script : SetValue( "PF Main" );
	end Window : AddDivider( );

	Window : AddToggle( "Main / CompatibilityMode / Enabled", {
        [ "Default" ] = ExecutorName ~= "Potassium",
		[ "Text" ] = "Compatibility Mode",
    } );

    Window : AddToggle( "Main / CompatibilityMode / Rejoin", {
        [ "Tooltip" ] = "Will automatically rejoin when Compatibility Mode is enabled. Disable this if you want to manually Rejoin instead (Better)",

        [ "Default" ] = true,
		[ "Text" ] = "Rejoin",
	} );

    Window : AddDivider( );

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
