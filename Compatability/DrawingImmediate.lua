local BetterDrawing = game : HttpGet( "https://raw.githubusercontent.com/dementiaenjoyer/Better-Drawing/refs/heads/main/Main.lua" ); do
    getgenv( ).hookfunction = ( hookfunction or 1 )
    getgenv( ).IGNORE_HOOK = true;

    BetterDrawing = loadstring( BetterDrawing )( );
end

local TableInsert = table.insert;
local TableClear = table.clear;

local Result = { }; do
	local RenderQueue = { };

	function Result : GetPaint( ZIndex )
		return { [ "Connect" ] = function( Self, Callback )
			BetterDrawing : Init( function( )
				for _, RenderData in RenderQueue do
					local ClassName = RenderData.Class;

					if ( not ClassName ) then
						continue;
					end

					local DrawingObject = Drawing.new( ClassName );
					DrawingObject.Visible = true;

					for Property, Value in RenderData do
						DrawingObject[ Property ] = Value;
					end
				end TableClear( RenderQueue );

				Callback( );
			end );
		end };
	end

	-- Draw Functions (TODO: Clean this up, all of these functions rnt needed..)
	do
		function Result.OutlinedText( Position, Font, FontSize, Color, Opacity, Text, Center )
			TableInsert( RenderQueue, {
				[ "Class" ] = "OutlinedText",

				[ "Transparency" ] = Opacity,
				[ "FontSize" ] = FontSize,

				[ "Center" ] = Center,
				[ "Font" ] = Font,

				[ "Position" ] = Position,

				[ "Color" ] = Color,
				[ "Text" ] = Text,
			} );
		end

		function Result.Quad( PointA, PointB, PointC, PointD, Color, Opacity, Thickness )
			TableInsert( RenderQueue, {
				[ "Class" ] = "Quad",

				[ "Transparency" ] = Opacity,
				[ "Thickness" ] = Thickness,

				[ "PointA" ] = PointA,
				[ "PointB" ] = PointB,

				[ "PointC" ] = PointC,
				[ "PointD" ] = PointD,

				[ "Color" ] = Color,
			} );
		end

		function Result.Rectangle( Position, Size, Color, Opacity, Rounding, Thickness )
			TableInsert( RenderQueue, {
				[ "Class" ] = "Rectangle",

				[ "Transparency" ] = Opacity,
				[ "Thickness" ] = Thickness,
				[ "Rounding" ] = Rounding,

				[ "Position" ] = Position,
				[ "Size" ] = Size,

				[ "Color" ] = Color,
			} );
		end

		function Result.Circle( Position, Radius, Color, Opacity, NumSides, Thickness )
			TableInsert( RenderQueue, {
				[ "Transparency" ] = Opacity,
				[ "Thickness" ] = Thickness,

				[ "NumSides" ] = NumSides,
				[ "Position" ] = Position,

				[ "Class" ] = "Circle",

				[ "Radius" ] = Radius,
				[ "Color" ] = Color,
			} );
		end

		function Result.Text( Position, Font, FontSize, Color, Opacity, Text, Center )
			TableInsert( RenderQueue, {
				[ "Class" ] = "Text",

				[ "Transparency" ] = Opacity,
				[ "FontSize" ] = FontSize,

				[ "Center" ] = Center,
				[ "Font" ] = Font,

				[ "Position" ] = Position,

				[ "Color" ] = Color,
				[ "Text" ] = Text,
			} );
		end

		function Result.Triangle( PointA, PointB, PointC, Color, Opacity, Thickness )
			TableInsert( RenderQueue, {
				[ "Class" ] = "Triangle",

				[ "Transparency" ] = Opacity,
				[ "Thickness" ] = Thickness,

				[ "PointA" ] = PointA,
				[ "PointB" ] = PointB,
				[ "PointC" ] = PointC,

				[ "Color" ] = Color,
			} );
		end

		function Result.FilledQuad( PointA, PointB, PointC, PointD, Color, Opacity )
			TableInsert( RenderQueue, {
				[ "Class" ] = "FilledQuad",

				[ "Transparency" ] = Opacity,

				[ "PointA" ] = PointA,
				[ "PointB" ] = PointB,
				[ "PointC" ] = PointC,
				[ "PointD" ] = PointD,

				[ "Color" ] = Color,
			} );
		end

		function Result.FilledRectangle( TopLeft, Size, Color, Opacity, Rounding )
			TableInsert( RenderQueue, {
				[ "Class" ] = "FilledRectangle",

				[ "Transparency" ] = Opacity,
				[ "Rounding" ] = Rounding,

				[ "Position" ] = TopLeft,
				[ "Size" ] = Size,

				[ "Color" ] = Color,
			} );
		end

		function Result.FilledCircle( Position, Radius, Color, NumSides, Opacity )
			TableInsert( RenderQueue, {
				[ "Class" ] = "FilledCircle",
				[ "Transparency" ] = Opacity,

				[ "NumSides" ] = NumSides,
				[ "Position" ] = Position,

				[ "Radius" ] = Radius,

				[ "Color" ] = Color,
			} );
		end

		function Result.FilledTriangle( PointA, PointB, PointC, Color, Opacity )
			TableInsert( RenderQueue, {
				[ "Class" ] = "FilledTriangle",
				[ "Transparency" ] = Opacity,

				[ "PointA" ] = PointA,
				[ "PointB" ] = PointB,
				[ "PointC" ] = PointC,

				[ "Color" ] = Color,
			} );
		end

		function Result.Line( From, To, Color, Opacity, Thickness )
			TableInsert( RenderQueue, {
				[ "Transparency" ] = Opacity,
				[ "Thickness" ] = Thickness,

				[ "Class" ] = "Line",

				[ "Color" ] = Color,

				[ "From" ] = From,
				[ "To" ] = To,
			} );
		end
	end
end

return Result;
