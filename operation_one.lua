--[[
	This script is pretty old, and is not updated to my current code style. Parts of it may look like garbage.
	Made by @dementia_enjoyr
]]

local ScannerQuery = ".DoorBarricade, BasePart:has(> .SoftWall), BasePart:has([$Health]), BasePart[$Material], BasePart[$Color], BasePart[$Vertical], #WallPart:has(#Breakable), BasePart[$Weak = true]";
const Directory = "Homohack/Operation-One";

const GetCustomAsset = getcustomasset;

const CloneReference = cloneref;
const ProtectedCall = pcall;

const DeleteFolder = delfolder;
const IsFolder = isfolder;
const IsFile = isfile;

const WriteFile = writefile;
const ReadFile = readfile;

if ( not CloneReference ) or ( not IsFolder ) or ( not WriteFile ) or ( not ReadFile ) then
	return;
end

const DummyFunction = function( ... )
	const Callback = select( 1, ... );
	
	if ( type( Callback ) == "function" ) then
		return Callback;
	end
	
	return ...;
end

-- File System-
do
	const QueryName = `{ Directory }/Query.txt`;
	const FileExists = IsFile( QueryName );

	if ( not FileExists ) then
		WriteFile( QueryName, ScannerQuery );
	end

	if ( FileExists ) then
		ScannerQuery = ReadFile( QueryName );
	end

	if ( IsFolder( ".fontcache_LY" ) ) then
		DeleteFolder( ".fontcache_LY" );
	end
end

const LoadString = loadstring;

const Game = game;
const HttpGet = Game.HttpGet;

-- Services
const ReplicatedStorage = Game : GetService( "ReplicatedStorage" );

const SoundService = Game : GetService( "SoundService" );
const TweenService = Game : GetService( "TweenService" );
const HttpService = Game : GetService( "HttpService" );

const RunService = Game : GetService( "RunService" );
const Workspace = Game : GetService( "Workspace" );

const Lighting = Game : GetService( "Lighting" );
const Players = Game : GetService( "Players" );

const CoreGui = ( RunService : IsStudio( ) and Players.LocalPlayer.PlayerGui ) or ( gethui or DummyFunction( function( )
	return CloneReference( Game : GetService( "CoreGui" ) );
end ) )( );

-- Imports
const CacheObject = LoadString( HttpGet( Game, "https://raw.githubusercontent.com/dementiaenjoyer/Roblox-CacheObject/refs/heads/main/Main.lua" ) )( );
const LuraphSDK = LoadString( HttpGet( Game, "https://raw.githubusercontent.com/Stefanuk12/macrosdk/refs/heads/main/luraphsdk.lua" ) )( );

const ImportedAssets = { }; do
	const function GetAsset( Name, URL )
		local Success, Result = ProtectedCall( function( )
			return HttpGet( Game, URL );
		end )

		if ( not Success ) then
			Result = ReadFile( Name );
		end

		WriteFile( Name, Result );

		const SuccessfulImport, CustomAsset = pcall( GetCustomAsset, Name );

		if ( SuccessfulImport ) then
			return CustomAsset;
		end

		return CustomAsset;
	end

	const URLs = { }; do
		URLs[ "Hitmarker" ] = GetAsset( "Hitmarker.png", "https://github.com/dementiaenjoyer/homohack/blob/main/storage/OperationOne/Hitmarker.png?raw=true" );
	end do
		for Name, Asset in URLs do
			ImportedAssets[ Name ] = Asset;
		end
	end

	ImportedAssets.URLs = URLs;
end

const HitMarkerAsset = ImportedAssets.Hitmarker;

-- Cache
const ColorSequenceKeypointNew = ColorSequenceKeypoint.new;
const CFrameFromEulerAnglesYXZ = CFrame.fromEulerAnglesYXZ;

const EnumEasingDirection = Enum.EasingDirection;
const NumberSequenceNew = NumberSequence.new;

const SetThreadIdentity = setthreadidentity;
const GetThreadIdentity = getthreadidentity;
const GetNameCallMethod = getnamecallmethod;

const ColorSequenceNew = ColorSequence.new;
const DrawingImmediate = DrawingImmediate;

const UDim2FromOffset = UDim2.fromOffset;
const EnumEasingStyle = Enum.EasingStyle;

const HookMetaMethod = hookmetamethod;

const DebugGetStack = debug.getstack;
const DebugSetStack = debug.setstack;

const Vector3YAxis = Vector3.yAxis;
const CFrameLookAt = CFrame.lookAt;

const CFrameZero = CFrame.identity;
const CFrameAngles = CFrame.Angles;
const TweenInfoNew = TweenInfo.new;

const HookFunction = hookfunction;
const SetMetatable = setmetatable;

const TableUnpack = table.unpack;
const TableInsert = table.insert;
const TableRemove = table.remove;

const InstanceNew = Instance.new;
const Vector3Zero = Vector3.zero;
const Vector2Zero = Vector2.zero;

const Vector3New = Vector3.new;
const Vector2New = Vector2.new;

const StringGSub = string.gsub;
const MathRandom = math.random;
const TableClear = table.clear;

const Color3New = Color3.new;
const StringLen = string.len;
const MathRound = math.round;
const MathFloor = math.floor;

const CFrameNew = CFrame.new;
const DebugInfo = debug.info;
const TableFind = table.find;

const TaskSpawn = task.spawn;
const TaskDelay = task.delay;

const TaskWait = task.wait;
const UDim2New = UDim2.new;

const UDimNew = UDim.new;
const MathMin = math.min;
const MathMax = math.max;
const MathAbs = math.abs;

const MathPi = 3.141592653589793;
const Math360Rad = MathPi * 2;

const White = Color3New( 1, 1, 1 );
const Black = Color3New( 0, 0, 0 );
const Red = Color3New( 1, 0, 0 );

const ToString = tostring;
const GetGC = getgc;

const Select = select;
const TypeOf = typeof;

const NaN = 0 / 0;
const Vector3NaN = Vector3New( NaN, NaN, NaN );

-- Constants
const DummyPlayer = InstanceNew( "Player" );
const Countries = {
	[ "GS" ] = "South Georgia and The South Sandwich Islands",
	[ "MK" ] = "Macedonia, The Former Yugoslav Republic of",
	[ "KP" ] = "Korea, Democratic People's Republic of",
	[ "CD" ] = "Congo, The Democratic Republic of The",
	[ "UM" ] = "United States Minor Outlying Islands",
	[ "FM" ] = "Micronesia, Federated States of",
	[ "VA" ] = "Holy See (Vatican City State)",
	[ "LA" ] = "Lao People's Democratic Republic",
	[ "IO" ] = "British Indian Ocean Territory",
	[ "HM" ] = "Heard Island and Mcdonald Islands",
	[ "CC" ] = "Cocos (Keeling) Islands",
	[ "VC" ] = "Saint Vincent and The Grenadines",
	[ "PS" ] = "Palestinian Territory, Occupied",
	[ "TZ" ] = "Tanzania, United Republic of",
	[ "BA" ] = "Bosnia and Herzegovina",
	[ "TF" ] = "French Southern Territories",
	[ "TC" ] = "Turks and Caicos Islands",
	[ "FK" ] = "Falkland Islands (Malvinas)",
	[ "IR" ] = "Iran, Islamic Republic of",
	[ "KR" ] = "Korea, Republic of",
	[ "LY" ] = "Libyan Arab Jamahiriya",
	[ "CF" ] = "Central African Republic",
	[ "DO" ] = "Dominican Republic",
	[ "PG" ] = "Papua New Guinea",
	[ "TT" ] = "Trinidad and Tobago",
	[ "TW" ] = "Taiwan, Province of China",
	[ "SJ" ] = "Svalbard and Jan Mayen",
	[ "SY" ] = "Syrian Arab Republic",
	[ "MP" ] = "Northern Mariana Islands",
	[ "AN" ] = "Netherlands Antilles",
	[ "MD" ] = "Moldova, Republic of",
	[ "MH" ] = "Marshall Islands",
	[ "LI" ] = "Liechtenstein",
	[ "KG" ] = "Kyrgyzstan",
	[ "KZ" ] = "Kazakhstan",
	[ "IM" ] = "Isle of Man",
	[ "HK" ] = "Hong Kong",
	[ "GW" ] = "Guinea-bissau",
	[ "PF" ] = "French Polynesia",
	[ "GQ" ] = "Equatorial Guinea",
	[ "SV" ] = "El Salvador",
	[ "CZ" ] = "Czech Republic",
	[ "CK" ] = "Cook Islands",
	[ "CX" ] = "Christmas Island",
	[ "CV" ] = "Cape Verde",
	[ "BF" ] = "Burkina Faso",
	[ "BN" ] = "Brunei Darussalam",
	[ "AG" ] = "Antigua and Barbuda",
	[ "WF" ] = "Wallis and Futuna",
	[ "VI" ] = "Virgin Islands, U.S.",
	[ "VG" ] = "Virgin Islands, British",
	[ "LK" ] = "Sri Lanka",
	[ "ZA" ] = "South Africa",
	[ "SB" ] = "Solomon Islands",
	[ "SL" ] = "Sierra Leone",
	[ "SA" ] = "Saudi Arabia",
	[ "AF" ] = "Afghanistan",
	[ "AS" ] = "American Samoa",
	[ "AX" ] = "Åland Islands",
	[ "AQ" ] = "Antarctica",
	[ "AR" ] = "Argentina",
	[ "AU" ] = "Australia",
	[ "AZ" ] = "Azerbaijan",
	[ "BD" ] = "Bangladesh",
	[ "BB" ] = "Barbados",
	[ "BY" ] = "Belarus",
	[ "BE" ] = "Belgium",
	[ "BZ" ] = "Belize",
	[ "BM" ] = "Bermuda",
	[ "BT" ] = "Bhutan",
	[ "BO" ] = "Bolivia",
	[ "BW" ] = "Botswana",
	[ "BV" ] = "Bouvet Island",
	[ "BR" ] = "Brazil",
	[ "BG" ] = "Bulgaria",
	[ "BI" ] = "Burundi",
	[ "KH" ] = "Cambodia",
	[ "CM" ] = "Cameroon",
	[ "CA" ] = "Canada",
	[ "KY" ] = "Cayman Islands",
	[ "TD" ] = "Chad",
	[ "CL" ] = "Chile",
	[ "CN" ] = "China",
	[ "CO" ] = "Colombia",
	[ "KM" ] = "Comoros",
	[ "CG" ] = "Congo",
	[ "CR" ] = "Costa Rica",
	[ "CI" ] = "Cote D'ivoire",
	[ "HR" ] = "Croatia",
	[ "CU" ] = "Cuba",
	[ "CY" ] = "Cyprus",
	[ "DK" ] = "Denmark",
	[ "DJ" ] = "Djibouti",
	[ "DM" ] = "Dominica",
	[ "EC" ] = "Ecuador",
	[ "EG" ] = "Egypt",
	[ "ER" ] = "Eritrea",
	[ "EE" ] = "Estonia",
	[ "ET" ] = "Ethiopia",
	[ "FO" ] = "Faroe Islands",
	[ "FJ" ] = "Fiji",
	[ "FI" ] = "Finland",
	[ "FR" ] = "France",
	[ "GF" ] = "French Guiana",
	[ "GA" ] = "Gabon",
	[ "GM" ] = "Gambia",
	[ "GE" ] = "Georgia",
	[ "DE" ] = "Germany",
	[ "GH" ] = "Ghana",
	[ "GI" ] = "Gibraltar",
	[ "GR" ] = "Greece",
	[ "GL" ] = "Greenland",
	[ "GD" ] = "Grenada",
	[ "GP" ] = "Guadeloupe",
	[ "GU" ] = "Guam",
	[ "GT" ] = "Guatemala",
	[ "GG" ] = "Guernsey",
	[ "GN" ] = "Guinea",
	[ "GY" ] = "Guyana",
	[ "HT" ] = "Haiti",
	[ "HN" ] = "Honduras",
	[ "HU" ] = "Hungary",
	[ "IS" ] = "Iceland",
	[ "IN" ] = "India",
	[ "ID" ] = "Indonesia",
	[ "IQ" ] = "Iraq",
	[ "IE" ] = "Ireland",
	[ "IL" ] = "Israel",
	[ "IT" ] = "Italy",
	[ "JM" ] = "Jamaica",
	[ "JP" ] = "Japan",
	[ "JE" ] = "Jersey",
	[ "JO" ] = "Jordan",
	[ "KE" ] = "Kenya",
	[ "KI" ] = "Kiribati",
	[ "KW" ] = "Kuwait",
	[ "LV" ] = "Latvia",
	[ "LB" ] = "Lebanon",
	[ "LS" ] = "Lesotho",
	[ "LR" ] = "Liberia",
	[ "LT" ] = "Lithuania",
	[ "LU" ] = "Luxembourg",
	[ "MO" ] = "Macao",
	[ "MG" ] = "Madagascar",
	[ "MW" ] = "Malawi",
	[ "MY" ] = "Malaysia",
	[ "MV" ] = "Maldives",
	[ "ML" ] = "Mali",
	[ "MT" ] = "Malta",
	[ "MQ" ] = "Martinique",
	[ "MR" ] = "Mauritania",
	[ "MU" ] = "Mauritius",
	[ "YT" ] = "Mayotte",
	[ "MX" ] = "Mexico",
	[ "MC" ] = "Monaco",
	[ "MN" ] = "Mongolia",
	[ "ME" ] = "Montenegro",
	[ "MS" ] = "Montserrat",
	[ "MA" ] = "Morocco",
	[ "MZ" ] = "Mozambique",
	[ "MM" ] = "Myanmar",
	[ "NA" ] = "Namibia",
	[ "NR" ] = "Nauru",
	[ "NP" ] = "Nepal",
	[ "NL" ] = "Netherlands",
	[ "NC" ] = "New Caledonia",
	[ "NZ" ] = "New Zealand",
	[ "NI" ] = "Nicaragua",
	[ "NE" ] = "NigerAfrica",
	[ "NG" ] = "Nigeria",
	[ "NU" ] = "Niue",
	[ "NF" ] = "Norfolk Island",
	[ "NO" ] = "Norway",
	[ "OM" ] = "Oman",
	[ "PK" ] = "Pakistan",
	[ "PW" ] = "Palau",
	[ "PA" ] = "Panama",
	[ "PY" ] = "Paraguay",
	[ "PE" ] = "Peru",
	[ "PH" ] = "Philippines",
	[ "PN" ] = "Pitcairn",
	[ "PL" ] = "Poland",
	[ "PT" ] = "Portugal",
	[ "PR" ] = "Puerto Rico",
	[ "QA" ] = "Qatar",
	[ "RE" ] = "Reunion",
	[ "RO" ] = "Romania",
	[ "RU" ] = "Russian Federation",
	[ "RW" ] = "Rwanda",
	[ "BL" ] = "Saint Barthélemy",
	[ "SH" ] = "Saint Helena",
	[ "KN" ] = "Saint Kitts and Nevis",
	[ "LC" ] = "Saint Lucia",
	[ "MF" ] = "Saint Martin",
	[ "PM" ] = "Saint Pierre and Miquelon",
	[ "WS" ] = "Samoa",
	[ "SM" ] = "San Marino",
	[ "ST" ] = "Sao Tome and Principe",
	[ "SN" ] = "Senegal",
	[ "RS" ] = "Serbia",
	[ "SC" ] = "Seychelles",
	[ "SG" ] = "Singapore",
	[ "SK" ] = "Slovakia",
	[ "SI" ] = "Slovenia",
	[ "SO" ] = "Somalia",
	[ "ES" ] = "Spain",
	[ "SD" ] = "Sudan",
	[ "SR" ] = "Suriname",
	[ "SZ" ] = "Swaziland",
	[ "SE" ] = "Sweden",
	[ "CH" ] = "Switzerland",
	[ "TJ" ] = "Tajikistan",
	[ "TH" ] = "Thailand",
	[ "TL" ] = "Timor-leste",
	[ "TG" ] = "Togo",
	[ "TK" ] = "Tokelau",
	[ "TO" ] = "Tonga",
	[ "TN" ] = "Tunisia",
	[ "TR" ] = "Turkey",
	[ "TM" ] = "Turkmenistan",
	[ "TV" ] = "Tuvalu",
	[ "UG" ] = "Uganda",
	[ "UA" ] = "Ukraine",
	[ "AE" ] = "United Arab Emirates",
	[ "GB" ] = "United Kingdom",
	[ "US" ] = "United States",
	[ "UY" ] = "Uruguay",
	[ "UZ" ] = "Uzbekistan",
	[ "VU" ] = "Vanuatu",
	[ "VE" ] = "Venezuela",
	[ "VN" ] = "Viet Nam",
	[ "EH" ] = "Western Sahara",
	[ "YE" ] = "Yemen",
	[ "ZM" ] = "Zambia",
	[ "ZW" ] = "Zimbabwe"
};

const CurrentCamera = Workspace.CurrentCamera;
const Terrain = Workspace.Terrain;

const LocalPlayer = Players.LocalPlayer;
const LocalName = LocalPlayer.Name;

const Environment = getrenv( );
const Hitsounds = {
	[ "Neverlose" ] = 8726881116,

	[ "Rust" ] = 5043539486,
	[ "TF2" ] = 3455144981,
};

const RIGHT_SIDE = "right";
const LEFT_SIDE = "left";

-- Variables
local CameraCFrame = CFrameZero;

local ViewportSize = Vector2Zero;
local Center = Vector2Zero;

local FieldOfView = 0;
local GameTick = 0;

-- Classes
const PlayerObject = { DataEntry = nil }; do
	PlayerObject.__index = PlayerObject;

	LPH_NO_VIRTUALIZE( function( )
		function PlayerObject : Initiate( Object )
			const ClassObject = SetMetatable( { }, self );
			ClassObject.DataEntry = Object;

			return ClassObject;
		end

		function PlayerObject : Collision( )
			return self : Get( ).instance;
		end

		function PlayerObject : Character( )
			return self.DataEntry.Model;
		end

		function PlayerObject : RootPart( )
			const Character = self : Character( );

			if ( not Character ) then
				return;
			end

			return Character.FindFirstChild( Character, "torso" ), Character;
		end

		function PlayerObject : Country( )
			const Player = self : Player( );

			if ( not Player ) then
				return;
			end

			const Code = Player : GetAttribute( "CountryCode" );

			if ( not Code ) then
				return;
			end

			return Countries[ Code ];
		end

		function PlayerObject : Hostile( )
			return self : Player( ).Team ~= LocalPlayer.Team;
		end

		function PlayerObject : Player( )
			return Players.FindFirstChild( Players, self : Name( ) ) or DummyPlayer;
		end

		function PlayerObject : Health( )
			const Collision = self : Collision( );

			if ( not Collision ) then
				return 0;
			end

			const Humanoid = Collision.FindFirstChildOfClass( Collision, "Humanoid" );

			if ( not Humanoid ) then
				return 0;
			end

			return Humanoid.Health, Humanoid.MaxHealth;
		end

		function PlayerObject : Name( )
			return self.DataEntry.Name;
		end

		function PlayerObject : Get( )
			return self.DataEntry.StateObject;
		end
	end )( );
end

-- Utilities
const Replicators = { DataEntries = { }, HostileOnly = { }, Everyone = { } }; do
	local EveryoneCache = { };
	local HostileCache = { };

	local CacheStamp = 0;

	LPH_NO_VIRTUALIZE( function( )
		function Replicators : GetPlayers( DoDead, DoAll )
			if ( GameTick - CacheStamp ) >= 3 then
				CacheStamp = GameTick;

				TableClear( EveryoneCache );
				TableClear( HostileCache );

				for _, DataEntry in self.DataEntries do
					const Object = PlayerObject : Initiate( DataEntry );
					EveryoneCache[ DataEntry ] = Object;

					if ( Object : Hostile( ) ) then
						HostileCache[ DataEntry ] = Object;
					end
				end

				self.HostileOnly = HostileCache;
				self.Everyone = EveryoneCache;
			end

			return ( DoAll and self.Everyone ) or self.HostileOnly;
		end

		function Replicators : GetClosest( Range, Part )
			local Closest, ClosestDistance = nil, Range;

			for _, Object in self : GetPlayers( ) do
				const Character = Object : Character( );

				if ( not Character ) then
					continue;
				end

				const RootPart = Character : FindFirstChild( Part or "head" );

				if ( not RootPart ) then
					continue;
				end

				const ScreenPosition, OnScreen = CurrentCamera : WorldToViewportPoint( RootPart.Position );

				if ( not OnScreen ) then
					continue;
				end

				const Distance = ( Center - Vector2New( ScreenPosition.X, ScreenPosition.Y ) ).Magnitude;

				if ( Distance <= ClosestDistance ) then
					Closest, ClosestDistance = RootPart, Distance;
				end
			end

			return Closest;
		end
	end )( );
end

