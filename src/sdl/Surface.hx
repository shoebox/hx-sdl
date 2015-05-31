package sdl;

import cpp.Pointer;

@:include("SDL2/SDL_surface.h")
@:native("SDL2/SDL_surface")
extern class Surface
{
	@:native("SDL_LoadBMP")
	public static function loadBmp(file:String):Pointer<SDLSurface>;
}

@:native("SDL_Surface")
extern class SDLSurface
{

}
