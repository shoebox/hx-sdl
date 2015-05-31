package sdl;

import cpp.Pointer;
import sdl.Rect;
import sdl.Surface;
import sdl.Video;

@:unreflective
@:headerCode("#import <SDL2/SDL_render.h>")
class Render
{
	public static inline var SOFTWARE = 0x00000001;         // < The renderer is a software fallback
    public static inline var ACCELERATED = 0x00000002;      // < The renderer uses hardware acceleration
    public static inline var PRESENTVSYNC = 0x00000004;     // < Present is synchronized with the refresh rate
    public static inline var TARGETTEXTURE = 0x00000008;     // < The renderer supports rendering to texture

	public static function createRenderer(window:Pointer<Window>, 
		index:Int, flags:Int):Renderer
	{
		var native = SDL_Render.CreateRenderer(window, index, flags);
		var renderer = new Renderer(native);
		return renderer;
	}
}
class Renderer
{
	public var native(default, null):Pointer<SDLRenderer>;

	public function new(native:Pointer<SDLRenderer>)
	{
		this.native = native;
	}

	public function createTexture(surface:Pointer<SDLSurface>):Texture
	{
		var native = SDL_Render.CreateTextureFromSurface(native, surface);
		var texture = new Texture(native);
		return texture;
	}

	public function renderCopy(texture:Texture, ?source:Rect, ?dest:Rect):Int
	{
		var result = -1;
		untyped __cpp__("result = SDL_RenderCopy(native, texture->native, 
			&source->native, &dest->native)");
		return result;
	}

	public function renderClear():Int
	{
		return SDL_Render.RenderClear(native);
	}

	public function renderPresent():Void
	{
		SDL_Render.RenderPresent(native);
	}
}

@:headerCode("#import <SDL2/SDL_render.h>")
class Texture
{
	public var native(default, null):Pointer<SDLTexture>;	

	public function new(native:Pointer<SDLTexture>)
	{
		this.native = native;
	}
}

@:include("SDL2/SDL_render.h")
@:native("SDL2/SDL_render")
extern class SDL_Render implements SdlExtern
{
	static function CreateRenderer(window:Pointer<Window>, index:Int, flags:Int):Pointer<SDLRenderer>;
	static function CreateTextureFromSurface(renderer:Pointer<SDLRenderer>, 
		surface:Pointer<SDLSurface>):Pointer<SDLTexture>;
	static function RenderClear(renderer:Pointer<SDLRenderer>):Int;
	static function RenderPresent(renderer:Pointer<SDLRenderer>):Void;
}

@:native("SDL_Renderer") extern class SDLRenderer{}
@:native("SDL_Texture") extern class SDLTexture{}
