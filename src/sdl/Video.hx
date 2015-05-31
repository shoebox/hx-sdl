package sdl;

import cpp.Pointer;

@:include("SDL2/SDL_video.h")
@:native("SDL2/SDL_video")
extern class Video
{
	@:native("SDL_CreateWindow")
    public static function createWindow(title:String, x:Int, y:Int, 
    	width:Int, height:Int, flags:Int):Pointer<Window>;
}

@:native("SDL_Window")
extern class Window
{
}
