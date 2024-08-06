SuperStrict

Framework sdl.sdlrendermax2d
Import Text.HBFreeTypeFont

Graphics 1024, 768, 0

Local font:TImageFont = LoadImageFont( "fonts/Vollkorn-Regular.otf", 72, SMOOTHFONT )
Local linfont:TImageFont = LoadImageFont( "fonts/Vollkorn-Regular.otf", 72, SMOOTHFONT | LININGFIGURESFONT )
Local scfont:TImageFont = LoadImageFont( "fonts/Vollkorn-Regular.otf", 72, SMOOTHFONT | SMALLCAPSFONT )
Local kfont:TImageFont = LoadImageFont( "fonts/Vollkorn-Regular.otf", 72, SMOOTHFONT | KERNFONT )
Local kscfont:TImageFont = LoadImageFont( "fonts/Vollkorn-Regular.otf", 72, SMOOTHFONT | KERNFONT | SMALLCAPSFONT | ZEROFONT | BOLDFONT )

While Not KeyDown( Key_Escape )

	Cls

	SetImageFont font

	DrawText "Hello World 0123456789", 100, 100

	SetImageFont linfont

	DrawText "Hello World 0123456789", 100, 180

	SetImageFont scfont

	DrawText "Hello World 0123456789", 100, 260

	SetImageFont kfont

	DrawText "Hello World 0123456789", 100, 340

	SetImageFont kscfont

	DrawText "Hello World 0123456789", 100, 420

	Flip

Wend

