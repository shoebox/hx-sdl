package sdl;

import cpp.Pointer;
import sdl.Rect;
import sdl.Surface;
import sdl.Video;

@:unreflective
@:headerCode("#import <SDL2/SDL_render.h>")
class Render
{
	public static function createRenderer(window:Pointer<Window>, 
		index:Int, flags:Int):Pointer<Renderer>
	{
		return SDL_Render.CreateRenderer(window, index, flags);
	}

	public static function createTexture(renderer:Pointer<Renderer>, 
		surface:Pointer<SDLSurface>):Pointer<Texture>
	{
		return SDL_Render.CreateTextureFromSurface(renderer, surface);
	}

	public static function renderClear(rendere:Pointer<Renderer>):Int
	{
		return SDL_Render.RenderClear(rendere);
	}

	public static function renderCopy(renderer:Pointer<Renderer>, 
		texture:Pointer<Texture>, ?source:Rect, ?dest:Rect):Int
	{
		var result = -1;
		untyped __cpp__("result = SDL_RenderCopy(renderer, texture, 
			&source->native, &dest->native)");
		return result;
	}

	public static function renderPresent(render:Pointer<Renderer>):Void
	{
		SDL_Render.RenderPresent(render);
	}
}

@:include("SDL2/SDL_render.h")
@:native("SDL2/SDL_render")
extern class SDL_Render implements SdlExtern
{
	static function CreateRenderer(window:Pointer<Window>, index:Int, flags:Int):Pointer<Renderer>;
	static function CreateTextureFromSurface(renderer:Pointer<Renderer>, surface:Pointer<SDLSurface>):Pointer<Texture>;
	static function RenderClear(renderer:Pointer<Renderer>):Int;
	static function RenderPresent(renderer:Pointer<Renderer>):Void;
}

@:native("SDL_Renderer") extern class Renderer{}
@:native("SDL_Texture") extern class Texture{}