const Controller = { WeaponObject = nil }; do
	LPH_NO_VIRTUALIZE( function( )
		function Controller : Character( )
			const LocalController, CollisionInstance = self : Get( );

			if ( not LocalController ) or ( not CollisionInstance ) then
				return;
			end

			return LocalController.values.viewmodels, CollisionInstance;
		end

		function Controller : RootPart( )
			const Character = self : Character( );
			
			if ( not Character ) then
				return;
			end

			return Character : FindFirstChild( "torso" );
		end

		function Controller : Humanoid( )
			const _, Collision = self : Character( );
			
			if ( not Collision ) then
				return;
			end

			return Collision : FindFirstChildOfClass( "Humanoid" );
		end

		function Controller : Get( )
			const DataEntry = Replicators.DataEntries[ LocalName ];

			if ( not DataEntry ) then
				return;
			end

			const StateObject = DataEntry.StateObject;

			if ( not StateObject ) then
				return;
			end

			return StateObject, StateObject.instance;
		end
	end )( );
end

const WorldRenderer = { Elements = { } }; do
	LPH_NO_VIRTUALIZE( function( )
		const ScreenGui = InstanceNew( "ScreenGui", CoreGui );
		const PropertyMap = {   
			[ "Frame" ] = "BackgroundTransparency",
			[ "ImageLabel" ] = "ImageTransparency",
		};

		function WorldRenderer : Connect( Position, Lifetime, Element, RotationData )
			if ( not Element.Parent ) then
				Element.Parent = ScreenGui;
			end

			const RotationEnabled = RotationData[ "Rotation / Enabled" ];
			const RotationSpeed = RotationData[ "Rotation / Speed" ];

			TableInsert( self.Elements, {
				[ "RotationEnabled" ] = RotationEnabled,
				[ "RotationSpeed" ] = RotationSpeed,

				[ "Position" ] = Position,
				[ "Lifetime" ] = Lifetime,

				[ "Element" ] = Element,
				[ "Added" ] = GameTick,
			} );
		end

		function WorldRenderer : Stepper( )
			const ThreadIdentity = GetThreadIdentity( );
			const Elements = self.Elements;

			SetThreadIdentity( 8 );
				for Index, Value in Elements do
					if ( Value.Dead ) then
						TableRemove( Elements, Index ); continue;
					end

					const RotationEnabled = Value.RotationEnabled;
					const RotationSpeed = Value.RotationSpeed;

					const Lifetime = Value.Lifetime;
					const Element = Value.Element;

					if ( ( GameTick - Value.Added ) > Lifetime ) and ( not Value.TweenObject ) then
						const Transparency = PropertyMap[ Element.ClassName ];

						if ( Transparency ) then
							const TweenObject = TweenService : Create( Element, TweenInfoNew( Lifetime * .3 ), { [ Transparency ] = 1 } );
							Value.TweenObject = TweenObject;

							TweenObject : Play( ); TweenObject.Completed : Once( function( )
								Value.Dead = true; Element : Destroy( );
							end )
						end
					end

					const ScreenPosition, OnScreen = CurrentCamera : WorldToScreenPoint( Value.Position );
					Element.Visible = OnScreen;

					const AbsoluteSize = Element.AbsoluteSize;
					Element.Position = UDim2New( 0, ScreenPosition.X - ( AbsoluteSize.X  * .5 ), 0, ScreenPosition.Y - ( AbsoluteSize.Y * .5 ) );
					Element.Rotation += RotationSpeed * ( RotationEnabled and 1 or 0 );
				end
			SetThreadIdentity( ThreadIdentity );
		end
	end )( );
end

const Storage = { Stored = { } }; do
	LPH_NO_VIRTUALIZE( function( )
		function Storage : Add( Index, Value )
			self.Stored[ Index ] = Value;
		end

		function Storage : Remove( Index )
			self.Stored[ Index ] = nil;
		end

		function Storage : Get( Index )
			return self.Stored[ Index ];
		end
	end )( );
end

const Utilities = { }; do
	LPH_NO_VIRTUALIZE( function( )
		local IgnoreCache, IgnoreStamp = { }, 0;

		function Utilities : PlaySound( AssetId, Volume, Pitch )
			const Sound = InstanceNew( "Sound" );

			Sound.SoundId = `rbxassetid://{ AssetId }`;
			Sound.Parent = SoundService;
			Sound.PlayOnRemove = true;

			Sound.Volume = Volume;
			Sound.Pitch = Pitch;

			Sound.Destroy( Sound );
		end

		function Utilities : CastBulletRay( Origin, Direction, Thread )
			local Result = ( ( not Thread ) and self : Raycast( Origin, Direction ) ) or nil;
			
			if ( Thread ) then
				TaskSpawn( function( )
					Result = self : Raycast( Origin, Direction );
				end )
			end

			return Result;
		end

		function Utilities : Raycast( Origin, Direction )
			return ( self : BulletRay( Origin, Direction, self : GetIgnore( ), nil ) or { } )[ 1 ];
		end

		function Utilities : GetIgnore( )
			if ( GameTick - IgnoreStamp ) < 2 then
				return IgnoreCache;
			end IgnoreStamp = GameTick;

			const Character, Collision = Controller : Character( );
			
			const IgnoreList = { Character, Collision, CurrentCamera }; do
				for _, Value in Storage : Get( "Ragebot / PENETRATABLES" ) or { } do
					if ( Value.Name == "MetalRoll" ) or ( not Value.HasTag( Value, "Breakable" ) ) or ( Value : FindFirstChild( "MetalRoll" ) ) then
						continue;
					end

					TableInsert( IgnoreList, Value );
				end

				for _, Player in Replicators : GetPlayers( false, true ) do
					if ( Player : Hostile( ) ) then
						continue;
					end

					TableInsert( IgnoreList, Player : Character( ) );
					TableInsert( IgnoreList, Player : Collision( ) );
				end

				IgnoreCache = IgnoreList;
			end

			return IgnoreList;
		end

		Utilities.BulletRay = ( function( )
			for _, Value in GetGC( ) do
				if ( TypeOf( Value ) ~= "function" ) then
					continue;
				end

				if ( DebugInfo( Value, "n" ) == "ray_damage" ) then
					return Value;
				end
			end
		end )( );
	end )( );
end

const World = { }; do
	const Info = TweenInfoNew( .35, EnumEasingStyle.Quad, EnumEasingDirection.InOut );
	const TracerID = "rbxassetid://446111271";

	LPH_NO_VIRTUALIZE( function( )
		function World : BulletTracer( Origin, Destination, Color1, Color2, Lifetime, Transparency, Width )
			const Cast = Utilities : CastBulletRay( Origin, ( Destination - Origin ).Unit * 1000, true );
			Destination = ( Cast and Cast.Position ) or Destination;

			const OriginAttachment = InstanceNew( "Attachment", Terrain );
			OriginAttachment.CFrame = CFrameNew( Origin );

			const EndAttachment = InstanceNew( "Attachment", Terrain );
			EndAttachment.CFrame = CFrameNew( Destination );

			const Beam = InstanceNew( "Beam", Terrain ); do
				Beam.Transparency = NumberSequenceNew( Transparency );
				Beam.Texture = TracerID;

				Beam.Attachment0 = OriginAttachment;
				Beam.Attachment1 = EndAttachment;

				Beam.Color = ColorSequenceNew( {
					ColorSequenceKeypointNew( 0, Color1 ),
					ColorSequenceKeypointNew( 1, Color2 )
				} );

				Beam.LightInfluence = 0;
				Beam.LightEmission = 1;

				Beam.Width0 = Width;
				Beam.Width1 = Width;

				Beam.FaceCamera = true;
				Beam.Enabled = true;
			end
		
			TaskDelay( Lifetime, function( )
				TweenService.Create( TweenService, Beam, Info, {
					Width0 = 0,
					Width1 = 0
				} ) : Play( ); TaskWait( Info.Time );

				OriginAttachment.Destroy( OriginAttachment );
				EndAttachment.Destroy( EndAttachment );
			end )
		end

		function World : HitMarker( Transparency, Position, Lifetime, Size, Color1, Color2, RotationData )
			const Marker = InstanceNew( "ImageLabel" ); do
				Marker.Image = HitMarkerAsset;
				--Marker.ImageColor3 = Color;

				Marker.Size = UDim2New( 0, Size, 0, Size );

				Marker.ImageTransparency = Transparency;
				Marker.BackgroundTransparency = 1;
				
				Marker.Visible = true;
			end

			const UIGradient = InstanceNew( "UIGradient", Marker ); do
				UIGradient.Color = ColorSequenceNew( {
					ColorSequenceKeypointNew( 0, Color1 ),
					ColorSequenceKeypointNew( 1, Color2 )
				} );

				UIGradient.Rotation = 90;
			end
			
			WorldRenderer : Connect( Position, Lifetime, Marker, RotationData or {
				[ "Rotation / Enabled" ] = false,
				[ "Rotation / Speed" ] = 0,
			} );
		end
	end )( );
end

-- Functions
const Scanning = { SilentTarget = nil, AimbotTarget = nil }; do
	LPH_NO_VIRTUALIZE( function( )
		const ScanPoints = {
			Vector3New( 0, -1, 0 ),
			Vector3YAxis,

			Vector3New( -1, 0, 0 ),
			Vector3New( 1, 0, 0 ),

			Vector3New( 0, 0, -1 ),
			Vector3New( 0, 0, 1 )
		};

		function Scanning : GetOrigin( Base, Destination, Range )
			for _, Point in ScanPoints do
				const Direction = Point * Range;
				const Origin = Base + Direction;
	
				if ( Utilities : CastBulletRay( Base, Direction ) ) then
					continue;
				end

				const HitCast = Utilities : CastBulletRay( Origin, ( Destination - Origin ).Unit * 1000 );

				if ( not HitCast ) or ( not HitCast.HitHum ) then
					continue;
				end

				return Origin;
			end

			return Base;
		end

		function Scanning : GetTargets( )
			for Index, Value in { "SilentAim", "Aimbot" } do
				const BaseFlag = `Combat / { Value }`;
				local Value = nil;

				if ( KeybindFlags[ `{ BaseFlag } / Enabled` ] ) then
					const Range = Flags[ `{ BaseFlag } / Range / Value` ];
					const Part = Flags[ `{ BaseFlag } / HitPart` ];

					Value = Replicators : GetClosest( Range, Part );
				end

				self[ `{ Value }Target` ] = Value;
			end
		end

		function Scanning : Stepper( )
			self : GetTargets( );
		end
	end )( );
end

const Legitbot = { }; do
	LPH_NO_VIRTUALIZE( function( )
		function Legitbot : Stepper( )
			const Target = Scanning.AimbotTarget;

			if ( not Target ) then
				return;
			end

			const Smoothness = Flags[ "Combat / Aimbot / Smoothness" ];
			const Destination = Target.Position;

			CurrentCamera.CFrame = CameraCFrame : Lerp( CFrameLookAt( CameraCFrame.Position, Destination ), ( Smoothness ~= 0 and .04 * ( 1 / Smoothness ) ) or 1 );
		end
	end )( );
end

const Ragebot = { }; do
	local ShootTick = 0;

	function Ragebot : Shoot( Destination, Origin, Target, TracerData )
		const WeaponObject = Controller.WeaponObject;

		if ( not WeaponObject ) then
			return;
		end

		const States = WeaponObject.states;
		const FireRate = States.firerate;

		if ( not States ) then
			return;
		end

		const Bullet = States.bullets;
		const Mag = States.mag;

		if ( not Bullet ) or ( not Mag ) or ( GameTick - ShootTick < ( 60 / ( ( ( FireRate and FireRate : get( ) ) or 500 ) * Storage : Get( "Mods / FIRE_RATE_MULTI" ) ) ) ) then
			return;
		end

		const Ammo = Bullet : get( );
		const MagAmmo = Mag : get( );

		if ( Ammo <= 0 ) or ( MagAmmo <= 0 ) then
			const ReloadThread = WeaponObject.reload_thread;

			if ( ReloadThread.running ) then
				return;
			end

			return States.reload : fire( );
		end

		-- Bullet Tracers
		do
			const Enabled = TracerData.Enabled;

			if ( Enabled ) then
				const Transparency = TracerData.Transparency;
				const Lifetime = TracerData.Lifetime;

				const Color1 = TracerData.Color1;
				const Color2 = TracerData.Color2;

				const Width = TracerData.Width;

				World : BulletTracer( Origin, Destination, Color1, Color2, Lifetime, Transparency, Width );
			end
		end

		States.shoot : fire_instant( CFrameLookAt( Origin, Destination ), { { {
			--Position = Target.Position,
			[ "Position" ] = Target.Position,
			
			[ "Normal" ] = Vector3Zero,
			[ "Instance" ] = Target,

			[ "HitHum" ] = true,
		} } } );
		
		Mag : set( MagAmmo - 1 ); ShootTick = GameTick;
	end

	LPH_NO_VIRTUALIZE( function( )
		function Ragebot : GetClosest( Range, Options )
			local Closest, ClosestOrigin, ClosestDistance = nil, nil, Range;
			const LocalRoot = Controller : RootPart( );

			if ( not LocalRoot ) then
				return;
			end

			const OriginScanEnabled = Options.OriginScanEnabled;
			const OriginScanRange = Options.OriginScanRange;
			
			const NoOcclusionCheck = Options.NoOcclusionCheck;
			const SpawnProtection = Options.SpawnProtection;

			for _, Object in Replicators : GetPlayers( false ) do
				if ( not SpawnProtection ) then
					const DataEntry = Object.DataEntry;

					if ( ( GameTick - DataEntry.Tick ) < 6 ) and ( not DataEntry.Zombie ) then
						continue;
					end
				end

				const Collision = Object : Collision( );
				const Character = Object : Character( );

				if ( not Character ) or ( not Collision ) then
					continue;
				end

				const Head = Character : FindFirstChild( "head" );

				if ( not Head ) then
					continue;
				end

				const Destination = Head.Position;
				local Origin = LocalRoot.Position;

				if ( OriginScanEnabled ) then
					Origin = Scanning : GetOrigin( Origin, Destination, 1 + MathAbs( ( ( GameTick * 9 ) % 2 ) - 1 ) * OriginScanRange );
				end
				
				const Direction = ( Destination - Origin );

				if ( not NoOcclusionCheck ) then
					const Result = Utilities : CastBulletRay( Origin, Direction );
	
					if ( not Result ) or ( not Result.HitHum ) then
						continue;
					end
				end

				const Distance = Direction.Magnitude;

				if ( Distance <= ClosestDistance ) then
					Closest, ClosestOrigin, ClosestDistance = Head, Origin, Distance;
				end
			end

			return Closest, ClosestOrigin;
		end

		function Ragebot : Stepper( )
			if ( not KeybindFlags[ "Combat / Ragebot / Enabled" ] ) or ( not Controller : RootPart( ) ) then
				return;
			end

			const Target, Origin = self : GetClosest( 1000, {
				OriginScanEnabled = Flags[ "Combat / Ragebot / OriginScan / Enabled" ];
				OriginScanRange = Flags[ "Combat / Ragebot / OriginScan / Range" ];
				
				NoOcclusionCheck = Flags[ "Combat / Ragebot / NoOcclusionCheck" ];
				SpawnProtection = Flags[ "Combat / Ragebot / SpawnProtection" ];
			} );

			if ( not Target ) then
				return;
			end

			const Pellets = ( Flags[ "Combat / Ragebot / TripleTap" ] and 3 ) or 1;
			const TracerData = { [ "Transparency" ] = 0 }; do
				const BaseFlag = "Combat / Ragebot / BulletTracers";

				TracerData.Lifetime = Flags[ `{ BaseFlag } / Lifetime` ];
				TracerData.Enabled = Flags[ `{ BaseFlag } / Enabled` ];

				TracerData.Color1 = Flags[ `{ BaseFlag } / Color1` ];
				TracerData.Color2 = Flags[ `{ BaseFlag } / Color2` ];

				TracerData.Width = Flags[ `{ BaseFlag } / Width` ];
			end

			for _ = 1, Pellets do
				self : Shoot( Target.Position, Origin, Target, TracerData );
			end
		end
	end )( );
end

