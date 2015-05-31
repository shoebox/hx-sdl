package sdl;

import cpp.Pointer;
import cpp.NativeString;
import sdl.Rect;
import sdl.Surface;
import sdl.Texture;
import sdl.Video;

import cpp.NativeString;

@:unreflective
@:headerCode("
	#import <SDL2/SDL_render.h>
	#include<string>"
)
class Render
{
	public static inline var SOFTWARE = 0x00000001;         // < The renderer is a software fallback
    public static inline var ACCELERATED = 0x00000002;      // < The renderer uses hardware acceleration
    public static inline var PRESENTVSYNC = 0x00000004;     // < Present is synchronized with the refresh rate
    public static inline var TARGETTEXTURE = 0x00000008;     // < The renderer supports rendering to texture

   public var native(default, null):Pointer<SDLRenderer>;

	public function new(native:Pointer<SDLRenderer>)
	{
		this.native = native;
	}

	public static function createRenderer(window:Pointer<Window>, 
		index:Int, flags:Int):Render
	{
		var native = SDLRender.CreateRenderer(window, index, flags);
		var renderer = new Render(native);
		return renderer;
	}

	// Drivers -----------------------------------------------------------------

	public static function getNumRenderDrivers():Int
	{
		var result = SDLRender.GetNumRenderDrivers();
		return result;
	}

	public static function getRenderDriverInfo(index:Int):RenderDriverInfo
	{
		var result:RenderDriverInfo = null;
		var name:String = null;
		var pointer:Pointer<SDLRendererInfo> = null;
		var requestResult:Int = 0;
		untyped __cpp__("
			SDL_RendererInfo* infos = new SDL_RendererInfo();
			requestResult = SDL_GetRenderDriverInfo(index,infos);
			::String driverName = ::String(infos->name);
			name = driverName;
			pointer = ::cpp::Pointer<SDL_RendererInfo>(infos);
		");

		if (pointer != null)
		{
			result = 
			{
				name : name,
				flags : pointer.ref.flags,
				maxTextureWidth : pointer.ref.max_texture_width,
				maxTextureHeight : pointer.ref.max_texture_height,
				numTextureFormats : pointer.ref.num_texture_formats,
			}
			pointer.destroy();
		}
		
		return result;
	}

	// Texture -----------------------------------------------------------------

	public function createTexture(surface:Pointer<SDLSurface>):Texture
	{
		var native = SDLRender.CreateTextureFromSurface(native, surface);
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
		return SDLRender.RenderClear(native);
	}

	public function renderPresent():Void
	{
		SDLRender.RenderPresent(native);
	}
}

@:include("SDL2/SDL_render.h")
@:native("SDL2/SDL_render")
extern class SDLRender implements SdlExtern
{
	static function CreateRenderer(window:Pointer<Window>, index:Int, flags:Int):Pointer<SDLRenderer>;
	static function CreateTextureFromSurface(renderer:Pointer<SDLRenderer>, 
		surface:Pointer<SDLSurface>):Pointer<SDLTexture>;
	static function RenderClear(renderer:Pointer<SDLRenderer>):Int;
	static function RenderPresent(renderer:Pointer<SDLRenderer>):Void;
	static function GetNumRenderDrivers():Int;
	static function GetRenderDriverInfo(index:Int, info:SDLRendererInfo):Int;
}

@:native("SDL_Renderer") extern class SDLRenderer{}

@:structAccess
@:unreflective
@:native("SDL_RendererInfo") extern class SDLRendererInfo
{
	public var flags:Int;
	public var num_texture_formats:Int;
	public var texture_formats:Array<Int>;
	public var max_texture_width:Int;
	public var max_texture_height:Int;
}

typedef RenderDriverInfo=
{
	var name:String;
	var flags:Int;
	var maxTextureWidth:Int;
	var maxTextureHeight:Int;
	var numTextureFormats:Int;
	var formats:Array<Int>;
}
