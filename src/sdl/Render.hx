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
		return SDLRender.CreateRenderer(window, index, flags);
	}

	public static function createTexture(renderer:Pointer<Renderer>, 
		surface:Pointer<SDLSurface>):Pointer<Texture>
	{
		return SDLRender.CreateTextureFromSurface(renderer, surface);
	}

	public static function renderClear(render:Pointer<Renderer>):Int
	{
		return SDLRender.RenderClear(render);
	}

	public static function renderCopy(render:Pointer<Renderer>, 
		texture:Pointer<Texture>, ?source:Rect, ?dest:Rect):Int
	{
		var result = -1;
		untyped __cpp__("result = SDL_RenderCopy(render, texture, 
			&source->native, &dest->native)");
		return result;
	}

	public static function renderPresent(render:Pointer<Renderer>):Void
	{
		SDLRender.RenderPresent(render);
	}
}

@:include("SDL2/SDL_render.h")
@:native("SDL2/SDL_render")
extern class SDLRender implements SdlExtern
{
	public static function CreateRenderer(window:Pointer<Window>, 
		index:Int, flags:Int):Pointer<Renderer>;
	public static function CreateTextureFromSurface(renderer:Pointer<Renderer>, 
		surface:Pointer<SDLSurface>):Pointer<Texture>;
	public static function RenderClear(renderer:Pointer<Renderer>):Int;
	public static function RenderPresent(renderer:Pointer<Renderer>):Void;
}

@:native("SDL_Renderer") extern class Renderer{}
@:native("SDL_Texture") extern class Texture{}