local Library = { }; do
	local RunService = cloneref(game:GetService("RunService"))
	local Players = cloneref(game:GetService("Players"))
	local HttpService = cloneref(game:GetService("HttpService"))
	local UserInputService = cloneref(game:GetService("UserInputService"))
	local TextService = cloneref(game:GetService("TextService"))
	local GuiService = cloneref(game:GetService("GuiService"))
	local TweenService = cloneref(game:GetService("TweenService"))

	local IS_STUDIO = RunService:IsStudio()

	local localPlayer = Players.LocalPlayer
	local playerGui = IS_STUDIO and localPlayer:WaitForChild("PlayerGui") or cloneref(game:GetService("CoreGui"))

	local MOUSE_BUTTON_1 = Enum.UserInputType.MouseButton1
	local MOUSE_BUTTON_2 = Enum.UserInputType.MouseButton2

	local MOUSE_WHEEL = Enum.UserInputType.MouseWheel
	local MOUSE_MOVEMENT = Enum.UserInputType.MouseMovement
	local KEYCODE_ESCAPE = Enum.KeyCode.Escape

	local MOUSE_BEHAVIOR_DEFAULT = Enum.MouseBehavior.Default

	local BIT_32_MAX_INT = 2147483647

	local VECTOR2_ZERO = Vector2.zero

	local BLACK = Color3.new(0, 0, 0)
	local WHITE = Color3.new(1, 1, 1)

	local ALWAYS_ON_TOP_ZINDEX = 100

	local FONT_SETTINGS = {
		PATH = ".fontcache_LY",
		FONT_NAME = "ProggyClean",
		FONT_URL = "https://raw.githubusercontent.com/bluescan/proggyfonts/master/ProggyOriginal/ProggyClean.ttf",
		FONT_SIZE = 12,
		DESCENDER_SIZE = 4,
	}

	local ALLOWED_MOUSE_BUTTONS = {
		MOUSE_BUTTON_1,
		MOUSE_BUTTON_2,
	}

	local Signal = {}
	Signal.__index = Signal
	do
		local Connection = {}
		Connection.__index = {}
		do
			function Connection.new(signal, callback, index)
				local self = setmetatable({}, Connection)
				self.callback = callback
				self.signal = signal
				self.index = index

				return self
			end

			function Connection.Disconnect(self)
				self.signal.connections[self.index] = nil
			end
		end

		function Signal.new()
			local self = setmetatable({}, Signal)
			self.connections = {}

			return self
		end

		function Signal.Fire(self, ...)
			local connections = self.connections
			for i = 1, #connections do
				connections[i].callback(...)
			end
		end

		function Signal.Connect(self, callback)
			local index = #self.connections + 1
			local connection = Connection.new(self, callback, index)
			self.connections[index] = connection
		end

		function Signal.DisconnectAll(self)
			local connections = self.connections

			for i = 1, #connections do
				connections[i] = nil
			end
		end
	end

	local AssetManager = {}
	AssetManager.__index = AssetManager
	do
		function AssetManager.new(path)
			local self = setmetatable({}, AssetManager)
			self.path = path

			if not isfolder(path) then
				makefolder(path)
			end

			return self
		end

		function AssetManager.getPath(self, path)
			return self.path .. "/" .. path
		end

		function AssetManager.createFolder(self, path)
			return AssetManager.new(self:getPath(path))
		end

		function AssetManager.listFiles(self)
			return listfiles(self.path)
		end

		function AssetManager.writeFile(self, path, data)
			writefile(self:getPath(path), data)
		end

		function AssetManager.readFile(self, path)
			return readfile(self:getPath(path))
		end

		function AssetManager.isFile(self, path)
			return isfile(self:getPath(path))
		end

		function AssetManager.isFolder(self, path)
			return isfolder(self:getPath(path))
		end
	end

	local Utils = {}
	do
		local DefaultProperties = {
			["UIStroke"] = {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				LineJoinMode = Enum.LineJoinMode.Miter,
				Thickness = 1,
			},
			["Frame"] = {
				BorderSizePixel = 0,
			},
			["CanvasGroup"] = {
				BorderSizePixel = 0,
			},
			["TextBox"] = {
				Active = false,
				BorderSizePixel = 0,
			},
			["UIListLayout"] = {
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			["ImageButton"] = {
				Active = false,
				AutoButtonColor = false,
			},
			["TextButton"] = {
				TextTransparency = 1,
				TextStrokeTransparency = 1,
				BorderSizePixel = 0,
				AutoButtonColor = false,
				Active = false,
			},
			["TextLabel"] = {
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				TextStrokeTransparency = 1,
			},
		}

		local instances = {}
		local connections = {}

		function Utils.deleteAllInstances()
			for i = 1, #instances do
				instances[i]:Destroy()
				instances[i] = nil
			end
		end

		function Utils.disconnectAllConnections()
			for i = 1, #connections do
				connections[i]:Disconnect()
				connections[i] = nil
			end
		end

		function Utils.connect(signal, func)
			local connection = signal:Connect(func)
			connections[#connections + 1] = connection
			return connection
		end

		function Utils.createInstance(className, properties)
			local instance = Instance.new(className)
			local defaultProperties = DefaultProperties[className]

			if defaultProperties then
				for i, v in defaultProperties do
					instance[i] = v
				end
			end

			for i, v in properties do
				instance[i] = v
			end

			instances[#instances + 1] = instance

			return instance
		end

		function Utils.createStrokes(guiObject, strokes)
			local allStrokes = {}

			for i, strokeColor in strokes do
				local offset = i - 1

				local strokeFrame = Utils.createInstance("Frame", {
					Parent = guiObject,
					BackgroundTransparency = 1,
					Position = UDim2.fromOffset(-offset, -offset),
					Size = UDim2.new(1, offset * 2, 1, offset * 2),
				})

				local stroke = Utils.createInstance("UIStroke", {
					Parent = strokeFrame,
					Color = strokeColor,
				})

				table.insert(allStrokes, stroke)
			end

			return allStrokes
		end

		function Utils.createFont(fontName, fontLink, fontCache)
			local fontPath = fontName .. ".ttf"
			local fontJsonPath = fontName .. ".json"

			if not fontCache:isFile(fontPath) then
				local response = request({ Url = fontLink, Method = "GET" })
				fontCache:writeFile(fontPath, response.Body)
			end

			if not fontCache:isFile(fontJsonPath) then
				fontCache:writeFile(
					fontJsonPath,
					HttpService:JSONEncode({
						["name"] = fontName,
						["faces"] = {
							{
								["name"] = "Regular",
								["weight"] = 400,
								["style"] = "normal",
								["assetId"] = getcustomasset(fontCache:getPath(fontPath)),
							},
						},
					})
				)
			end

			return Font.new(
				getcustomasset(fontCache:getPath(fontJsonPath)),
				Enum.FontWeight.Regular,
				Enum.FontStyle.Normal
			)
		end

		local PROPERTIES_TO_WATCH = {
			"Text",
			"FontFace",
			"TextSize",
			"TextScaled",
			"TextDirection",
			"TextXAlignment",
			"TextYAlignment",
		}

		function Utils.createTextWithShadow(properties)
			properties = properties or {}

			local zIndex = properties.ZIndex or 2

			local container = Utils.createInstance("Frame", {
				BackgroundTransparency = 1,
				Size = properties.Size or UDim2.fromScale(0, 0),
				Position = properties.Position or UDim2.fromScale(0, 0),
				AnchorPoint = properties.AnchorPoint or VECTOR2_ZERO,
				Parent = properties.Parent,
				ZIndex = zIndex,
			})

			local textProps = table.clone(properties)
			textProps.Parent = container
			textProps.Size = UDim2.fromScale(1, 1)
			textProps.Position = UDim2.fromScale(0, 0)
			textProps.AnchorPoint = VECTOR2_ZERO

			local shadowProps = table.clone(textProps)
			shadowProps.Position = UDim2.fromOffset(1, 1)
			shadowProps.TextColor3 = Color3.new(0, 0, 0)
			shadowProps.ZIndex = zIndex

			local textLabelProps = table.clone(textProps)
			textLabelProps.ZIndex = zIndex + 1

			local shadowLabel = Utils.createInstance("TextLabel", shadowProps)
			local textLabel = Utils.createInstance("TextLabel", textLabelProps)

			shadowLabel.Parent = container
			textLabel.Parent = container

			local function applyProperty(propertyName)
				Utils.connect(textLabel:GetPropertyChangedSignal(propertyName), function()
					shadowLabel[propertyName] = textLabel[propertyName]
				end)
			end

			for _, propertyName in PROPERTIES_TO_WATCH do
				applyProperty(propertyName)
			end

			return textLabel, container, shadowLabel
		end

		function Utils.darkenColor(color, factor)
			return Color3.new(
				math.clamp(color.R * factor, 0, 1),
				math.clamp(color.G * factor, 0, 1),
				math.clamp(color.B * factor, 0, 1)
			)
		end

		function Utils.getTextBounds(text, font, fontSize)
			local textBoundsParams = Utils.createInstance("GetTextBoundsParams", {
				Text = text,
				Font = font,
				Size = fontSize,
				Width = 200,
			})

			return TextService:GetTextBoundsAsync(textBoundsParams)
		end

		function Utils.isMouseInFrame(frame, screenGui)
			local framePosition = frame.AbsolutePosition
			local frameSize = frame.AbsoluteSize

			local mousePosition = UserInputService:GetMouseLocation()

			local mouseX = mousePosition.X
			local mouseY = mousePosition.Y

			if screenGui.IgnoreGuiInset then
				local guiInset = GuiService:GetGuiInset()

				mouseX -= guiInset.X
				mouseY -= guiInset.Y
			end

			return mouseX >= framePosition.X
				and mouseX <= framePosition.X + frameSize.X
				and mouseY >= framePosition.Y
				and mouseY <= framePosition.Y + frameSize.Y
		end

		function Utils.tableToArray(t)
			local finalTable = {}

			for i, v in t do
				if v then
					table.insert(finalTable, i)
				end
			end

			return finalTable
		end

		function Utils.hasDescender(str)
			return str:find("[gjpqy]") ~= nil
		end
	end

	local UI = {}
	UI.__index = UI
	UI.fontCache = AssetManager.new(FONT_SETTINGS.PATH)
	do
		local KeybindList = {}
		KeybindList.__index = KeybindList
		do
			local Key = {}
			Key.__index = Key
			do
				local INDENT_SIZE = 15

				function Key.new(keybind, keybindList)
					local self = setmetatable({}, Key)
					self.keybindList = keybindList
					self.keybind = keybind

					local ui = keybindList.ui

					local section = keybind.section
					local sectionHolders = keybindList.sectionHolders

					local holder = sectionHolders[section]

					if not holder then
						local sectionHolderFrame = Utils.createInstance("Frame", {
							Parent = keybindList.keyHolder,
							Size = UDim2.new(0, 0, 0, 15),
							BackgroundTransparency = 1,
							AutomaticSize = Enum.AutomaticSize.XY,
						})

						Utils.createInstance("UIListLayout", {
							Parent = sectionHolderFrame,
							FillDirection = Enum.FillDirection.Vertical,
						})

						Utils.createInstance("TextLabel", {
							Parent = sectionHolderFrame,
							Size = UDim2.fromOffset(0, 15),
							AutomaticSize = Enum.AutomaticSize.X,
							BackgroundTransparency = 1,
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = ui.theme.text,
							Text = "[+] " .. section.name,
						})

						local sectionHolder = Utils.createInstance("Frame", {
							Parent = sectionHolderFrame,
							Size = UDim2.fromOffset(0, 0),
							BackgroundTransparency = 1,
							AutomaticSize = Enum.AutomaticSize.XY,
						})

						Utils.createInstance("UIListLayout", {
							Parent = sectionHolder,
							FillDirection = Enum.FillDirection.Vertical,
						})

						holder = sectionHolder
						sectionHolders[section] = sectionHolder
					end

					local keyLabel = Utils.createInstance("TextLabel", {
						Parent = holder,
						Size = UDim2.fromOffset(0, 15),
						AutomaticSize = Enum.AutomaticSize.X,
						BackgroundTransparency = 1,
						FontFace = ui.font,
						TextSize = ui.fontSize,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextColor3 = ui.theme.text,
					})

					Utils.createInstance("UIPadding", {
						Parent = keyLabel,
						PaddingLeft = UDim.new(0, INDENT_SIZE),
					})

					self.keyLabel = keyLabel
					self.ui = ui

					return self
				end

				function Key.setActive(self, state)
					local theme = self.ui.theme
					self.keyLabel.TextColor3 = state and theme.accent or theme.text
				end

				function Key.updateKey(self, keyText)
					self.keyLabel.Text = "[" .. keyText .. "] " .. self.keybind.name
				end
			end

			function KeybindList.new(ui)
				local self = setmetatable({}, KeybindList)
				self.ui = ui

				local theme = ui.theme

				local keybindListHolder = Utils.createInstance("Frame", {
					Parent = ui.otherScreenGui,
					BackgroundColor3 = theme.background,
					AutomaticSize = Enum.AutomaticSize.XY,
					Size = UDim2.fromOffset(0, 0),
					Position = UDim2.new(0, 10, 0.5, 0),
				})

				Utils.createStrokes(keybindListHolder, { theme.stroke1, theme.stroke0 })

				local keyHolder = Utils.createInstance("Frame", {
					Parent = keybindListHolder,
					Size = UDim2.fromOffset(0, 0),
					AutomaticSize = Enum.AutomaticSize.XY,
					BackgroundTransparency = 1,
				})

				Utils.createInstance("UIPadding", {
					Parent = keyHolder,
					PaddingLeft = UDim.new(0, 5),
					PaddingTop = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 8),
					PaddingBottom = UDim.new(0, 6),
				})

				Utils.createInstance("UIListLayout", {
					Parent = keyHolder,
					FillDirection = Enum.FillDirection.Vertical,
				})

				self.keybindListHolder = keybindListHolder
				self.keyHolder = keyHolder
				self.sectionHolders = {}

				return self
			end

			function KeybindList.createKey(self, keybind)
				return Key.new(keybind, self)
			end

			function KeybindList.setVisible(self, state)
				self.keybindListHolder.Visible = state
			end
		end

		function UI.new(config)
			config = config or {}

			local name = config.name or "homohack"
			local size = config.size or Vector2.new(438, 505)
			local minimumSize = config.minSize or size
			local maximumSize = config.maxSize or size * 2
			local fadeSpeed = config.fadeSpeed or 0.5
			local uiFadeSpeed = config.uiFadeSpeed or 0.1
			local folder = config.folder or name

			if not config.theme then
				error("No theme was provided!")
				return
			end

			local assets = AssetManager.new(folder)
			local theme = config.theme

			theme.accentDark = Utils.darkenColor(theme.accent, 0.5)
			theme.componentDark = Utils.darkenColor(theme.component, 0.8)
			theme.stroke = { theme.stroke1, theme.stroke0 }

			local self = setmetatable({}, UI)

			if config.subFolder then
				assets = assets:createFolder(config.subFolder)
			end

			self.configs = assets:createFolder("configs")

			self.font = IS_STUDIO and Font.fromEnum(Enum.Font.IndieFlower)
				or Utils.createFont(FONT_SETTINGS.FONT_NAME, FONT_SETTINGS.FONT_URL, self.fontCache)
			self.fontSize = FONT_SETTINGS.FONT_SIZE
			self.fadeSpeed = fadeSpeed
			self.uiFadeSpeed = uiFadeSpeed

			local screenGui = Utils.createInstance("ScreenGui", {
				DisplayOrder = BIT_32_MAX_INT,
				Parent = playerGui,
				ResetOnSpawn = false,
				IgnoreGuiInset = true,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				AutoLocalize = false,
			})

			local otherScreenGui = Utils.createInstance("ScreenGui", {
				DisplayOrder = 99999999,
				Parent = playerGui,
				ResetOnSpawn = false,
				IgnoreGuiInset = true,
				ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
				AutoLocalize = false,
			})

			self.otherScreenGui = otherScreenGui

			local notificationHolder = Utils.createInstance("Frame", {
				Parent = otherScreenGui,
				Size = UDim2.new(0, 150, 1, -40),
				Position = UDim2.fromOffset(5, 80),
				BackgroundTransparency = 1,
			})

			Utils.createInstance("UIListLayout", {
				Parent = notificationHolder,
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 3),
			})

			self.notifactionHolder = notificationHolder

			self.screenGui = screenGui
			self.config = config

			self.minimumSize = minimumSize
			self.maximumSize = maximumSize

			self.isDragging = false
			self.isResizing = false

			self.currentSlider = nil
			self.currentDropdown = nil
			self.currentKeybind = nil
			self.currentFloatingSection = nil
			self.currentColorpicker = nil
			self.currentColorpickerPopup = nil
			self.selectedTab = nil
			self.copiedColor = nil

			self.currentFadeTweens = {}
			self.keybinds = {}
			self.tabs = {}
			self.flags = {}
			self.elements = {}

			local scrollingHolder = Utils.createInstance("ScrollingFrame", {
				Parent = screenGui,
				Active = false,
				BackgroundTransparency = 1,
				CanvasSize = UDim2.fromOffset(0, 0),
				Size = UDim2.fromScale(1, 1),
				ElasticBehavior = Enum.ElasticBehavior.Never,
				ScrollBarThickness = 0,
				ScrollingEnabled = true,
				Selectable = false,
			})

			Utils.createInstance("UIDragDetector", {
				Parent = scrollingHolder,
				ActivatedCursorIcon = nil,
				ActivatedCursorIconContent = nil,
				CursorIcon = nil,
				CursorIconContent = nil,
				BoundingUI = nil,
			})

			local holder = Utils.createInstance("TextButton", {
				Parent = scrollingHolder,
				BackgroundTransparency = 1,
				TextTransparency = 1,
				Size = UDim2.fromScale(1, 1),
				Active = false,
			})

			self.holder = holder

			local mainFrame = Utils.createInstance("Frame", {
				Parent = holder,
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(config.size.X, config.size.Y),
				Position = UDim2.new(0.5, -config.size.X / 2, 0.5, -config.size.Y / 2),
			})
			self.mainStrokes = Utils.createStrokes(mainFrame, { theme.accent, theme.stroke0 })

			local frame = Utils.createInstance("CanvasGroup", {
				Parent = mainFrame,
				BackgroundColor3 = theme.background,
				Size = UDim2.fromScale(1, 1),
			})

			self.titleLabel = Utils.createTextWithShadow({
				Parent = frame,
				FontFace = self.font,
				TextSize = self.fontSize,
				TextColor3 = theme.text,
				Text = name,
				TextXAlignment = Enum.TextXAlignment.Left,
				Position = UDim2.fromOffset(6, 6),
				Size = UDim2.new(1, -12, 0, 12),
			})

			local dragFrame = Utils.createInstance("TextButton", {
				Parent = frame,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 21),
			})

			local resizeFrame = Utils.createInstance("TextButton", {
				Parent = frame,
				BackgroundTransparency = 1,
				Size = UDim2.fromOffset(10, 10),
				Position = UDim2.new(1, -10, 1, -10),
			})

			self.previousMousePosition = VECTOR2_ZERO
			self.initialMousePosition = nil

			self.initialFramePosition = nil
			self.initialFrameSize = nil

			Utils.connect(dragFrame.MouseButton1Down, function()
				self.initialFramePosition = mainFrame.Position
				self.isDragging = true
			end)

			Utils.connect(resizeFrame.MouseButton1Down, function()
				self.initialFrameSize = mainFrame.Size
				self.isResizing = true
			end)

			Utils.connect(UserInputService.InputBegan, function(input)
				self:processButtonDown(input)
			end)

			Utils.connect(UserInputService.InputEnded, function(input)
				self:processButtonUp(input)
			end)

			Utils.connect(UserInputService.InputChanged, function(input)
				if input.UserInputType == MOUSE_MOVEMENT then
					self:processMouseMovement(input)
				end
			end)

			local tabsFrame = Utils.createInstance("Frame", {
				Parent = frame,
				BackgroundColor3 = WHITE,
				Size = UDim2.new(1, -8, 0, 25),
				Position = UDim2.fromOffset(4, 23),
			})

			Utils.createInstance("UIGradient", {
				Parent = tabsFrame,
				Color = theme.tabButton,
				Rotation = 90,
			})

			local tabsHolder = Utils.createInstance("Frame", {
				Parent = tabsFrame,
				BackgroundTransparency = 1,
				Size = UDim2.fromScale(1, 1),
			})

			Utils.createInstance("UIListLayout", {
				Parent = tabsHolder,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				FillDirection = Enum.FillDirection.Horizontal,
			})

			local sectionFrame = Utils.createInstance("Frame", {
				Parent = frame,
				BackgroundColor3 = theme.background,
				Size = UDim2.new(1, -8, 1, -58),
				Position = UDim2.fromOffset(4, 51),
			})

			self.mainFrame = mainFrame
			self.frame = frame
			self.sectionFrame = sectionFrame
			self.tabsHolder = tabsHolder
			self.theme = theme

			Utils.createStrokes(tabsFrame, theme.stroke)
			Utils.createStrokes(sectionFrame, theme.stroke)

			self.savedMouseBehavior = UserInputService.MouseBehavior
			self.stopMouseBehavior = false

			self.savedMouseIconEnabled = UserInputService.MouseIconEnabled
			self.stopMouseIconEnabled = false

			self.mouseConnection = nil

			Utils.connect(UserInputService:GetPropertyChangedSignal("MouseBehavior"), function()
				if self.stopMouseBehavior then
					return
				end

				self.savedMouseBehavior = UserInputService.MouseBehavior
			end)

			Utils.connect(UserInputService:GetPropertyChangedSignal("MouseEnabled"), function()
				if self.stopMouseIconEnabled then
					return
				end

				self.savedMouseIconEnabled = UserInputService.MouseIconEnabled
			end)

			self.visible = false
			self.keybindList = KeybindList.new(self)

			self.onToggle = Signal.new()
			self:setVisible(true)

			return self
		end

		function UI.setMouseIconVisible(self, visible)
			self.stopMouseIconEnabled = true
			UserInputService.MouseIconEnabled = visible
			self.stopMouseIconEnabled = false
		end

		function UI.setMouseBehavior(self, mouseBehavior)
			self.stopMouseBehavior = true
			UserInputService.MouseBehavior = mouseBehavior
			self.stopMouseBehavior = false
		end

		function UI.updateMouse(self)
			local visible = self.visible

			self:setMouseIconVisible(visible or self.savedMouseIconEnabled)
			self:setMouseBehavior(visible and MOUSE_BEHAVIOR_DEFAULT or self.savedMouseBehavior)
		end

		function UI.disconnectMouse(self)
			if self.mouseConnection then
				self.mouseConnection:Disconnect()
				self.mouseConnection = nil
			end
		end

		function UI.setVisible(self, visible)
			local screenGui = self.screenGui
			self.visible = visible

			local fadeSpeed = self.uiFadeSpeed
			local currentTweens = self.currentFadeTweens

			local function stopTweens()
				for _, tween in currentTweens do
					tween:Cancel()
				end

				table.clear(currentTweens)
			end

			if fadeSpeed > 0 then
				stopTweens()

				if visible then
					self.frame.GroupTransparency = 1
					for _, stroke in self.mainStrokes do
						stroke.Transparency = 1
					end
					screenGui.Enabled = true
				end

				local tweenInfo = TweenInfo.new(fadeSpeed)
				local tween = TweenService:Create(self.frame, tweenInfo, {
					GroupTransparency = visible and 0 or 1,
				})

				for _, stroke in self.mainStrokes do
					local strokeTween = TweenService:Create(stroke, tweenInfo, {
						Transparency = visible and 0 or 1,
					})

					strokeTween:Play()
					table.insert(currentTweens, strokeTween)
				end

				tween:Play()
				table.insert(currentTweens, tween)

				if not visible then
					Utils.connect(tween.Completed, function()
						if not self.visible then
							screenGui.Enabled = false
						end
					end)
				end
			else
				screenGui.Enabled = visible
			end

			if visible then
				self.mouseConnection = Utils.connect(RunService.PreRender, function()
					self:updateMouse()
				end)
			else
				self:disconnectMouse()
				self:updateMouse()
			end

			self.onToggle:Fire(visible)
		end

		function UI.notify(self, text, duration)
			local notification = Utils.createInstance("TextLabel", {
				Parent = self.notifactionHolder,
				Size = UDim2.new(1, 0, 0, 15),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				FontFace = self.font,
				TextSize = self.fontSize,
				TextColor3 = self.theme.text,
				Text = text,
			})

			task.delay(duration, function()
				local tween = TweenService:Create(notification, TweenInfo.new(self.fadeSpeed), { TextTransparency = 1 })
				tween:Play()

				tween.Completed:Connect(function()
					notification:Destroy()
				end)
			end)
		end

		function UI.loadConfig(self, config)
			for flag, element in self.elements do
				local elementType = element.type
				local configElement = config[flag]

				if not configElement then
					continue
				end

				local value = configElement

				if elementType == "Colorpicker" then
					local color = value.color
					local transparency = value.transparency

					element:set(
						Color3.new(color[1], color[2], color[3]),
						(transparency and (element.drawingTransparency and transparency or 1 - transparency)) or nil
					)
				elseif elementType == "Keybind" then
					element:set(value and (Enum.KeyCode:FromName(value) or Enum.UserInputType:FromName(value)) or nil)
				elseif
					elementType == "Toggle"
					or elementType == "Feature"
					or elementType == "Slider"
					or elementType == "Dropdown"
					or elementType == "Textbox"
				then
					element:set(value)
				end
			end
		end

		function UI.getConfig(self)
			local config = {}

			for flag, element in self.elements do
				local configValue
				local value = element.value
				local elementType = element.type

				if elementType == "Colorpicker" then
					local color = element.color
					local transparency = element.transparency

					configValue = {
						color = { color.R, color.G, color.B },
						transparency = transparency,
					}
				elseif elementType == "Keybind" then
					local key = element.key
					configValue = key and key.Name or nil
				elseif
					elementType == "Toggle"
					or elementType == "Feature"
					or elementType == "Slider"
					or elementType == "Dropdown"
				then
					configValue = value
				elseif elementType == "Textbox" then
					configValue = tostring(value)
				end

				config[flag] = configValue
			end

			return config
		end

		function UI.getMouseLocation(self)
			local mouseLocation = UserInputService:GetMouseLocation()

			local mouseX = mouseLocation.X
			local mouseY = mouseLocation.Y

			if self.screenGui.IgnoreGuiInset then
				local guiInset = GuiService:GetGuiInset()

				mouseX -= guiInset.X
				mouseY -= guiInset.Y
			end

			return Vector2.new(mouseX, mouseY)
		end

		function UI.applyInset(self, guiObject)
			if self.screenGui.IgnoreGuiInset then
				local guiInset = GuiService:GetGuiInset()
				local currentPosition = guiObject.Position

				local positionX = currentPosition.X
				local positionY = currentPosition.Y

				guiObject.Position = UDim2.new(
					positionX.Scale,
					positionX.Offset + guiInset.X,
					positionY.Scale,
					positionY.Offset + guiInset.Y
				)
			end
		end

		function UI.processFloatingSection(self, input, floatingSection)
			local currentColorpicker = self.currentColorpicker
			local currentDropdown = self.currentDropdown

			if floatingSection.inputObject == input then
				floatingSection.inputObject = nil
				return
			end

			if
				(currentDropdown and currentDropdown.section == floatingSection)
				or (currentColorpicker and currentColorpicker.section == floatingSection)
			then
				return
			end

			floatingSection:setOpen(false)
		end

		function UI.processButtonDown(self, input)
			local userInputType = input.UserInputType
			local keyCode = input.KeyCode

			local currentDropdown = self.currentDropdown
			local currentFloatingSection = self.currentFloatingSection
			local currentKeybind = self.currentKeybind
			local currentColorpicker = self.currentColorpicker
			local currentColorpickerPopup = self.currentColorpickerPopup

			if userInputType == MOUSE_BUTTON_1 then
				self.initialMousePosition = input.Position

				if currentDropdown and not currentDropdown:isMouseInDropdown() then
					currentDropdown:setOpen(false)
				end

				if currentColorpicker and not currentColorpicker:isMouseInColorpicker() then
					currentColorpicker:setOpen(false)
				end

				if currentColorpickerPopup and not currentColorpickerPopup:isMouseInColorpickerPopup() then
					currentColorpickerPopup:setPopupOpen(false)
				end

				if currentFloatingSection and not currentFloatingSection:isMouseInSection() then
					self:processFloatingSection(input, currentFloatingSection)
				end
			end

			local allowedMouseButton = table.find(ALLOWED_MOUSE_BUTTONS, userInputType)

			if currentKeybind then
				if currentKeybind.inputObject == input then
					currentKeybind.inputObject = nil
				elseif keyCode == KEYCODE_ESCAPE then
					currentKeybind:set(nil)
				elseif allowedMouseButton then
					currentKeybind:set(userInputType)
				elseif keyCode ~= Enum.KeyCode.Unknown then
					currentKeybind:set(keyCode)
				end
			end

			if not currentKeybind and not UserInputService:GetFocusedTextBox() then
				self:processKeybinds(input, true)
			end
		end

		function UI.processButtonUp(self, input)
			local userInputType = input.UserInputType

			if userInputType == MOUSE_BUTTON_1 then
				local currentColorpicker = self.currentColorpicker

				self.isDragging = false
				self.isResizing = false

				self.initialFrameSize = nil
				self.initialFramePosition = nil

				self.initialMousePosition = nil
				self.currentSlider = nil

				if currentColorpicker then
					currentColorpicker.pickingHue = false
					currentColorpicker.pickingTransparency = false
					currentColorpicker.pickingColor = false
				end
			end

			if not UserInputService:GetFocusedTextBox() then
				self:processKeybinds(input, false)
			end
		end

		function UI.processMouseMovement(self, input)
			local currentMousePosition = input.Position
			local previousMousePosition = self.previousMousePosition

			local initialMousePosition = self.initialMousePosition or previousMousePosition

			local mouseDeltaPositionX = currentMousePosition.X - initialMousePosition.X
			local mouseDeltaPositionY = currentMousePosition.Y - initialMousePosition.Y

			local mainFrame = self.mainFrame

			if self.isDragging and self.initialFramePosition then
				local currentFramePosition = mainFrame.Position
				local initialFramePosition = self.initialFramePosition

				mainFrame.Position = UDim2.new(
					currentFramePosition.X.Scale,
					initialFramePosition.X.Offset + mouseDeltaPositionX,
					currentFramePosition.Y.Scale,
					initialFramePosition.Y.Offset + mouseDeltaPositionY
				)
			end

			if self.isResizing and self.initialFrameSize then
				local currentFrameSize = mainFrame.Size
				local initialFrameSize = self.initialFrameSize

				local minimumSize = self.minimumSize
				local maximumSize = self.maximumSize

				mainFrame.Size = UDim2.new(
					currentFrameSize.X.Scale,
					math.clamp(initialFrameSize.X.Offset + mouseDeltaPositionX, minimumSize.X, maximumSize.X),
					currentFrameSize.Y.Scale,
					math.clamp(initialFrameSize.Y.Offset + mouseDeltaPositionY, minimumSize.Y, maximumSize.Y)
				)
			end

			local currentSlider = self.currentSlider
			local currentColorpicker = self.currentColorpicker

			if currentSlider then
				currentSlider:update()
			end

			if currentColorpicker then
				self:processColorpickerMovement(currentMousePosition, currentColorpicker)
			end

			self.previousMousePosition = currentMousePosition
		end

		function UI.processColorpickerMovement(self, mousePosition, colorpicker)
			if colorpicker.pickingColor then
				colorpicker:updateColor(mousePosition)
			elseif colorpicker.pickingHue then
				colorpicker:updateHue(mousePosition)
			elseif colorpicker.pickingTransparency then
				colorpicker:updateTransparency(mousePosition)
			end
		end

		function UI.processKeybinds(self, input, began)
			local allKeybinds = self.keybinds
			local userInputType = input.UserInputType

			for i = 1, #allKeybinds do
				local keybind = allKeybinds[i]
				local key = keybind.key

				if key ~= input.KeyCode and (userInputType and key ~= userInputType) then
					continue
				end

				if began then
					keybind:press()
				else
					keybind:release()
				end
			end
		end

		local Section = {}
		Section.__index = Section
		do
			local Toggle = {}
			local Label = {}
			local Slider = {}
			local Dropdown = {}
			local Keybind = {}
			local Colorpicker = {}
			local Textbox = {}
			local Button = {}
			local List = {}
			local Divider = {}

			Toggle.type = "Toggle"
			Label.type = "Label"
			Slider.type = "Slider"
			Dropdown.type = "Dropdown"
			Keybind.type = "Keybind"
			Colorpicker.type = "Colorpicker"
			Textbox.type = "Textbox"
			List.type = "List"
			Divider.type = "Divider"

			local FloatingSection = setmetatable({}, Section)

			Toggle.__index = Toggle
			Label.__index = Label
			Slider.__index = Slider
			Dropdown.__index = Dropdown
			Keybind.__index = Keybind
			Colorpicker.__index = Colorpicker
			Textbox.__index = Textbox
			Button.__index = Button
			List.__index = List
			Divider.__index = Divider

			FloatingSection.__index = FloatingSection

			do
				do
					function Toggle.new(section, name, flag, value)
						local self = setmetatable({}, Toggle)

						local ui = section.ui

						local buttonHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, 8),
							BackgroundTransparency = 1,
						})

						local toggleFrame = Utils.createInstance("Frame", {
							Parent = buttonHolder,
							Size = UDim2.fromOffset(8, 8),
							BackgroundColor3 = WHITE,
						})

						Utils.createInstance("UIStroke", {
							Parent = toggleFrame,
							Color = ui.theme.stroke0,
						})

						local buttonGradient = Utils.createInstance("UIGradient", {
							Parent = toggleFrame,
							Rotation = 90,
						})

						local label = Utils.createTextWithShadow({
							Parent = buttonHolder,
							Position = UDim2.fromOffset(15, 0),
							Size = UDim2.new(1, -31, 1, 0),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							Text = name,
						})

						local subComponentHolder = Utils.createInstance("Frame", {
							Parent = buttonHolder,
							Position = UDim2.fromScale(0.5, 0),
							Size = UDim2.fromScale(0.5, 1),
							BackgroundTransparency = 1,
						})

						Utils.createInstance("UIListLayout", {
							Parent = subComponentHolder,
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Right,
							Padding = UDim.new(0, 3),
						})

						local toggleButtonHolder = Utils.createInstance("TextButton", {
							Parent = buttonHolder,
							BackgroundTransparency = 1,
							Position = UDim2.fromOffset(0, -1),
							Size = UDim2.new(0.5, 0, 1, 2),
						})

						Utils.connect(toggleButtonHolder.MouseButton1Down, function()
							self:set(not self.value)
						end)

						self.ui = ui

						self.name = name
						self.buttonHolder = buttonHolder
						self.buttonGradient = buttonGradient
						self.subComponentHolder = subComponentHolder
						self.label = label

						self.flag = flag
						self.value = value
						self.section = section

						self.onChanged = Signal.new()
						ui.elements[flag] = self

						self:set(value)

						return self
					end

					function Toggle.destroy(self)
						self.buttonHolder:Destroy()
						self.ui.flags[self.flag] = nil
					end

					function Toggle.set(self, newValue)
						local ui = self.ui

						local theme = ui.theme
						local flags = ui.flags

						self.buttonGradient.Color = newValue and ColorSequence.new(theme.accent, theme.accentDark)
							or ColorSequence.new(theme.component, theme.componentDark)
						self.label.TextColor3 = newValue and theme.text or theme.darkText

						self.value = newValue
						flags[self.flag] = newValue

						self.onChanged:Fire(newValue)
					end

					function Toggle.keybind(self, properties)
						properties = properties or {}

						local name = properties.name or self.name
						local flag = properties.flag or "keybind"
						local default = (properties.default or properties.value) or nil
						local hold = properties.hold or false
						local affectToggle = properties.affectToggle or false
						local ignoreKeybindList = properties.ignoreKeybindList or false

						return Keybind.new(
							self.ui,
							self.section,
							self.subComponentHolder,
							name,
							flag,
							default,
							hold,
							ignoreKeybindList,
							affectToggle and self or nil
						)
					end

					function Toggle.colorpicker(self, properties)
						properties = properties or {}

						local name = properties.name or "colorpicker"
						local flag = properties.flag or name
						local color = properties.color or WHITE
						local transparency = properties.transparency or nil
						local drawingTransparency = properties.drawingTransparency or false

						return Colorpicker.new(
							self.ui,
							self.section,
							self.subComponentHolder,
							name,
							flag,
							color,
							transparency,
							drawingTransparency
						)
					end
				end

				do
					function Label.new(section, name)
						local self = setmetatable({}, Label)

						local ui = section.ui
						local theme = ui.theme

						local labelHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, 8),
							BackgroundTransparency = 1,
						})

						local label = Utils.createTextWithShadow({
							Parent = labelHolder,
							Position = UDim2.fromOffset(-1, 0),
							Size = UDim2.new(1, -15, 1, 0),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							Text = name,
						})

						local subComponentHolder = Utils.createInstance("Frame", {
							Parent = labelHolder,
							Position = UDim2.fromScale(0.5, 0),
							Size = UDim2.fromScale(0.5, 1),
							BackgroundTransparency = 1,
						})

						Utils.createInstance("UIListLayout", {
							Parent = subComponentHolder,
							FillDirection = Enum.FillDirection.Horizontal,
							HorizontalAlignment = Enum.HorizontalAlignment.Right,
							Padding = UDim.new(0, 3),
						})

						self.ui = ui

						self.name = name
						self.labelHolder = labelHolder
						self.subComponentHolder = subComponentHolder
						self.label = label

						self.section = section

						return self
					end

					function Label.destroy(self)
						self.labelHolder:Destroy()
					end

					function Label.keybind(self, properties)
						properties = properties or {}

						local name = properties.name or self.name
						local flag = properties.flag or "keybind"
						local default = (properties.default or properties.value) or nil
						local hold = properties.hold or false
						local ignoreKeybindList = properties.ignoreKeybindList or false

						return Keybind.new(
							self.ui,
							self.section,
							self.subComponentHolder,
							name,
							flag,
							default,
							hold,
							ignoreKeybindList,
							nil
						)
					end

					function Label.colorpicker(self, properties)
						properties = properties or {}

						local name = properties.name or "colorpicker"
						local flag = properties.flag or name
						local color = properties.color or WHITE
						local transparency = properties.transparency or nil
						local drawingTransparency = properties.drawingTransparency or false

						return Colorpicker.new(
							self.ui,
							self.section,
							self.subComponentHolder,
							name,
							flag,
							color,
							transparency,
							drawingTransparency
						)
					end
				end

				do
					function Slider.new(section, name, flag, value, minValue, maxValue, step, suffix, compact)
						local ui = section.ui
						local theme = ui.theme

						local self = setmetatable({}, Slider)

						local trim = (not compact and not Utils.hasDescender(name)) and 3 or 0

						local sliderHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, compact and 11 or 23),
							BackgroundTransparency = 1,
						})

						local textBounds = Utils.getTextBounds(name, ui.font, ui.fontSize)

						local sliderFrame = Utils.createInstance("TextButton", {
							Parent = sliderHolder,
							Size = UDim2.new(
								1,
								compact and -(textBounds.X + 6) or 0,
								compact and 1 or 0,
								compact and 0 or 9
							),
							Position = UDim2.new(
								0,
								compact and textBounds.X + 5 or 0,
								compact and 0 or 1,
								compact and 0 or -9
							),
							BackgroundColor3 = WHITE,
						})

						Utils.createTextWithShadow({
							Parent = sliderHolder,
							Size = UDim2.new(1, -31, 0, 12),
							Position = UDim2.fromOffset(-1, (compact and -1 or -3) + trim),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							Text = name,
						})

						Utils.createInstance("UIGradient", {
							Parent = sliderFrame,
							Rotation = 90,
							Color = ColorSequence.new(theme.component, theme.componentDark),
						})

						Utils.createInstance("UIStroke", {
							Parent = sliderFrame,
							Color = theme.stroke0,
						})

						local innerSlider = Utils.createInstance("Frame", {
							Parent = sliderFrame,
							BackgroundColor3 = WHITE,
							Size = UDim2.fromScale(0.5, 1),
						})

						Utils.createInstance("UIGradient", {
							Parent = innerSlider,
							Rotation = 90,
							Color = ColorSequence.new(theme.accent, theme.accentDark),
						})

						Utils.connect(sliderFrame.MouseButton1Down, function()
							ui.currentSlider = self
							self:update()
						end)

						local valueLabel = Utils.createTextWithShadow({
							Parent = sliderHolder,
							Size = UDim2.new(1, 0, 0, 12),
							Position = UDim2.fromOffset(compact and -3 or 1, -1),
							TextXAlignment = Enum.TextXAlignment.Right,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = compact and theme.text or theme.darkText,
						})

						self.sliderHolder = sliderHolder
						self.sliderFrame = sliderFrame
						self.innerSlider = innerSlider
						self.valueLabel = valueLabel

						self.step = step
						self.minValue = minValue
						self.maxValue = maxValue
						self.suffix = suffix

						self.flag = flag
						self.value = value
						self.onChanged = Signal.new()

						ui.elements[flag] = self
						self.ui = ui

						self:set(value)

						return self
					end

					function Slider.destroy(self)
						local ui = self.ui
						self.sliderHolder:Destroy()

						ui.flags[self.flag] = nil

						if ui.currentSlider == self then
							ui.currentSlider = nil
						end
					end

					function Slider.update(self)
						local minValue = self.minValue
						local currentMousePosition = self.ui:getMouseLocation()
						local sliderFrame = self.sliderFrame

						local position = currentMousePosition.X - sliderFrame.AbsolutePosition.X
						self:set(minValue + ((position / sliderFrame.AbsoluteSize.X) * (self.maxValue - minValue)))
					end

					function Slider.set(self, newValue)
						local ui = self.ui

						local step = self.step
						local minValue = self.minValue
						local maxValue = self.maxValue
						local valueLabel = self.valueLabel

						newValue = math.round(math.clamp(newValue, minValue, maxValue) / step) * step

						self.innerSlider.Size = UDim2.fromScale((newValue - minValue) / (maxValue - minValue), 1)

						self.value = newValue
						ui.flags[self.flag] = newValue
						self.onChanged:Fire(newValue)

						local decimals = #(tostring(step):match("%.(%d+)") or "")
						local newText = string.format("%." .. tostring(decimals) .. "f", newValue) .. self.suffix
						valueLabel.Text = newText
					end
				end

				do
					function Dropdown.new(section, name, flag, options, value, multi, compact, closeAfterSelect, noNone)
						local ui = section.ui
						local theme = ui.theme

						local self = setmetatable({}, Dropdown)
						self.section = section

						self.ELEMENT_SIZE = 16

						local trim = (not compact and not Utils.hasDescender(name)) and 3 or 0

						local dropdownHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, compact and self.ELEMENT_SIZE - 2 or 30),
							BackgroundTransparency = 1,
						})

						local textBounds = Utils.getTextBounds(name, ui.font, ui.fontSize)

						local dropdownFrame = Utils.createInstance("TextButton", {
							Parent = dropdownHolder,
							Size = UDim2.new(
								1,
								compact and -(textBounds.X + 6) or 0,
								compact and 1 or 0,
								compact and 0 or 16
							),
							Position = UDim2.new(
								0,
								compact and textBounds.X + 5 or 0,
								compact and 0 or 1,
								compact and 0 or -16
							),
							BackgroundColor3 = WHITE,
						})

						Utils.createInstance("UIGradient", {
							Parent = dropdownFrame,
							Rotation = 90,
							Color = ColorSequence.new(theme.component, theme.componentDark),
						})

						Utils.createTextWithShadow({
							Parent = dropdownHolder,
							Size = UDim2.new(1, -31, 0, 12),
							Position = UDim2.fromOffset(-1, (compact and 0 or -3) + trim),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							Text = name,
						})

						Utils.createInstance("UIStroke", {
							Parent = dropdownFrame,
							Color = theme.stroke0,
						})

						local xSize = dropdownFrame.AbsoluteSize.Y

						local indicator = Utils.createInstance("Frame", {
							Parent = dropdownFrame,
							BackgroundColor3 = theme.dropdownIndicator,
							Size = UDim2.new(0, xSize, 1, 0),
							Position = UDim2.new(1, -xSize, 0, 0),
						})

						local openIndicatorLabel = Utils.createInstance("TextLabel", {
							Parent = indicator,
							Size = UDim2.fromScale(1, 1),
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							Text = "+",
						})

						Utils.connect(dropdownFrame.MouseButton1Down, function(input)
							self:setOpen(not self.open)
						end)

						local valueLabel = Utils.createInstance("TextLabel", {
							Parent = dropdownFrame,
							Size = UDim2.new(1, -(xSize + 8), 1, -8),
							Position = UDim2.fromOffset(4, 4),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							TextTruncate = Enum.TextTruncate.AtEnd,
						})

						self.dropdownHolder = dropdownHolder
						self.dropdownFrame = dropdownFrame
						self.valueLabel = valueLabel
						self.openIndicatorLabel = openIndicatorLabel
						self.closeAfterSelect = closeAfterSelect

						self.multi = multi
						self.options = options
						self.open = false
						self.noNone = noNone

						self.flag = flag
						self.value = value
						self.onChanged = Signal.new()

						value = multi and {} or value

						if multi then
							for _, option in options do
								value[option] = self:isChecked(option, value)
							end
						end

						self.optionLabels = {}
						self.ui = ui

						ui.elements[flag] = self
						self:set(value)

						return self
					end

					function Dropdown.destroy(self)
						local ui = self.ui

						local dropdownOptionsHolder = self.dropdownOptionsHolder

						self.dropdownHolder:Destroy()

						if dropdownOptionsHolder then
							dropdownOptionsHolder:Destroy()
						end

						if ui.currentDropdown == self then
							ui.currentDropdown = nil
						end

						ui.flags[self.flag] = nil
					end

					function Dropdown.getValueString(self)
						local value = self.value

						if not self.multi then
							return tostring(value)
						else
							return HttpService:JSONEncode(Utils.tableToArray(value))
						end
					end

					function Dropdown.isMouseInDropdown(self)
						local dropdownOptionsHolder = self.dropdownOptionsHolder
						local screenGui = self.ui.screenGui

						return Utils.isMouseInFrame(self.dropdownFrame, screenGui)
							or dropdownOptionsHolder and Utils.isMouseInFrame(dropdownOptionsHolder, screenGui)
					end

					function Dropdown.destroyDropdown(self)
						local dropdownOptionsHolder = self.dropdownOptionsHolder
						local optionLabels = self.optionLabels

						if dropdownOptionsHolder then
							dropdownOptionsHolder:Destroy()
						end

						for i = 1, #optionLabels do
							optionLabels[i] = nil
						end
					end

					function Dropdown.getSize(self)
						return self.ELEMENT_SIZE * #self.options
					end

					function Dropdown.updateLabels(self)
						local theme = self.ui.theme

						for element, label in self.optionLabels do
							label.TextColor3 = self:isChecked(element) and theme.accent or theme.text
						end
					end

					function Dropdown.getCheckedSize(self)
						local value = self.value
						local multi = self.multi

						local size = multi and 0 or (value and 1 or 0)

						if multi then
							for _, v in value do
								if v == true then
									size += 1
								end
							end
						end

						return size
					end

					function Dropdown.getDisplayValue(self)
						return self.multi and table.concat(Utils.tableToArray(self.value), ", ") or self.value
					end

					function Dropdown.set(self, value)
						local ui = self.ui
						local valueLabel = self.valueLabel

						local theme = ui.theme

						self.value = value
						ui.flags[self.flag] = value
						self:updateLabels()

						local size = self:getCheckedSize()

						valueLabel.Text = size == 0 and "none" or self:getDisplayValue()
						valueLabel.TextColor3 = size == 0 and theme.darkText or theme.text
						self.onChanged:Fire(value)
					end

					function Dropdown.createOptionsHolder(self)
						local ui = self.ui
						local theme = ui.theme

						local dropdownFrame = self.dropdownFrame
						local absoluteSize = dropdownFrame.AbsoluteSize
						local absolutePosition = dropdownFrame.AbsolutePosition

						local size = self:getSize()

						local dropdownOptionsHolder = Utils.createInstance("Frame", {
							Parent = ui.holder,
							BackgroundColor3 = WHITE,
							Position = UDim2.fromOffset(
								math.round(absolutePosition.X),
								math.round(absolutePosition.Y + absoluteSize.Y + 3)
							),
							Size = UDim2.fromOffset(absoluteSize.X, size + 4),
							ZIndex = ALWAYS_ON_TOP_ZINDEX,
						})

						Utils.createInstance("UIGradient", {
							Parent = dropdownOptionsHolder,
							Rotation = 90,
							Color = ColorSequence.new(theme.component, theme.componentDark),
						})

						self.ui:applyInset(dropdownOptionsHolder)

						Utils.createInstance("UIStroke", {
							Parent = dropdownOptionsHolder,
							Color = theme.stroke0,
						})

						Utils.createInstance("UIListLayout", {
							Parent = dropdownOptionsHolder,
							FillDirection = Enum.FillDirection.Vertical,
							Padding = UDim.new(0, 1),
						})

						Utils.createInstance("UIPadding", {
							Parent = dropdownOptionsHolder,
							PaddingRight = UDim.new(0, 4),
							PaddingTop = UDim.new(0, 4),
							PaddingBottom = UDim.new(0, 4),
							PaddingLeft = UDim.new(0, 4),
						})

						local options = self.options
						local closeAfterSelect = self.closeAfterSelect
						local elementSize = self.ELEMENT_SIZE
						local optionLabels = self.optionLabels
						local multi = self.multi
						local noNone = self.noNone

						for i = 1, #options do
							local element = options[i]

							local buttonFrame = Utils.createInstance("TextButton", {
								Parent = dropdownOptionsHolder,
								Size = UDim2.new(1, 0, 0, elementSize),
								BackgroundTransparency = 1,
							})

							optionLabels[element] = Utils.createInstance("TextLabel", {
								Parent = buttonFrame,
								Size = UDim2.new(1, -8, 1, -8),
								FontFace = ui.font,
								TextSize = ui.fontSize,
								TextXAlignment = Enum.TextXAlignment.Left,
								TextColor3 = self:isChecked(element) and theme.accent or theme.text,
								Text = element,
							})

							Utils.connect(buttonFrame.MouseButton1Down, function()
								local value = self.value

								if not multi then
									if noNone and value == element then
										return
									end

									self:set(element)
								else
									if noNone and self:getCheckedSize() == 1 and value[element] then
										return
									end

									value[element] = not value[element]
									self:set(value)
								end

								if closeAfterSelect then
									self:setOpen(false)
								end

								self:updateLabels()
							end)
						end

						self.dropdownOptionsHolder = dropdownOptionsHolder
					end

					function Dropdown.isChecked(self, element, value)
						value = value or self.value
						return self.multi and value[element] == true or element == value
					end

					function Dropdown.setOpen(self, state)
						if state then
							self:createOptionsHolder()
						else
							self:destroyDropdown()
						end

						local ui = self.ui

						local currentDropdown = ui.currentDropdown

						if currentDropdown and currentDropdown ~= self then
							currentDropdown:setOpen(false)
						end

						self.openIndicatorLabel.Text = state and "-" or "+"
						ui.currentDropdown = state and self or nil
						self.open = state
					end
				end

				do
					local shortInputs = {
						["MouseButton1"] = "MB1",
						["MouseButton2"] = "MB2",
						["MouseButton3"] = "MB3",
						["Insert"] = "Ins",
						["Minus"] = "-",
						["Equals"] = "=",
						["LeftAlt"] = "LAlt",
						["LeftControl"] = "LC",
						["LeftShift"] = "LS",
						["RightAlt"] = "RAlt",
						["RightControl"] = "RC",
						["RightShift"] = "RS",
						["CapsLock"] = "Caps",
						["Delete"] = "Del",
					}

					local function getKeyName(enumKey)
						local name = enumKey.Name
						local shortcut = shortInputs[name]

						if shortcut then
							return shortcut
						end

						if enumKey.EnumType == Enum.KeyCode then
							local stringKeycode = UserInputService:GetStringForKeyCode(enumKey)

							if stringKeycode ~= " " then
								name = UserInputService:GetStringForKeyCode(enumKey)
							end
						end

						return name
					end

					function Keybind.new(
						ui,
						section,
						componentHolder,
						name,
						flag,
						value,
						hold,
						ignoreKeybindList,
						toggle
					)
						local self = setmetatable({}, Keybind)

						local theme = ui.theme

						local keybindHolder = Utils.createInstance("TextButton", {
							Parent = componentHolder,
							Size = UDim2.fromOffset(0, 8),
							BackgroundTransparency = 1,
						})

						local textDisplay = Utils.createTextWithShadow({
							Parent = keybindHolder,
							Size = UDim2.fromScale(1, 1),
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.darkText,
							Position = UDim2.fromOffset(2, 0),
						})

						Utils.connect(keybindHolder.InputBegan, function(inputObject)
							if inputObject.UserInputType ~= MOUSE_BUTTON_1 then
								return
							end

							local currentKeybind = ui.currentKeybind

							if currentKeybind and currentKeybind ~= self then
								currentKeybind:setSelectState(false)
							end

							self:setSelectState(true)
							self.inputObject = inputObject
						end)

						self.textDisplay = textDisplay
						self.keybindHolder = keybindHolder
						self.section = section

						self.isSelecting = false

						self.name = name
						self.ui = ui
						self.toggle = toggle
						self.hold = hold

						self.key = value

						self.flag = flag
						self.value = toggle and toggle.value or false
						self.onChanged = Signal.new()

						local keybindIndex = #ui.keybinds + 1
						self.keybindIndex = keybindIndex
						ui.keybinds[keybindIndex] = self

						ui.elements[flag] = self
						self:set(value)

						if toggle and toggle.value then
							self:setValue(toggle.value)
						end

						if not ignoreKeybindList and not toggle then
							local listKey = ui.keybindList:createKey(self)
							self.listKey = listKey
							listKey:setActive(self.value)
							listKey:updateKey(value and getKeyName(value) or "none")
						end

						return self
					end

					function Keybind.getValueByString(self)
						return self.key and self.key.Name or nil
					end

					function Keybind.destroy(self)
						local ui = self.ui

						ui.keybinds[self.keybindIndex] = nil
						ui.flags[self.flag] = nil
					end

					function Keybind.setSelectState(self, state)
						self.ui.currentKeybind = state and self or nil
						self.isSelecting = state
						self:updateText(state and "..." or self.key)
					end

					function Keybind.getValue(self)
						return self.toggle and self.toggle.value or self.value
					end

					function Keybind.setValue(self, newValue)
						local toggle = self.toggle
						local listKey = self.listKey

						if toggle then
							toggle:set(newValue)
						end

						self.value = newValue
						self.ui.flags[self.flag] = newValue

						if listKey then
							listKey:setActive(newValue)
						end

						self.onChanged:Fire(newValue)
					end

					function Keybind.press(self)
						self:setValue(self.hold and true or not self:getValue())
					end

					function Keybind.release(self)
						if not self.hold then
							return
						end

						self:setValue(false)
					end

					function Keybind.updateText(self, text)
						local keybindHolder = self.keybindHolder
						local textDisplay = self.textDisplay

						local ui = self.ui
						local key = text or self.key

						local newText = key and "[" .. (self.isSelecting and key or getKeyName(key)) .. "]" or "[none]"
						local textBounds = Utils.getTextBounds(newText, ui.font, ui.fontSize)

						keybindHolder.Size = UDim2.fromOffset(textBounds.X + 1, keybindHolder.Size.Y.Offset)
						textDisplay.Text = newText

						local listKey = self.listKey
						if listKey then
							listKey:updateKey(key and getKeyName(key) or "none")
						end
					end

					function Keybind.set(self, key)
						local ui = self.ui

						ui.currentKeybind = nil
						self.isSelecting = false
						self.key = key
						self:updateText()
					end
				end

				do
					-- ugh this sucks
					local PADDING_X = 5
					local PADDING_Y = 8

					local SPACING = 7
					local HUE_SIZE = 16
					local TRANSPARENCY_SIZE = 14

					local TRANSPARENCY_OFFSET = 2
					local HOLDER_SIZE = Vector2.new(215, 193)

					function Colorpicker.new(
						ui,
						section,
						componentHolder,
						name,
						flag,
						color,
						transparency,
						drawingTransparency
					)
						local self = setmetatable({}, Colorpicker)
						local transparencyEnabled = transparency and true or false

						self.drawingTransparency = drawingTransparency
						self.transparencyEnabled = transparencyEnabled
						self.open = false
						self.popupOpen = false
						self.section = section

						local theme = ui.theme
						self.inputObject = nil

						self.ui = ui
						self.flag = flag
						self.transparency = transparency
						self.onChanged = Signal.new()
						self.color = color

						self.hue = 0

						self.pickingHue = false
						self.pickingColor = false
						self.pickingTransparency = false

						local colorpickerButtonFrame = Utils.createInstance("TextButton", {
							Parent = componentHolder,
							BackgroundColor3 = WHITE,
							Size = UDim2.new(0, 24, 1, 0),
						})

						Utils.createInstance("UIStroke", {
							Parent = colorpickerButtonFrame,
							Color = theme.stroke0,
						})

						local colorpickerGradient = Utils.createInstance("UIGradient", {
							Parent = colorpickerButtonFrame,
							Rotation = 90,
						})

						Utils.connect(colorpickerButtonFrame.MouseButton1Down, function(input)
							self:setOpen(not self.open)
						end)

						Utils.connect(colorpickerButtonFrame.MouseButton2Down, function(input)
							self:setPopupOpen(not self.open)
						end)

						local colorpickerPopupHolder = Utils.createInstance("Frame", {
							Parent = ui.holder,
							Visible = false,
							ZIndex = ALWAYS_ON_TOP_ZINDEX + 1,
							Size = UDim2.new(0, 50, 0, 0),
							AutomaticSize = Enum.AutomaticSize.Y,
							BackgroundColor3 = theme.section,
						})

						Utils.createStrokes(colorpickerPopupHolder, theme.stroke)

						local buttonHolders = Utils.createInstance("Frame", {
							Parent = colorpickerPopupHolder,
							BackgroundTransparency = 1,
							Size = UDim2.fromScale(1, 1),
							AutomaticSize = Enum.AutomaticSize.Y,
						})

						Utils.createInstance("UIPadding", {
							Parent = buttonHolders,
							PaddingBottom = UDim.new(0, 2),
						})

						Utils.createInstance("UIListLayout", {
							Parent = buttonHolders,
							FillDirection = Enum.FillDirection.Vertical,
						})

						local copyColor = Utils.createInstance("TextButton", {
							Parent = buttonHolders,
							TextTransparency = 0,
							BackgroundTransparency = 1,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
							Size = UDim2.new(1, 0, 0, 15),
							Text = "Copy",
						})

						Utils.connect(copyColor.MouseButton1Down, function()
							ui.copiedColor = self.color
							self:setPopupOpen(false)
						end)

						local pasteColor = Utils.createInstance("TextButton", {
							Parent = buttonHolders,
							TextTransparency = 0,
							BackgroundTransparency = 1,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							TextXAlignment = Enum.TextXAlignment.Center,
							TextYAlignment = Enum.TextYAlignment.Center,
							Size = UDim2.new(1, 0, 0, 15),
							Text = "Paste",
						})

						Utils.connect(pasteColor.MouseButton1Down, function()
							local copiedColor = ui.copiedColor
							if copiedColor then
								local hue = copiedColor:ToHSV()
								self:setHue(hue)
								self:setColor(copiedColor)
								self:setPopupOpen(false)
							end
						end)

						local colorpickerHolder = Utils.createInstance("Frame", {
							Parent = ui.holder,
							Visible = false,
							ZIndex = ALWAYS_ON_TOP_ZINDEX,
							Size = UDim2.fromOffset(
								HOLDER_SIZE.X,
								(
									transparencyEnabled and HOLDER_SIZE.Y + TRANSPARENCY_SIZE + TRANSPARENCY_OFFSET
									or HOLDER_SIZE.Y
								)
							),
							BackgroundColor3 = theme.section,
						})

						Utils.createInstance("TextButton", {
							Parent = colorpickerHolder,
							Size = UDim2.fromScale(1, 1),
							BackgroundTransparency = 1,
						})

						local accentBar = Utils.createInstance("Frame", {
							Parent = colorpickerHolder,
							Size = UDim2.new(1, 0, 0, 2),
							BackgroundColor3 = WHITE,
						})

						Utils.createInstance("UIGradient", {
							Parent = accentBar,
							Color = ColorSequence.new(theme.accent, theme.accentDark),
							Rotation = 90,
						})

						Utils.createTextWithShadow({
							Parent = colorpickerHolder,
							Position = UDim2.fromOffset(5, -6),
							Size = UDim2.new(1, -16, 0, 10),
							FontFace = ui.font,
							TextSize = ui.fontSize,
							Text = name,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextColor3 = theme.text,
							ZIndex = 3,
						})

						local textBounds = Utils.getTextBounds(name, ui.font, ui.fontSize)

						Utils.createInstance("Frame", {
							Parent = colorpickerHolder,
							BackgroundColor3 = theme.section,
							Position = UDim2.fromOffset(2, -2),
							Size = UDim2.fromOffset(textBounds.X + 7, 4),
							ZIndex = 2,
						})

						local transparencyOffset = transparencyEnabled and HUE_SIZE + TRANSPARENCY_OFFSET or 0
						local topOffset = PADDING_Y
						local rightOffset = PADDING_X + HUE_SIZE + SPACING

						local colorpickerGradientHolder = Utils.createInstance("ImageButton", {
							Parent = colorpickerHolder,
							Image = "rbxassetid://2615689005",
							Position = UDim2.fromOffset(PADDING_X, topOffset),
							Size = UDim2.new(
								1,
								-rightOffset - PADDING_X,
								1,
								-topOffset - PADDING_Y - transparencyOffset
							),
						})

						local huePicker = Utils.createInstance("TextButton", {
							Parent = colorpickerHolder,
							Position = UDim2.new(1, -(PADDING_X + HUE_SIZE), 0, topOffset),
							Size = UDim2.new(0, HUE_SIZE, 1, -topOffset - PADDING_Y - transparencyOffset),
						})

						local hueVisualizer = Utils.createInstance("Frame", {
							Parent = huePicker,
							BackgroundColor3 = WHITE,
							Size = UDim2.new(1, 0, 0, 2),
						})

						local colorVisualizer = Utils.createInstance("Frame", {
							Parent = colorpickerGradientHolder,
							BackgroundColor3 = WHITE,
							Size = UDim2.fromOffset(3, 3),
						})

						Utils.createInstance("UIGradient", {
							Parent = huePicker,
							Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
								ColorSequenceKeypoint.new(0.166, Color3.fromRGB(255, 255, 0)),
								ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
								ColorSequenceKeypoint.new(0.666, Color3.fromRGB(0, 0, 255)),
								ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
							}),
							Rotation = 90,
						})

						if transparencyEnabled then
							local transparencyPicker = Utils.createInstance("Frame", {
								Parent = colorpickerHolder,
								Size = UDim2.new(1, -rightOffset - PADDING_X, 0, TRANSPARENCY_SIZE),
								Position = UDim2.new(
									0,
									PADDING_X,
									1,
									TRANSPARENCY_OFFSET - (TRANSPARENCY_SIZE + SPACING)
								),
								BackgroundColor3 = theme.component,
							})

							local transparencyPickerColor = Utils.createInstance("TextButton", {
								Parent = transparencyPicker,
								Size = UDim2.fromScale(1, 1),
							})

							local transparencyVisualizer = Utils.createInstance("Frame", {
								Parent = transparencyPickerColor,
								Size = UDim2.new(0, 2, 1, 0),
								BackgroundColor3 = WHITE,
							})

							Utils.createInstance("UIGradient", {
								Parent = transparencyPickerColor,
								Transparency = NumberSequence.new({
									NumberSequenceKeypoint.new(0, 0),
									NumberSequenceKeypoint.new(1, 1),
								}),
							})

							Utils.createInstance("UIStroke", {
								Parent = transparencyVisualizer,
								Color = theme.stroke0,
							})

							Utils.createInstance("UIStroke", {
								Parent = transparencyPicker,
								Color = theme.stroke0,
							})

							Utils.connect(transparencyPickerColor.MouseButton1Down, function()
								self.pickingTransparency = true
								self:updateTransparency(ui:getMouseLocation())
							end)

							self.transparencyPickerColor = transparencyPickerColor
							self.transparencyVisualizer = transparencyVisualizer
						end

						Utils.createInstance("UIStroke", {
							Parent = colorVisualizer,
							Color = theme.stroke0,
						})

						Utils.createInstance("UIStroke", {
							Parent = hueVisualizer,
							Color = theme.stroke0,
						})

						Utils.createInstance("UIStroke", {
							Parent = colorpickerGradientHolder,
							Color = theme.stroke0,
						})

						Utils.createInstance("UIStroke", {
							Parent = huePicker,
							Color = theme.stroke0,
						})

						Utils.createStrokes(colorpickerHolder, theme.stroke)

						Utils.connect(huePicker.MouseButton1Down, function()
							self.pickingHue = true
							self:updateHue(ui:getMouseLocation())
						end)

						Utils.connect(colorpickerGradientHolder.MouseButton1Down, function()
							self.pickingColor = true
							self:updateColor(ui:getMouseLocation())
						end)

						self.colorpickerHolder = colorpickerHolder
						self.colorpickerPopupHolder = colorpickerPopupHolder
						self.colorpickerButtonFrame = colorpickerButtonFrame
						self.colorpickerGradient = colorpickerGradient
						self.colorpickerGradientHolder = colorpickerGradientHolder
						self.huePicker = huePicker

						self.hueVisualizer = hueVisualizer
						self.colorVisualizer = colorVisualizer

						ui.elements[flag] = self
						self:set(color, transparency and 1 - transparency or nil)

						return self
					end

					function Colorpicker.updateTransparency(self, mousePosition)
						local transparencyPickerColor = self.transparencyPickerColor

						local transparencyWidth = transparencyPickerColor.AbsoluteSize.X
						local x = math.clamp(
							mousePosition.X - transparencyPickerColor.AbsolutePosition.X,
							0,
							transparencyWidth
						)

						self:setTransparency(1 - (x / transparencyWidth))
						self:updateValue()
					end

					function Colorpicker.updateColor(self, mousePosition)
						local colorpickerGradientHolder = self.colorpickerGradientHolder

						local colorSize = colorpickerGradientHolder.AbsoluteSize
						local x =
							math.clamp(mousePosition.X - colorpickerGradientHolder.AbsolutePosition.X, 0, colorSize.X)
						local y =
							math.clamp(mousePosition.Y - colorpickerGradientHolder.AbsolutePosition.Y, 0, colorSize.Y)

						self:setColor(Color3.fromHSV(self.hue, x / colorSize.X, 1 - (y / colorSize.Y)))
						self:updateValue()
					end

					function Colorpicker.updateHue(self, mousePosition)
						local huePicker = self.huePicker

						local hueHeight = huePicker.AbsoluteSize.Y
						self:setHue(
							math.clamp(mousePosition.Y - huePicker.AbsolutePosition.Y, 0, hueHeight) / hueHeight
						)
					end

					function Colorpicker:getHuePosition(hue)
						return hue * self.huePicker.AbsoluteSize.Y
					end

					function Colorpicker:getColorPosition(color)
						local _, s, v = color:ToHSV()
						local size = self.colorpickerGradientHolder.AbsoluteSize

						return s * size.X, (1 - v) * size.Y
					end

					function Colorpicker.setTransparency(self, transparency)
						local transparencyVisualizer = self.transparencyVisualizer

						transparencyVisualizer.Position = UDim2.new(
							0,
							((1 - transparency) * self.transparencyPickerColor.AbsoluteSize.X)
								- (transparencyVisualizer.AbsoluteSize.X / 2),
							0.5,
							-transparencyVisualizer.AbsoluteSize.Y / 2
						)
						self.transparency = self.drawingTransparency and transparency or 1 - transparency
					end

					function Colorpicker.setHue(self, hue)
						self.hue = hue
						self.colorpickerGradientHolder.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)

						self.colorVisualizer.Visible = false
						self.hueVisualizer.Position = UDim2.fromOffset(0, self:getHuePosition(hue))
					end

					function Colorpicker.setColor(self, color)
						self.color = color
						self.colorpickerGradient.Color = ColorSequence.new(color, Utils.darkenColor(color, 0.5))

						if self.transparencyEnabled then
							self.transparencyPickerColor.BackgroundColor3 = color
						end

						local colorVisualizer = self.colorVisualizer
						local x, y = self:getColorPosition(color)

						colorVisualizer.Visible = true
						colorVisualizer.Position = UDim2.fromOffset(x, y)
					end

					function Colorpicker.setPopupOpen(self, state)
						local ui = self.ui
						local currentColorpickerPopup = ui.currentColorpickerPopup
						local colorpickerPopupHolder = self.colorpickerPopupHolder

						if currentColorpickerPopup and currentColorpickerPopup ~= self then
							currentColorpickerPopup:setPopupOpen(false)
						end

						if state then
							local mouseLocation = ui:getMouseLocation()
							colorpickerPopupHolder.Position = UDim2.fromOffset(mouseLocation.X, mouseLocation.Y)
							ui:applyInset(colorpickerPopupHolder)
						end

						colorpickerPopupHolder.Visible = state
						ui.currentColorpickerPopup = state and self or nil
						self.popupOpen = state
					end

					function Colorpicker.setOpen(self, state)
						local ui = self.ui
						local colorpickerHolder = self.colorpickerHolder
						local colorpickerButtonFrame = self.colorpickerButtonFrame

						local currentColorpicker = ui.currentColorpicker

						if currentColorpicker and currentColorpicker ~= self then
							currentColorpicker:setOpen(false)
						end

						if state then
							colorpickerHolder.Position = UDim2.fromOffset(
								colorpickerButtonFrame.AbsolutePosition.X + colorpickerButtonFrame.AbsoluteSize.X + 4,
								colorpickerButtonFrame.AbsolutePosition.Y + 2
							)

							ui:applyInset(colorpickerHolder)
						end

						if self.popupOpen then
							self:setPopupOpen(false)
						end

						colorpickerHolder.Visible = state
						ui.currentColorpicker = state and self or nil
						self.open = state
					end

					function Colorpicker.isMouseInColorpicker(self)
						local screenGui = self.ui.screenGui

						return Utils.isMouseInFrame(self.colorpickerHolder, screenGui)
							or Utils.isMouseInFrame(self.colorpickerButtonFrame, screenGui)
					end

					function Colorpicker.isMouseInColorpickerPopup(self)
						local screenGui = self.ui.screenGui

						return Utils.isMouseInFrame(self.colorpickerPopupHolder, screenGui)
							or Utils.isMouseInFrame(self.colorpickerButtonFrame, screenGui)
					end

					function Colorpicker.updateValue(self)
						local newValue = self.transparencyEnabled
								and { color = self.color, transparency = self.transparency }
							or self.color

						self.ui.flags[self.flag] = newValue
						self.onChanged:Fire(newValue)
					end

					function Colorpicker.set(self, color, transparency)
						local hue = color:ToHSV()

						self:setHue(hue)
						self:setColor(color)

						if self.transparencyEnabled then
							self:setTransparency(transparency)
						end

						self:updateValue()
					end
				end

				do
					function Textbox.new(section, name, flag, value, placeholder, compact)
						local self = setmetatable({}, Textbox)

						local ui = section.ui
						local theme = ui.theme

						local trim = (not compact and not Utils.hasDescender(name)) and 3 or 0

						local textboxHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, compact and 14 or 30),
							BackgroundTransparency = 1,
						})

						local textBounds = Utils.getTextBounds(name, ui.font, ui.fontSize)

						local textboxContentHolder = Utils.createInstance("Frame", {
							Parent = textboxHolder,
							Size = UDim2.new(
								1,
								compact and -(textBounds.X + 6) or 0,
								compact and 1 or 0,
								compact and 0 or 16
							),
							Position = UDim2.new(
								0,
								compact and textBounds.X + 5 or 0,
								compact and 0 or 1,
								compact and 0 or -16
							),
							BackgroundColor3 = WHITE,
						})

						Utils.createInstance("UIGradient", {
							Parent = textboxContentHolder,
							Rotation = 90,
							Color = ColorSequence.new(theme.component, theme.componentDark),
						})

						local textbox = Utils.createInstance("TextBox", {
							Parent = textboxContentHolder,
							BackgroundTransparency = 1,
							Text = value,
							ClearTextOnFocus = false,
							TextTruncate = Enum.TextTruncate.AtEnd,
							TextXAlignment = Enum.TextXAlignment.Left,
							TextColor3 = theme.text,
							PlaceholderColor3 = theme.darkText,
							PlaceholderText = placeholder,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							Position = UDim2.fromOffset(2, 2),
							Size = UDim2.new(1, -4, 1, -4),
						})

						Utils.createInstance("UIStroke", {
							Parent = textboxContentHolder,
							Color = theme.stroke0,
						})

						Utils.createTextWithShadow({
							Parent = textboxHolder,
							Size = UDim2.new(1, -31, 0, 12),
							Position = UDim2.fromOffset(-1, (compact and 0 or -3) + trim),
							TextXAlignment = Enum.TextXAlignment.Left,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							TextColor3 = theme.text,
							Text = name,
						})

						Utils.connect(textbox:GetPropertyChangedSignal("Text"), function()
							self:setValues(textbox.Text)
						end)

						self.textbox = textbox

						self.flag = flag
						self.value = value
						self.onChanged = Signal.new()

						self.ui = ui

						ui.elements[flag] = self
						self:set(value)

						return self
					end

					function Textbox.updateText(self, value)
						self.textbox.Text = value
					end

					function Textbox.set(self, value)
						self:setValues(value)
						self:updateText(value)
					end

					function Textbox.setValues(self, value)
						self.value = value
						self.ui.flags[self.flag] = value
						self.onChanged:Fire(value)
					end
				end

				do
					function Button.new(section, name)
						local self = setmetatable({}, Button)

						local ui = section.ui
						local theme = ui.theme

						local button = Utils.createInstance("TextButton", {
							Parent = section.container,
							Size = UDim2.new(1, 0, 0, 16),
							Position = UDim2.new(0, 0, 1, -16),
							BackgroundColor3 = WHITE,
						})

						Utils.createInstance("UIGradient", {
							Parent = button,
							Rotation = 90,
							Color = ColorSequence.new(theme.component, theme.componentDark),
						})

						Utils.createInstance("UIStroke", {
							Parent = button,
							Color = theme.stroke0,
						})

						Utils.createTextWithShadow({
							Parent = button,
							TextYAlignment = Enum.TextYAlignment.Center,
							TextXAlignment = Enum.TextXAlignment.Center,
							Text = name,
							TextColor3 = theme.text,
							FontFace = ui.font,
							TextSize = ui.fontSize,
							Size = UDim2.fromScale(1, 1),
						})

						local onPressed = Signal.new()

						Utils.connect(button.MouseButton1Down, function()
							onPressed:Fire()
						end)

						self.onPressed = onPressed
						self.ui = ui

						return self
					end
				end

				do
					function List.new(section, flag, size)
						local self = setmetatable({}, List)

						local ui = section.ui
						local theme = ui.theme

						local listHolder = Utils.createInstance("ScrollingFrame", {
							Parent = section.container,
							BackgroundColor3 = theme.component,
							Size = UDim2.new(1, 0, 0, size),
							CanvasSize = UDim2.fromOffset(0, 0),
							AutomaticCanvasSize = Enum.AutomaticSize.Y,
							ScrollingDirection = Enum.ScrollingDirection.Y,
							ScrollBarThickness = 0,
							ScrollBarImageTransparency = 1,
							VerticalScrollBarInset = Enum.ScrollBarInset.None,
						})

						Utils.createInstance("UIListLayout", {
							Parent = listHolder,
							FillDirection = Enum.FillDirection.Vertical,
						})

						Utils.createInstance("UIPadding", {
							Parent = listHolder,
							PaddingTop = UDim.new(0, 5),
							PaddingBottom = UDim.new(0, 5),
						})

						Utils.createInstance("UIStroke", {
							Parent = listHolder,
							Color = theme.stroke0,
						})

						self.listHolder = listHolder
						self.ui = ui
						self.flag = flag
						self.optionLabels = {}
						self.onChanged = Signal.new()

						return self
					end

					function List.set(self, option)
						local ui = self.ui
						local theme = ui.theme

						for index, optionLabel in self.optionLabels do
							optionLabel.TextColor3 = index == option and theme.accent or theme.text
						end

						ui.flags[self.flag] = option
						self.onChanged:Fire(option)
					end

					function List.updateList(self, options)
						self.ui.flags[self.flag] = nil

						local ui = self.ui
						local theme = ui.theme
						local optionLabels = self.optionLabels

						for index, optionLabel in optionLabels do
							optionLabel:Destroy()
							optionLabels[index] = nil
						end

						for i, option in options do
							local newLabel = Utils.createInstance("TextButton", {
								Parent = self.listHolder,
								Size = UDim2.new(1, 0, 0, 15),
								Text = option,
								FontFace = ui.font,
								TextSize = ui.fontSize,
								TextColor3 = theme.text,
								TextTransparency = 0,
								BackgroundTransparency = 1,
							})

							Utils.connect(newLabel.MouseButton1Down, function()
								self:set(option)
							end)

							optionLabels[option] = newLabel
						end
					end
				end

				do
					function Divider.new(section)
						local self = setmetatable({}, Divider)

						local theme = section.ui.theme

						local dividerHolder = Utils.createInstance("Frame", {
							Parent = section.container,
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 3),
						})

						local divider = Utils.createInstance("Frame", {
							Parent = dividerHolder,
							BackgroundColor3 = theme.component,
							Size = UDim2.new(1, 0, 0, 1),
						})

						Utils.createInstance("UIStroke", {
							Parent = divider,
							Color = theme.stroke1,
						})

						return self
					end
				end
			end

			function Section.new(name, holder, ui, autoSize)
				local self = setmetatable({}, Section)

				self.isFloating = false
				self.autoSize = autoSize

				local sectionHolder = holder

				local container = Utils.createInstance("ScrollingFrame", {
					Parent = sectionHolder,
					Size = UDim2.new(1, -8, 1, -5),
					Position = UDim2.fromOffset(4, 3),
					BackgroundTransparency = 1,
					CanvasSize = UDim2.fromOffset(0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					VerticalScrollBarInset = Enum.ScrollBarInset.None,
				})

				Utils.createInstance("UIPadding", {
					Parent = container,
					PaddingRight = UDim.new(0, 3),
					PaddingTop = UDim.new(0, 5),
					PaddingBottom = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 3),
				})

				local uiListLayout = Utils.createInstance("UIListLayout", {
					Parent = container,
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, 7),
				})

				if autoSize then
					Utils.connect(uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						self:updateSize()
					end)
				end

				--[[
				if fill then
					Utils.createInstance("UIFlexItem", {
						Parent = sectionHolder,
						FlexMode = Enum.UIFlexMode.Fill,
					})
				end

				if not fill and autoSize then
					Utils.connect(uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						self:updateSize()
					end)
				end
				]]

				self.sectionFrame = holder
				self.container = container
				self.theme = ui.theme
				self.ui = ui
				self.uiListLayout = uiListLayout
				self.autoSize = autoSize
				self.name = name

				return self
			end

			function Section.updateSize(self)
				if self.autoSize then
					local sectionFrame = self.sectionFrame
					local parent = sectionFrame.Parent
					local parentUiListLayout = parent:FindFirstChildWhichIsA("UIListLayout")

					local sizeY = self.uiListLayout.AbsoluteContentSize.Y + 15
					local previousSize = sectionFrame.Size

					sectionFrame.Size = UDim2.new(
						previousSize.X.Scale,
						previousSize.X.Offset,
						previousSize.Y.Scale,
						--[[ parentUiListLayout
								and math.min(
									sizeY,
									parent.AbsoluteSize.Y
										- parentUiListLayout.AbsoluteContentSize.Y
										+ sectionFrame.AbsoluteSize.Y
								)
							or --]]
						sizeY
					)
				end
			end

			function Section.toggle(self, properties)
				properties = properties or {}

				local name = properties.name or "toggle"
				local flag = properties.flag or name
				local default = (properties.default or properties.value) or false

				return Toggle.new(self, name, flag, default)
			end

			function Section.label(self, name)
				return Label.new(self, name or "label")
			end

			function Section.slider(self, properties)
				properties = properties or {}

				local name = properties.name or "slider"
				local flag = properties.flag or name
				local value = (properties.default or properties.value) or 15
				local step = properties.step or 1
				local suffix = properties.suffix or ""
				local minValue = properties.min or 0
				local maxValue = properties.max or 25
				local compact = properties.compact or false

				return Slider.new(self, name, flag, value, minValue, maxValue, step, suffix, compact)
			end

			function Section.dropdown(self, properties)
				properties = properties or {}

				local name = properties.name or "dropdown"
				local noNone = properties.noNone or false
				local flag = properties.flag or name
				local options = (properties.options or properties.list) or { "hello", "world" }
				local multi = properties.multi or false
				local value = (properties.default or properties.value)
					or (multi and (noNone and { [options[1]] = true } or {}) or options[1])
				local compact = properties.compact or false
				local closeAfterSelect = properties.closeAfterSelect or false

				if multi and type(value) ~= "table" and type(value) == "string" then
					value = { value }
				end

				return Dropdown.new(self, name, flag, options, value, multi, compact, closeAfterSelect, noNone)
			end

			function Section.textbox(self, properties)
				properties = properties or {}

				local name = properties.name or "textbox"
				local flag = properties.flag or name
				local default = properties.default or ""
				local placeholder = properties.placeholder or ""
				local compact = properties.compact or false

				return Textbox.new(self, name, flag, default, placeholder, compact)
			end

			function Section.button(self, name)
				return Button.new(self, name)
			end

			function Section.list(self, properties)
				properties = properties or {}

				local flag = properties.flag or "list"
				local size = properties.size or 150

				return List.new(self, flag, size)
			end

			function Section.divider(self)
				return Divider.new(self)
			end
		end

		local Tab = {}
		Tab.__index = Tab
		Tab.SIDE_CONTENT_SIZE = 200

		do
			function Tab.new(name, ui)
				local allTabs = ui.tabs

				local self = setmetatable({}, Tab)
				self.ui = ui
				self.selected = #allTabs == 0

				local sideContent = Utils.createInstance("Frame", {
					Parent = ui.mainFrame,
					Position = UDim2.new(1, 5, 0, 0),
					Size = UDim2.new(0, self.SIDE_CONTENT_SIZE, 1, 0),
					BackgroundTransparency = 1,
				})

				Utils.createInstance("UIListLayout", {
					Parent = sideContent,
					FillDirection = Enum.FillDirection.Vertical,
					Padding = UDim.new(0, 3),
				})

				self.sideContent = sideContent
				local theme = ui.theme

				local tabFrame = Utils.createInstance("TextButton", {
					Parent = ui.tabsHolder,
					BackgroundColor3 = theme.activeTabButton,
					Size = UDim2.fromScale(1, 1),
				})

				local buttonText = Utils.createTextWithShadow({
					Parent = tabFrame,
					FontFace = ui.font,
					TextSize = ui.fontSize,
					TextColor3 = theme.darkText,
					Size = UDim2.fromScale(1, 1),
					Text = name,
				})

				local accentBar = Utils.createInstance("Frame", {
					Parent = tabFrame,
					Visible = false,
					BackgroundColor3 = WHITE,
					Size = UDim2.new(1, -30, 0, 2),
					Position = UDim2.new(0, 15, 1, -2),
				})

				Utils.createInstance("UIGradient", {
					Parent = accentBar,
					Rotation = 90,
					Color = ColorSequence.new(theme.accent, theme.accentDark),
				})

				allTabs[#allTabs + 1] = self

				Utils.connect(tabFrame.MouseButton1Down, function()
					self:select(true)
				end)

				local container = Utils.createInstance("Frame", {
					Parent = ui.sectionFrame,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(1, 1), -- UDim2.new(1, -16, 1, -24),
					-- Position = UDim2.fromOffset(8, 12),
				})

				Utils.createInstance("UIListLayout", {
					Parent = container,
					HorizontalFlex = Enum.UIFlexAlignment.Fill,
					FillDirection = Enum.FillDirection.Horizontal,
				})

				local leftSide = Utils.createInstance("ScrollingFrame", {
					Parent = container,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0, 1),
					CanvasSize = UDim2.fromOffset(0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					VerticalScrollBarInset = Enum.ScrollBarInset.None,
				})

				local rightSide = Utils.createInstance("ScrollingFrame", {
					Parent = container,
					BackgroundTransparency = 1,
					Size = UDim2.fromScale(0, 1),
					CanvasSize = UDim2.fromOffset(0, 0),
					AutomaticCanvasSize = Enum.AutomaticSize.Y,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ScrollBarThickness = 0,
					ScrollBarImageTransparency = 1,
					VerticalScrollBarInset = Enum.ScrollBarInset.None,
				})

				for i = 1, 2 do
					local side = i == 1 and leftSide or rightSide
					local isLeft = i == 1

					Utils.createInstance("UIPadding", {
						Parent = side,
						PaddingLeft = UDim.new(0, isLeft and 8 or 5),
						PaddingRight = UDim.new(0, isLeft and 5 or 8),
						PaddingTop = UDim.new(0, 24 / 2),
						PaddingBottom = UDim.new(0, 12 / 2),
					})

					Utils.createInstance("UIListLayout", {
						Parent = side,
						FillDirection = Enum.FillDirection.Vertical,
						Padding = UDim.new(0, 12),
					})
				end

				self.container = container
				self.leftSide = leftSide
				self.rightSide = rightSide

				self.tabFrame = tabFrame
				self.accentBar = accentBar
				self.buttonText = buttonText

				self:select(self.selected)

				return self
			end

			function Tab.select(self, state)
				local ui = self.ui

				local allTabs = ui.tabs
				local theme = ui.theme

				if state then
					for i = 1, #allTabs do
						local tab = allTabs[i]

						if tab ~= self then
							tab:select(false)
						end
					end

					self.selectedTab = self
				end

				self.buttonText.TextColor3 = state and theme.text or theme.darkText
				self.tabFrame.BackgroundTransparency = state and 0 or 1
				self.sideContent.Visible = state
				self.accentBar.Visible = state
				self.container.Visible = state
				self.selected = state
			end

			function Tab.section(self, properties)
				properties = properties or {}

				local ui = self.ui
				local theme = ui.theme

				local name = properties.name or "section"
				local side = properties.side or LEFT_SIDE
				local size = properties.size or 100
				local autoSize = properties.autoSize or properties.autoSize == nil and true

				local holder = Utils.createInstance("Frame", {
					Parent = side == LEFT_SIDE and self.leftSide or side == RIGHT_SIDE and self.rightSide,
					Size = UDim2.new(1, 0, 0, size),
					BackgroundColor3 = theme.section,
				})

				Utils.createStrokes(holder, theme.stroke)

				local accentBar = Utils.createInstance("Frame", {
					Parent = holder,
					Size = UDim2.new(1, 0, 0, 2),
					BackgroundColor3 = WHITE,
				})

				Utils.createInstance("UIGradient", {
					Parent = accentBar,
					Color = ColorSequence.new(theme.accent, theme.accentDark),
					Rotation = 90,
				})

				if name then
					Utils.createTextWithShadow({
						Parent = holder,
						Position = UDim2.fromOffset(5, -6),
						Size = UDim2.new(1, -16, 0, 10),
						FontFace = ui.font,
						TextSize = ui.fontSize,
						ZIndex = 3,
						Text = name,
						TextXAlignment = Enum.TextXAlignment.Left,
						TextColor3 = theme.text,
					})

					local textBounds = Utils.getTextBounds(name, ui.font, ui.fontSize)

					Utils.createInstance("Frame", {
						Parent = holder,
						BackgroundColor3 = theme.section,
						Position = UDim2.fromOffset(2, -2),
						ZIndex = 2,
						Size = UDim2.fromOffset(textBounds.X + 7, 4),
					})
				end

				return Section.new(name, holder, ui, autoSize)
			end
		end

		function UI.tab(self, name)
			return Tab.new(name, self)
		end
	end

	Library = UI
end

const Visuals = { }; do
	const CachedObjects = { };

	LPH_NO_VIRTUALIZE( function( )
		function Visuals : Players( )
			const Configuration = { }; do
				const MasterSwitch = Flags[ "Visuals / Players / Enabled" ];

				if ( not MasterSwitch ) then
					return TableClear( CachedObjects );
				end

				-- Health Bar
				do
					const Enabled = Flags[ "Visuals / Players / HealthBar / Enabled" ];
					const Color = Flags[ "Visuals / Players / HealthBar / Color" ];

					if ( Enabled ) then
						Configuration.HealthBar = Color;
					end
				end

				-- Country
				do
					const Enabled = Flags[ "Visuals / Players / Country / Enabled" ];
					const Color = Flags[ "Visuals / Players / Country / Color" ];

					if ( Enabled ) then
						Configuration.Tool = Color;
					end
				end

				-- Name
				do
					const Enabled = Flags[ "Visuals / Players / Name / Enabled" ];
					const Color = Flags[ "Visuals / Players / Name / Color" ];

					if ( Enabled ) then
						Configuration.Name = Color;
					end
				end

				-- Box
				do
					const Enabled = Flags[ "Visuals / Players / Box / Enabled" ];
					const Color = Flags[ "Visuals / Players / Box / Color" ];

					if ( Enabled ) then
						Configuration.Box = Color;
					end
				end
			
				CacheObject.Configuration = Configuration;
			end

			for _, Object in Replicators : GetPlayers( true ) do
				const RootPart, Character = Object : RootPart( );

				if ( not RootPart ) then
					continue;
				end
				
				const CollisionObject = Object : Collision( );

				if ( not CollisionObject ) then
					continue;
				end

				const Player = Object : Player( );
				const Name = Object : Name( );

				if ( not Player ) then
					continue;
				end

				const ESPObject = CachedObjects[ Character ] or CacheObject : Initiate( Name, function( Self )
					CachedObjects[ Character ] = Self;
				end ); do
					const Health, MaxHealth = Object : Health( );
					ESPObject.MaxHealth = MaxHealth;
					ESPObject.Health = Health;
					
					if ( Health >= 1 ) then
						const Size = CollisionObject : GetExtentsSize( );
						const Country = Object : Country( );

						ESPObject.Offset = Vector3New( 0, -.6, 0 );
						
						ESPObject.Position = RootPart.Position;
						ESPObject.Tool = Country or "Unknown";

						ESPObject.Size = Size;

						ESPObject : Respawn( );
					end

					if ( Health <= 0 ) then
						ESPObject : Died( );
					end

					ESPObject : Stepper( );
				end
			end
		end

		function Visuals : Screen( )
			const NumSides, Circle = 67, DrawingImmediate.Circle;

			for Index, Value in { "SilentAim", "Aimbot" } do
				const BaseFlag = "Combat / { Value }";

				if ( Flags[ `{ BaseFlag } / Range / Enabled` ] ) then
					const Color = Flags[ `{ BaseFlag } / Range / Color` ];
					const Range = Flags[ `{ BaseFlag } / Range / Value` ];

					Circle( Center, Range, Black, 1, NumSides, 3 ); -- Outline
					Circle( Center, Range, Color, 1, NumSides, 1 ); -- Main
				end
			end
		end

		function Visuals : Stepper( )
			self : Players( );
			self : Screen( );
		end
	end )( );
end

const Setters = { }; do
	local PenetratableStamp = 0;

	LPH_NO_VIRTUALIZE( function( )
		function Setters : Stepper( )
			const Dimensions = CurrentCamera.ViewportSize;
			CameraCFrame = CurrentCamera.CFrame;

			Center = Dimensions * .5;
			GameTick = tick( );

			const RagebotEnabled = Flags[ "Combat / Ragebot / Enabled" ]; do
				Storage : Add( "Ragebot / REM_ANIM_PROCEED", RagebotEnabled and not Flags[ "Combat / Ragebot / Effects" ] );
				Storage : Add( "Ragebot / AWALL_PROCEED", RagebotEnabled and Flags[ "Combat / Ragebot / AutoWall" ] );
			end

			const FireRateEnabled = Flags[ "Combat / Mods / FireRate / Enabled" ]; do
				Storage : Add( "Mods / FIRE_RATE_MULTI", ( FireRateEnabled and Flags[ "Combat / Mods / FireRate / Multiplier" ] ) or 1 );
			end

			if ( ( GameTick - PenetratableStamp ) > 4 ) and Storage : Get( "Ragebot / AWALL_PROCEED" ) then
				const Penetratables = Workspace : QueryDescendants( ScannerQuery ); do
					Storage : Add( "Ragebot / PENETRATABLES", Penetratables );
				end

				PenetratableStamp = GameTick;
			end
		end
	end )( );
end

const Misc = { }; do
	local CurrentOrientation = 0;

	LPH_NO_VIRTUALIZE( function( )
		function Misc : Stepper( )
			self : Player( );
		end

		function Misc : Player( )
			const StateObject, CollisionObject = Controller : Get( );

			if ( not StateObject ) or ( not CollisionObject ) then
				return;
			end

			const States = StateObject.states;
			const Values = StateObject.values;

			-- Walk Speed
			do
				const Enabled = KeybindFlags[ "Misc / Player / WalkSpeed / Enabled" ];
				const Value = Flags[ "Misc / Player / WalkSpeed / Multiplier" ];

				const SpeedMultiplier = States.speed_multiplier;
				
				if ( not Enabled ) and ( SpeedMultiplier : get( ) == Value ) then
					SpeedMultiplier : set( 1 );
				end -- i don't like elseif statements, sorry

				if ( Enabled ) then
					SpeedMultiplier : set( Value );
				end
			end

			-- Anti Aim
			do
				const Enabled = Flags[ "Misc / Player / AntiAim / Enabled" ];
				const Speed = Flags[ "Misc / Player / AntiAim / Speed" ];

				const NewValue = ( Enabled and 360 ) or 80;
				const FOV = Values.fov;

				if ( FOV : get( ) ~= NewValue ) then
					FOV : set( NewValue );
				end
				
				if ( Enabled ) then
					const HumanoidRootPart = CollisionObject : FindFirstChild( "HumanoidRootPart" );
					CurrentOrientation = ( CurrentOrientation + ( Speed * .002 ) ) % ( Math360Rad )
				
					if ( HumanoidRootPart ) then
						const Spinbot = Flags[ "Misc / Player / AntiAim / Spinbot" ];

						const CoordinateFrame = CFrameNew( HumanoidRootPart.Position );
						const Yaw = ( Spinbot and CurrentOrientation ) or 0;

						HumanoidRootPart.CFrame = ( CoordinateFrame * CFrameFromEulerAnglesYXZ( 0, Yaw, 0 ) );
					end
				end
			end

			-- Anchor
			do
				const HumanoidRootPart = CollisionObject : FindFirstChild( "HumanoidRootPart" );
				
				if ( HumanoidRootPart ) then
					const Enabled = KeybindFlags[ "Misc / Player / Anchor / Enabled" ];

					if ( Enabled ) and ( not HumanoidRootPart.Anchored ) then
						HumanoidRootPart.Anchored = true;
					end

					if ( not Enabled ) and ( HumanoidRootPart.Anchored ) then
						HumanoidRootPart.Anchored = false;
					end
				end
			end
		end
	end )( );
end

-- Interface
do
	LPH_NO_VIRTUALIZE( function( )
		Interface = Library.new( {
			[ "size" ] = Vector2New( 438, 505 ),

			[ "name" ] = "Homohack | Operation One ( @dementia_enjoyr )",

			[ "subFolder" ] = "Operation-One",
			[ "folder" ] = "Homohack",
			
			[ "theme" ] = {
				[ "tabButton" ] = ColorSequence.new( Color3.fromRGB( 22, 22, 22 ), Color3.fromRGB( 13, 13, 13 ) ),

				[ "playerPreviewBackground" ] = Color3.fromRGB( 15, 15, 15 ),
				[ "dropdownIndicator" ] = Color3.fromRGB( 38, 38, 38 ),
				[ "activeTabButton" ] = Color3.fromRGB( 12, 12, 12 ),

				[ "background" ] = Color3.fromRGB( 13, 13, 13 ),
				[ "component" ] = Color3.fromRGB( 13, 13, 13 ),
				[ "accent" ] = Color3.fromRGB( 182, 142, 235 ),
				[ "darkText" ] = Color3.fromRGB( 85, 85, 85 ),
				
				[ "text" ] = Color3.fromRGB( 204, 204, 204 ),
				[ "icon" ] = Color3.fromRGB( 204, 204, 204 ),
				[ "section" ] = Color3.fromRGB( 19, 19, 19 ),
				
				[ "stroke1" ] = Color3.fromRGB( 29, 29, 29 ),
				[ "stroke0" ] = Color3.fromRGB( 0, 0, 0 ),
			},
		} );

		const CombatTab = Interface : tab( "Combat" ); do
			const RagebotGroup = CombatTab : section( {
				[ "name" ] = "Ragebot",
				[ "side" ] = LEFT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / Enabled",
					[ "name" ] = "Enabled",

					[ "default" ] = false,
				} ) : keybind( {
					[ "flag" ] = "Combat / Ragebot / Key",
					[ "name" ] = "Ragebot",

					[ "default" ] = Enum.KeyCode.X,

					[ "affectToggle" ] = false,
					[ "hold" ] = false,
				} );

				RagebotGroup : divider( );

				RagebotGroup : toggle( {
					[ "tooltip" ] = "Will also target people with spawn protection.",
					[ "flag" ] = "Combat / Ragebot / SpawnProtection",
					[ "name" ] = "Spawn Protection",

					[ "default" ] = false,
				} );

				RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / TripleTap",
					[ "name" ] = "Triple Tap",

					[ "tooltip" ] = "Shoots 3 times",

					[ "default" ] = false,
				} );

				RagebotGroup : divider( );

				RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / OriginScan / Enabled",
					[ "name" ] = "Origin Scan",
					[ "default" ] = true,
				} );

				RagebotGroup : slider( {
					[ "flag" ] = "Combat / Ragebot / OriginScan / Range",
					[ "name" ] = "Range",
					[ "default" ] = 11,
					[ "min" ] = 1,
					[ "max" ] = 10,
				} );

				RagebotGroup : divider( );

				RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / AutoWall",
					[ "name" ] = "Auto Wall",
					[ "default" ] = false,
				} );

				RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / Effects",
					[ "name" ] = "Effects",
					[ "default" ] = true,
				} );

				RagebotGroup : divider( );

				const TracerToggle = RagebotGroup : toggle( {
					[ "flag" ] = "Combat / Ragebot / BulletTracers / Enabled",
					[ "name" ] = "Tracers",

					[ "default" ] = false,
				} ); do
					TracerToggle : colorpicker( {
						[ "flag" ] = "Combat / Ragebot / BulletTracers / Color1",
						[ "name" ] = "Color 1",

						[ "color" ] = White,
						[ "transparency" ] = nil,
						
						[ "drawingTransparency" ] = false,
					} );

					TracerToggle : colorpicker( {
						[ "flag" ] = "Combat / Ragebot / BulletTracers / Color2",
						[ "name" ] = "Color 2",

						[ "color" ] = White,

						[ "drawingTransparency" ] = false,
						[ "transparency" ] = nil,
					} );
				end

				RagebotGroup : slider( {
					[ "flag" ] = "Combat / Ragebot / BulletTracers / Lifetime",
					[ "name" ] = "Lifetime",
					[ "default" ] = 1,
					[ "min" ] = 1,
					[ "max" ] = 10,
				} );

				RagebotGroup : slider( {
					[ "flag" ] = "Combat / Ragebot / BulletTracers / Width",
					[ "name" ] = "Width",

					[ "default" ] = .1,
					[ "step" ] = .1,
					
					[ "min" ] = .1,
					[ "max" ] = 10,
				} );
			end

			const AimbotGroup = CombatTab : section( {
				[ "name" ] = "Aim Assistance",
				[ "side" ] = RIGHT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				const AimToggle = AimbotGroup : toggle( {
					[ "flag" ] = "Combat / Aimbot / Enabled",
					[ "name" ] = "Enabled",

					[ "default" ] = false,
				} );

				AimToggle : keybind( {
					[ "default" ] = Enum.UserInputType.MouseButton2,

					[ "flag" ] = "Combat / Aimbot / Key",
					[ "name" ] = "Aim Assistance",
					
					[ "affectToggle" ] = false,
					[ "hold" ] = true,
				} );

				AimbotGroup : divider( );

				const RangeToggle = AimbotGroup : toggle( {
					[ "flag" ] = "Combat / Aimbot / Range / Enabled",
					[ "name" ] = "Visualize Range",
					[ "default" ] = false,
				} );

				RangeToggle : colorpicker( {
					[ "name" ] = "Color",
					[ "flag" ] = "Combat / Aimbot / Range / Color",
					[ "color" ] = White,
					[ "transparency" ] = nil,
					[ "drawingTransparency" ] = false,
				} );

				AimbotGroup : slider( {
					[ "flag" ] = "Combat / Aimbot / Range / Value",
					[ "name" ] = "Value",
					[ "default" ] = 0,
					[ "min" ] = 0,
					[ "max" ] = 500,
				} );

				AimbotGroup : slider( {
					[ "flag" ] = "Combat / Aimbot / Smoothness",
					[ "name" ] = "Smoothness",
					[ "default" ] = 0,
					[ "min" ] = 0,
					[ "max" ] = 10,
				} );

				AimbotGroup : divider( );

				AimbotGroup : dropdown( {
					[ "flag" ] = "Combat / Aimbot / HitPart",
					[ "name" ] = "Hit Part",
					[ "options" ] = { "torso", "head" },
					[ "default" ] = "head",
				} );
			end

			const SilentGroup = CombatTab : section( {
				[ "name" ] = "Silent Aim",
				[ "side" ] = LEFT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				SilentGroup : toggle( {
					[ "flag" ] = "Combat / SilentAim / Enabled",
					[ "name" ] = "Enabled",
					[ "default" ] = false,
				} );
				
				SilentGroup : divider( );

				SilentGroup : toggle( {
					[ "flag" ] = "Combat / SilentAim / Range / Enabled",
					[ "name" ] = "Visualize Range",
					[ "default" ] = false,
				} ) : colorpicker( {
					[ "name" ] = "Color",

					[ "flag" ] = "Combat / SilentAim / Range / Color",
					[ "color" ] = White,

					[ "drawingTransparency" ] = false,
					[ "transparency" ] = nil,
				} );

				SilentGroup : slider( {
					[ "flag" ] = "Combat / SilentAim / Range / Value",
					[ "name" ] = "Value",
					[ "default" ] = 0,
					[ "min" ] = 0,
					[ "max" ] = 500,
				} );

				SilentGroup : divider( );

				SilentGroup : dropdown( {
					[ "flag" ] = "Combat / SilentAim / HitPart",
					[ "name" ] = "Hit Part",

					[ "options" ] = { "torso", "head" },
					[ "default" ] = "head",
				} );
			end

			const ModsGroup = CombatTab : section( {
				[ "name" ] = "Mods",
				[ "side" ] = RIGHT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				ModsGroup : toggle( {
					[ "flag" ] = "Combat / Mods / FireRate / Enabled",
					[ "name" ] = "Firerate Modifier",

					[ "default" ] = false,
				} );

				ModsGroup : slider( {
					[ "flag" ] = "Combat / Mods / FireRate / Multiplier",
					[ "name" ] = "Multiplier",
					
					[ "default" ] = 1,
					[ "step" ] = .1,

					[ "max" ] = 10,
					[ "min" ] = 1,
				} );

				ModsGroup : divider( );

				ModsGroup : toggle( {
					[ "flag" ] = "Combat / Mods / NoMuzzleFlash",
					[ "name" ] = "No Muzzle Flash",
					
					[ "default" ] = false,
				} );

				ModsGroup : toggle( {
					[ "flag" ] = "Combat / Mods / NoRecoil",
					[ "name" ] = "No Recoil",

					[ "default" ] = false,
				} );

				ModsGroup : toggle( {
					[ "flag" ] = "Combat / Mods / NoSpread",
					[ "name" ] = "No Spread",

					[ "default" ] = false,
				} );
			end
		end

		const VisualsTab = Interface : tab( "Visuals" ); do
			const function SetProperty( Object, Property, Enabled, Value )
				const PreviousValue = Storage : Get( `{ Object.Name } / { Property }` );

				if ( Enabled ) then
					if ( not PreviousValue ) then
						Storage : Add( `{ Object.Name } / { Property }`, Object[ Property ] );
					end Object[ Property ] = Value;
				end

				if ( not Enabled ) and PreviousValue then
					Object[ Property ] = PreviousValue; Storage : Add( `{ Object.Name } / { Property }`, nil );
				end
			end

			const PlayerGroup = VisualsTab : section( {
				[ "name" ] = "Players",

				[ "side" ] = LEFT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				PlayerGroup : toggle( {
					[ "flag" ] = "Visuals / Players / Enabled",
					[ "name" ] = "Enabled",

					[ "default" ] = false,
				} );

				PlayerGroup : divider( );

				PlayerGroup : toggle( {
					[ "flag" ] = "Visuals / Players / HealthBar / Enabled",
					[ "name" ] = "Healthbar",
					[ "default" ] = false,
				} ) : colorpicker( {
					[ "flag" ] = "Visuals / Players / HealthBar / Color",
					[ "name" ] = "Color",

					[ "drawingTransparency" ] = false,
					[ "transparency" ] = nil,

					[ "color" ] = White,
				} );

				PlayerGroup : toggle( {
					[ "flag" ] = "Visuals / Players / Country / Enabled",
					[ "name" ] = "Country",

					[ "default" ] = false,
				} ) : colorpicker( {
					[ "flag" ] = "Visuals / Players / Country / Color",
					[ "name" ] = "Color",

					[ "transparency" ] = nil,
					[ "color" ] = White,

					[ "drawingTransparency" ] = false,
				} );

				PlayerGroup : toggle( {
					[ "flag" ] = "Visuals / Players / Name / Enabled",
					[ "name" ] = "Name",
					[ "default" ] = false,
				} ) : colorpicker( {
					[ "flag" ] = "Visuals / Players / Name / Color",
					[ "name" ] = "Color",

					[ "color" ] = White,

					[ "drawingTransparency" ] = false,
					[ "transparency" ] = nil,
				} );

				const BoxToggle = PlayerGroup : toggle( {
					[ "flag" ] = "Visuals / Players / Box / Enabled",
					[ "name" ] = "Box",

					[ "default" ] = false,
				} );
				BoxToggle : colorpicker( {
					[ "flag" ] = "Visuals / Players / Box / Color",
					[ "name" ] = "Color",
					
					[ "color" ] = White,

					[ "drawingTransparency" ] = false,
					[ "transparency" ] = nil,
				} );
			end

			const WorldGroup = VisualsTab : section( {
				[ "name" ] = "World",

				[ "side" ] = RIGHT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				const AmbientToggle = WorldGroup : toggle( {
					[ "flag" ] = "Visuals / World / Ambient / Enabled",
					[ "name" ] = "Ambient Modifier",

					[ "default" ] = false,
				} ); do
					const OutdoorColor = AmbientToggle : colorpicker( {
						[ "flag" ] = "Visuals / World / Ambient / OutdoorAmbient",
						[ "name" ] = "Outdoor Ambient",

						[ "drawingTransparency" ] = false,
						[ "transparency" ] = nil,
						[ "color" ] = White,
					} );

					const AmbientColor = AmbientToggle : colorpicker( {
						[ "flag" ] = "Visuals / World / Ambient / Color",
						[ "name" ] = "Ambient",

						[ "drawingTransparency" ] = false,
						[ "transparency" ] = nil,
						[ "color" ] = White,
					} );

					for _, Element in { AmbientColor, OutdoorColor, AmbientToggle } do
						Element.onChanged : Connect( function( )
							SetProperty( Lighting, "OutdoorAmbient", AmbientToggle.value, OutdoorColor.color );
							SetProperty( Lighting, "Ambient", AmbientToggle.value, AmbientColor.color );
						end )
					end
				end

				WorldGroup : divider( );

				const TracerToggle = WorldGroup : toggle( {
					[ "flag" ] = "Visuals / World / BulletTracers / Enabled",
					[ "name" ] = "Tracers",
					[ "default" ] = false,
				} ); do
					TracerToggle : colorpicker( {
						[ "name" ] = "Hit Color",
						[ "flag" ] = "Visuals / World / BulletTracers / ColorHit",
						[ "color" ] = Red,
						[ "transparency" ] = nil,
						[ "drawingTransparency" ] = false,
					} );

					TracerToggle : colorpicker( {
						[ "name" ] = "Color 1",
						[ "flag" ] = "Visuals / World / BulletTracers / Color1",
						[ "color" ] = White,
						[ "transparency" ] = nil,
						[ "drawingTransparency" ] = false,
					} );

					TracerToggle : colorpicker( {
						[ "name" ] = "Color 2",
						[ "flag" ] = "Visuals / World / BulletTracers / Color2",
						[ "color" ] = White,
						[ "transparency" ] = nil,
						[ "drawingTransparency" ] = false,
					} );
				end

				WorldGroup : slider( {
					[ "flag" ] = "Visuals / World / BulletTracers / Lifetime",
					[ "name" ] = "Lifetime",
					[ "default" ] = 1,
					[ "min" ] = 1,
					[ "max" ] = 10,
				} );

				WorldGroup : slider( {
					[ "flag" ] = "Visuals / World / BulletTracers / Width",
					[ "name" ] = "Width",

					[ "default" ] = .1,
					[ "step" ] = .1,
					
					[ "max" ] = 10,
					[ "min" ] = .1,
				} );
			end

			const HitDetection = VisualsTab : section( {
				[ "name" ] = "Hit Detection",
				[ "side" ] = LEFT_SIDE,

				[ "autoSize" ] = true,
			} ); do
				HitDetection : toggle( {
					[ "flag" ] = "Visuals / HitDetection / HitSounds / Enabled",
					[ "name" ] = "Sounds",

					[ "default" ] = false,
				} );

				HitDetection : dropdown( {
					[ "flag" ] = "Visuals / HitDetection / HitSounds / Sound",
					[ "default" ] = "Neverlose",
					[ "name" ] = "Sound",

					[ "options" ] = ( function( )
						const Result = { };

						for Index, Value in Hitsounds do
							TableInsert( Result, Index );
						end

						return Result;
					end )( ),
				} );

				HitDetection : slider( {
					[ "flag" ] = "Visuals / HitDetection / HitSounds / Volume",
					[ "name" ] = "Volume",
						
					[ "default" ] = 1,

					[ "max" ] = 10,
					[ "min" ] = 1,
				} );

				HitDetection : divider( );

				HitDetection : toggle( {
					[ "flag" ] = "Visuals / HitDetection / HitNotifications / Enabled",
					[ "name" ] = "Notifications",

					[ "default" ] = false,
				} );

				HitDetection : textbox( {
					[ "flag" ] = "Visuals / HitDetection / HitNotifications / Text",
					[ "name" ] = "Text",
					
					[ "default" ] = "Hit { PLAYER } in the { HITPART }!",
					[ "placeholder" ] = "{ HITPART }, { PLAYER }",
				} );

				if ( HitMarkerAsset ) then
					HitDetection : divider( );

					const HitMarkersEnabled = HitDetection : toggle( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / Enabled",
						[ "name" ] = "Markers",

						[ "default" ] = false,
					} ); do
						HitMarkersEnabled : colorpicker( {
							[ "flag" ] = "Visuals / HitDetection / HitMarkers / HitColor1",
							[ "name" ] = "Hit Color 1",

							[ "transparency" ] = nil,
							[ "color" ] = Red,
							
							[ "drawingTransparency" ] = false,
						} );

						HitMarkersEnabled : colorpicker( {
							[ "flag" ] = "Visuals / HitDetection / HitMarkers / HitColor2",
							[ "name" ] = "Hit Color 2",

							[ "transparency" ] = nil,
							[ "color" ] = Black,
							
							[ "drawingTransparency" ] = false,
						} );

						HitMarkersEnabled : colorpicker( {
							[ "flag" ] = "Visuals / HitDetection / HitMarkers / Color1",
							[ "name" ] = "Color 1",

							[ "transparency" ] = nil,
							[ "color" ] = White,
							
							[ "drawingTransparency" ] = false,
						} );

						HitMarkersEnabled : colorpicker( {
							[ "flag" ] = "Visuals / HitDetection / HitMarkers / Color2",
							[ "name" ] = "Color 2",

							[ "transparency" ] = nil,
							[ "color" ] = White,
							
							[ "drawingTransparency" ] = false,
						} );
					end

					HitDetection : toggle( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / PlayerOnly",
						[ "name" ] = "Player Only",

						[ "default" ] = true,
					} );

					HitDetection : divider( );

					HitDetection : toggle( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / Rotation / Enabled",
						[ "name" ] = "Rotate",

						[ "default" ] = true,
					} );

					HitDetection : slider( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / Rotation / Speed",
						[ "name" ] = "Speed",
						
						[ "default" ] = 1,

						[ "max" ] = 10,
						[ "min" ] = 1,
					} );

					HitDetection : divider( );

					HitDetection : slider( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / Lifetime",
						[ "name" ] = "Lifetime",
						
						[ "default" ] = 1,

						[ "max" ] = 10,
						[ "min" ] = 1,
					} );

					HitDetection : slider( {
						[ "flag" ] = "Visuals / HitDetection / HitMarkers / Size",
						[ "name" ] = "Size",
						
						[ "default" ] = 30,

						[ "max" ] = 100,
						[ "min" ] = 1,
					} );
				end
			end
		end

		const MiscTab = Interface : tab( "Misc" ); do
			const ExploitGroup = MiscTab : section( {
				[ "name" ] = "Exploits",
				[ "side" ] = RIGHT_SIDE,

				[ "autoSize" ] = true,
			} ); do
				ExploitGroup : toggle( {
					[ "flag" ] = "Misc / Exploits / PingSpoof / Enabled",
					[ "name" ] = "Ping Spoof",
					[ "default" ] = false,
				} );

				ExploitGroup : slider( {
					[ "flag" ] = "Misc / Exploits / PingSpoof / Value",
					[ "name" ] = "Value",
					
					[ "default" ] = 0,

					[ "max" ] = 1000,
					[ "min" ] = 0,
				} );
			end

			const PlayerGroup = MiscTab : section( {
				[ "name" ] = "Player",
				[ "side" ] = LEFT_SIDE,
				
				[ "autoSize" ] = true,
			} ); do
				PlayerGroup : toggle( {
					[ "flag" ] = "Misc / Player / Anchor / Enabled",
					[ "name" ] = "Anchor",
					[ "default" ] = false,
				} ) : keybind( {
					[ "flag" ] = "Misc / Player / Anchor / Key",
					[ "name" ] = "Anchor",

					[ "default" ] = Enum.KeyCode.V,
					[ "affectToggle" ] = false,
					[ "hold" ] = false,
				} );

				PlayerGroup : divider( );

				PlayerGroup : toggle( {
					[ "flag" ] = "Misc / Player / WalkSpeed / Enabled",
					[ "name" ] = "Walk Speed",
					[ "default" ] = false,
				} ) : keybind( {
					[ "flag" ] = "Misc / Player / WalkSpeed / Key",
					[ "name" ] = "Walk Speed",

					[ "default" ] = Enum.KeyCode.Z,

					[ "affectToggle" ] = false,
					[ "hold" ] = false,
				} );

				PlayerGroup : slider( {
					[ "flag" ] = "Misc / Player / WalkSpeed / Multiplier",
					[ "name" ] = "Multiplier",

					[ "default" ] = 1,
					[ "step" ] = .1;
					
					[ "min" ] = 1,
					[ "max" ] = 10,
				} );

				PlayerGroup : divider( );

				PlayerGroup : toggle( {
					[ "flag" ] = "Misc / Player / AntiAim / Enabled",
					[ "name" ] = "Anti Aim",
					[ "default" ] = false,
				} );

				PlayerGroup : toggle( {
					[ "flag" ] = "Misc / Player / AntiAim / Spinbot",
					[ "name" ] = "Spinbot",
					[ "default" ] = false,
				} );

				PlayerGroup : slider( {
					[ "flag" ] = "Misc / Player / AntiAim / Speed",
					[ "name" ] = "Speed",
					
					[ "default" ] = 1,

					[ "min" ] = 1,
					[ "max" ] = 100,
				} );

				PlayerGroup : dropdown( {
					[ "flag" ] = "Misc / Player / AntiAim / Method",
					[ "name" ] = "Method",

					[ "options" ] = { "Shift", "Down", "Up" },
					[ "default" ] = "Down",
				} );
			end
		end

		const SettingsTab = Interface : tab( "Settings" ); do
			const ConfigsAssets = Interface.configs;
			const Config = SettingsTab : section( {
				[ "name" ] = "Config",

				[ "side" ] = LEFT_SIDE,
				[ "autoSize" ] = true,
			} ); do
				const List = Config : list( {
					[ "flag" ] = "Config / List",
					[ "size" ] = 150,
				} );

				const ConfigNameTextbox = Config : textbox( {
					[ "default" ] = "awesome config",

					[ "name" ] = "Configuration  Name",
					[ "flag" ] = "Config / Name",
				} );

				const Reload = Config : button( "Reload" );

				const Save = Config : button( "Save" );
				const Load = Config : button( "Load" );

				const function UpdateList( )
					const Files, Result = ConfigsAssets : listFiles( ), { };

					for _, File in Files do
						const ConfigName = string.match( File, "([^/\\]+)$" );

						if ( not ConfigsAssets : isFile( ConfigName ) ) then
							continue;
						end

						TableInsert( Result, ConfigName );
					end

					List : updateList( Result );
				end UpdateList( );

				const KeybindList = Interface.keybindList; do
					Config : divider( ); Config : label( "Keybind" ) : keybind( {
						[ "default" ] = Enum.KeyCode.Delete,
						[ "flag" ] = "Config / Keybind",
						[ "ignoreKeybindList" ] = true,
					} ).onChanged : Connect( function( )
						Interface : setVisible( not Interface.visible );
					end)

					Config : toggle( {
						[ "flag" ] = "Config / KeybindList",
						[ "name" ] = "Keybind List",

						[ "default" ] = true
					} ).onChanged : Connect( function( State )
						KeybindList : setVisible( State )
					end ) KeybindList : setVisible( true );
				end

				List.onChanged : Connect( function( NewOption )
					ConfigNameTextbox : set( NewOption );
				end )

				Save.onPressed : Connect( function( )
					const ConfigName = Flags[ "Config / Name" ];

					if ( not ConfigName ) or ( StringLen( ConfigName ) < 1 ) then
						return;
					end

					ConfigsAssets : writeFile( ConfigName, HttpService : JSONEncode(  Interface : getConfig( ) ) ); UpdateList( );
				end )

				Load.onPressed : Connect( function( )
					const ConfigName = Flags[ "Config / Name" ];

					if ( not ConfigsAssets : isFile( ConfigName ) ) then
						return;
					end

					Interface : loadConfig( HttpService : JSONDecode( ConfigsAssets : readFile( ConfigName ) ) );
				end )

				Reload.onPressed : Connect( UpdateList );
			end
		end

		KeybindFlags = SetMetatable( { }, {
			__index = function( Self, Index )
				return Flags[ Index ] and Flags[ StringGSub( Index, "/ Enabled", "/ Key" ) ];
			end
		} );

		Flags = SetMetatable( { }, {
			__index = function( Self, Index )
				return Interface.flags[ Index ];
			end
		} );
	end )( );
end

-- Main
do
	-- Connections
	do
		DrawingImmediate.GetPaint( 1 ) : Connect( LPH_NO_VIRTUALIZE( function( )
			Visuals : Stepper( );
		end ) )

		RunService.PreRender : Connect( LPH_NO_VIRTUALIZE( function( )
			Setters : Stepper( );

			Legitbot : Stepper( );
			Ragebot : Stepper( );

			Misc : Stepper( );

			WorldRenderer : Stepper( );
			Scanning : Stepper( );
		end ) )
	end

	-- Hooks
	do
		-- Meta Methods
		do
			local __NameCall, __AngleCounter = nil, 0; __NameCall = HookMetaMethod( Game, "__namecall", LPH_NO_VIRTUALIZE( function( Self, ... )
				const Method, Arguments = GetNameCallMethod( ), { ... };
				const Caller = DebugInfo( 3, "n" );

				-- Features
				do
					const PingSpoof = Flags[ "Misc / Exploits / PingSpoof / Enabled" ];
					const SpoofValue = Flags[ "Misc / Exploits / PingSpoof / Value" ];
					
					if ( Method == "GetNetworkPing" ) and ( PingSpoof ) then
						return SpoofValue;
					end

					if ( Method == "FindFirstChild" ) then
						const RemoveAnimationProceed = Storage : Get( "Ragebot / REM_ANIM_PROCEED" );
						const String = Select( 1, ... );

						if ( String == "Flash" and ( RemoveAnimationProceed or Flags[ "Combat / Mods / NoMuzzleFlash" ] ) ) then
							return;
						end

						if ( RemoveAnimationProceed ) and ( String == "Smoke" or String == "BulletEject" ) then
							return;
						end
					end

					if ( Method == "FireServer" ) then
						const NetEvent = Arguments[ 1 ];

						if ( NetEvent == "shoot" ) then
							const HitNotifications = Flags[ "Visuals / HitDetection / HitNotifications / Enabled" ];
								const HitText = Flags[ "Visuals / HitDetection / HitNotifications / Text" ];

							const HitSounds = Flags[ "Visuals / HitDetection / HitSounds / Enabled" ];
								const HitVolume = Flags[ "Visuals / HitDetection / HitSounds / Volume" ];
								const HitSound = Flags[ "Visuals / HitDetection / HitSounds / Sound" ];

							const HitMarkers = Flags[ "Visuals / HitDetection / HitMarkers / Enabled" ];
								const HitMarkerRotationEnabled = Flags[ "Visuals / HitDetection / HitMarkers / Rotation / Enabled" ];
								const HitMarkerRotationSpeed = Flags[ "Visuals / HitDetection / HitMarkers / Rotation / Speed" ];

								const HitMarkerPlayerOnly = Flags[ "Visuals / HitDetection / HitMarkers / PlayerOnly" ];
								const HitMarkerLifetime = Flags[ "Visuals / HitDetection / HitMarkers / Lifetime" ];

								const HitMarkerColorHit = Flags[ "Visuals / HitDetection / HitMarkers / ColorHit" ];

								const HitMarkerHitColor1 = Flags[ "Visuals / HitDetection / HitMarkers / HitColor1" ];
								const HitMarkerHitColor2 = Flags[ "Visuals / HitDetection / HitMarkers / HitColor2" ];
								
								local HitMarkerColor1 = Flags[ "Visuals / HitDetection / HitMarkers / Color1" ];
								local HitMarkerColor2 = Flags[ "Visuals / HitDetection / HitMarkers / Color2" ];

								const HitMarkerSize = Flags[ "Visuals / HitDetection / HitMarkers / Size" ];

							const BulletTracers = Flags[ "Visuals / World / BulletTracers / Enabled" ];
								const TracerColorHit = Flags[ "Visuals / World / BulletTracers / ColorHit" ];
								const TracerLifeTime = Flags[ "Visuals / World / BulletTracers / Lifetime" ];
								const TracerWidth = Flags[ "Visuals / World / BulletTracers / Width" ];

								local TracerColor1 = Flags[ "Visuals / World / BulletTracers / Color1" ];
								local TracerColor2 = Flags[ "Visuals / World / BulletTracers / Color2" ];

							const CoordinateFrame = Arguments[ 2 ];

							for _, Pellet in ( Arguments[ 3 ] or { } )[ 1 ] or { } do
								const HitHumanoid = Pellet.HitHum;

								const Position = Pellet.Position;
								const HitPart = Pellet.Instance;

								if ( not Position ) or ( not HitPart ) then
									continue;
								end

								if ( HitMarkers and ( not HitMarkerPlayerOnly or HitHumanoid ) ) then
									if ( HitHumanoid ) then
										HitMarkerColor1 = HitMarkerHitColor1;
										HitMarkerColor2 = HitMarkerHitColor2;
									end

									const ThreadIdentity = GetThreadIdentity( );
									SetThreadIdentity( 8 );
										World.HitMarker( World, 0, Position, HitMarkerLifetime, HitMarkerSize, HitMarkerColor1, HitMarkerColor2, {
											[ "Rotation / Speed" ] = HitMarkerRotationSpeed * .1,
											[ "Rotation / Enabled" ] = HitMarkerRotationEnabled,
										} );
									SetThreadIdentity( ThreadIdentity );
								end

								if ( HitNotifications and HitHumanoid ) then
									const ViewModel = HitPart.FindFirstAncestorWhichIsA( HitPart, "Model" );
									
									if ( not ViewModel ) then
										continue;
									end

									const Name = ( function( )
										for _, Object in Replicators.Everyone do
											if ( Object : Character( ) ~= ViewModel ) then
												continue;
											end

											return Object : Name( );
										end
									end )( );

									if ( not Name ) then
										continue;
									end

									const ThreadIdentity = GetThreadIdentity( );
									SetThreadIdentity( 8 );
										Interface : notify( StringGSub( StringGSub( HitText, "{ PLAYER }", Name ), "{ HITPART }", ToString( HitPart ) ), 3 );
									SetThreadIdentity( ThreadIdentity );
								end

								if ( HitSounds and HitHumanoid ) then
									const ThreadIdentity = GetThreadIdentity( );
									SetThreadIdentity( 8 );
										Utilities.PlaySound( Utilities, Hitsounds[ HitSound ], HitVolume, 1 );
									SetThreadIdentity( ThreadIdentity );
								end

								if ( BulletTracers ) then
									if ( HitHumanoid ) then
										TracerColor1 = TracerColorHit;
										TracerColor2 = TracerColorHit;
									end
									
									const ThreadIdentity = GetThreadIdentity( );
									SetThreadIdentity( 8 );
										World.BulletTracer( World, CoordinateFrame.Position, Position, TracerColor1, TracerColor2, TracerLifeTime, 0, TracerWidth );
									SetThreadIdentity( ThreadIdentity );
								end
								
								break;
							end
						end

						if ( NetEvent == "look" ) then
							const Original = Arguments[ 2 ];

							local Pitch = Original.Y; do
								const AntiAim = Flags[ "Misc / Player / AntiAim / Enabled" ];

								if ( AntiAim ) then
									const Method = Flags[ "Misc / Player / AntiAim / Method" ];

									local Angle = 99;
									__AngleCounter += 1;

									if ( Method == "Shift" ) then
										Angle = ( ( __AngleCounter % 3 == 0 ) and -Angle ) or Angle;
									elseif ( Method == "Down" ) then
										Angle = -Angle;
									end

									Pitch = Angle;
								end
							end

							Arguments[ 2 ] = Vector3New( Original.X, Pitch, Original.Z );
						end
					end
				end

				-- Getters
				do
					if ( Method == "PivotTo" ) then -- SAINT GEORGE SSAVE ME
						const Stack = DebugGetStack( 3 );

						const Name = ToString( Self );
						const Object = Stack[ 1 ];
						
						if ( Caller == "render_body" and Name == "torso" ) then
							const CollisionModel = Object.instance;

							if ( CollisionModel ) then
								const DataEntries = Replicators.DataEntries;

								local CharacterName = ToString( CollisionModel );
								const PreviousDataEntry = DataEntries[ CharacterName ];

								if ( not PreviousDataEntry ) or ( Object ~= PreviousDataEntry.StateObject ) then
									const UserId = CollisionModel.GetAttribute( CollisionModel, "UserId" );
									const CharacterModel = Object.values.viewmodels;

									const IsZombie = UserId < 0; if ( IsZombie ) then
										CharacterName = `{ CharacterName } { UserId }`;
									end
									
									DataEntries[ CharacterName ] = {
										[ "Model" ] = CharacterModel,

										[ "Name" ] = CharacterName,
										[ "StateObject" ] = Object,

										[ "Zombie" ] = IsZombie,
										[ "Tick" ] = GameTick
									};
								end
							end
						end

						if ( Caller == "render" ) and ( Name == "Root" ) then
							const Owner = Object.owner;
						
							if ( ToString( Owner.instance ) == LocalName ) then
								Controller.WeaponObject = Object;
							end
						end
					end
				end

				return __NameCall( Self, TableUnpack( Arguments ) );
			end ) )

			local __Index = nil; __Index = HookMetaMethod( Game, "__index", LPH_NO_VIRTUALIZE( function( Self, Index )
				const Level = 3;

				if ( Index == "Value" ) and ( DebugInfo( Level, "n" ) == "get_shoot_look" ) then
					const HitPart = Scanning.SilentTarget;

					for Stack, Value in ( HitPart and DebugGetStack( Level ) ) or { } do
						if ( TypeOf( Value ) ~= "CFrame" ) then
							continue;
						end

						DebugSetStack( Level, Stack, CFrameLookAt( Value.Position, __Index( HitPart, "Position" ) ) );
					end
				end
				
				return __Index( Self, Index );
			end ) )
		end

		-- Functions
		do
			local __MathRandom = nil; __MathRandom = HookFunction( Environment.math.random, LPH_NO_VIRTUALIZE( function( ... )
				const Name = DebugInfo( 3, "n" );

				const Minimum = Select( 1, ... );
				const Maximum = Select( 2, ... );

				if ( not Minimum ) and ( not Maximum ) then
					const NoSpread = Flags[ "Combat / Mods / NoSpread" ];

					if ( Name == "get_circular_spread" and NoSpread ) then
						return 0;
					end
				end

				return __MathRandom( ... );
			end ) )

			local __CFrameNew = nil; __CFrameNew = HookFunction( Environment.CFrame.new, LPH_NO_VIRTUALIZE( function( ... )
				if ( Select( "#", ... ) == 0 and DebugInfo( 3, "n" ) == "recoil_function" ) and ( Storage : Get( "Ragebot / REM_ANIM_PROCEED" ) or Flags[ "Combat / Mods / NoRecoil" ] ) then
					const Stack = DebugGetStack( 3 );
					const Length = #Stack;

					for Index, Value in Stack do
						if ( TypeOf( Value ) ~= "number" ) then
							continue;
						end

						DebugSetStack( 3, Index, 0 );
					end
				end

				return __CFrameNew( ... );
			end ) )

			local __TaskSpawn = nil; __TaskSpawn = HookFunction( Environment.task.spawn, LPH_NO_VIRTUALIZE( function( ... )
				if ( DebugInfo( 3, "n" ) == "shoot" ) and Storage : Get( "Ragebot / REM_ANIM_PROCEED" )  then
					return;
				end

				return __TaskSpawn( ... );
			end ) )

			local __OSClock = nil; __OSClock = hookfunction( Environment.os.clock, LPH_NO_VIRTUALIZE( function( ... )
				local Result = __OSClock( ... );

				if ( DebugInfo( 3, "n" ) == "input_render" ) then
					Result *= Storage : Get( "Mods / FIRE_RATE_MULTI" );
				end
				
				return Result;
			end ) )
		end
	end
end
