package sdl;

import cpp.Pointer;
import sdl.Render;

@:headerCode("#import <SDL2/SDL_render.h>")
class Texture
{
	public var native(default, null):Pointer<SDLTexture>;	

	public function new(native:Pointer<SDLTexture>)
	{
		this.native = native;
	}
}
@:native("SDL_Texture") extern class SDLTexture{}
