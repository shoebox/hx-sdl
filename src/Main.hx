import cpp.Pointer;
import sdl.Rect;
import sdl.MessageBox;
import sdl.Render;
import sdl.Surface;
import sdl.Video;
using cpp.NativeString;
import cpp.vm.Thread;
import sdl.Sdl;

@:buildXml('<include name="${haxelib:hsdl}/Build.xml"/>')
class Main
{
	@:native
	var prout:{};

	static function main()
	{
		run();
	}

	static function run()
	{
		// var quad1 = new Rect(0, 0, 0, 0);
		// var quad2 = new Rect(0, 0, 100, 100);
		// var quad3 = new Rect(50, 50, 100, 100);

		// trace(quad1);
		// trace(quad2);
		// trace(quad3);

		// trace(quad2.union(quad3));
		var flags = SdlInitFlag.VIDEO;
		var result = Sdl.init(0x00000020);
		var window = Video.createWindow("toto", 0, 0, 640, 480, 0x00000004);
		var ren = Render.createRenderer(window, -1, 0x00000002 | 0x00000004);
		var bmp = Surface.loadBmp("/Users/johann.martinache/Desktop/massive/storefront-companion/lib/nme-dev/project/unpack/SDL2-2.0.3/test/controllermap.bmp");
		var tex = Render.createTexture(ren, bmp);
		Render.renderClear(ren);
		
		var quad = new Rect(0, 0, 200, 200);
		var dest = new Rect(100, 100, 200, 200);
		var result = Render.renderCopy(ren, tex, quad, dest);

		Render.renderPresent(ren);

		MessageBox.simple(MessageBoxType.ERROR, "hello", "world", window);

		SDLTimer.delay(200);
	}
}

@:include("SDL2/SDL_timer.h")
@:native("SDL2/SDL_timer")
extern class SDLTimer
{
	@:native("SDL_Delay")
	public static function delay(delay:Int):Void;
}

@:include("SDL2/SDL_rwops.h")
@:native("SDL2/SDL_rwops")
extern class Rw
{
	@:native("SDL_RWFromFile")
	public static function fromFile(file:String, mode:String):Pointer<RWOps>;
}

// @:include("SDL2/SDL_messagebox.h")
// @:native("SDL2/SDL_messagebox")
// extern class MessageBox
// {
// 	@:native("SDL_ShowSimpleMessageBox")
//     public static function simple(flags:Int, title:String, message:String, 
//     	window:Pointer<Window>):Int;
// }



@:native("SDL_RWops")
extern class RWOps
{
}

// @:include("SDL2/SDL_video")
// @:keep
// @:native("SDL2/SDL_video")
// extern class SDL_Window
// {

// }

// @:include("SDL2/SDL_version")
// @:keep
// @:native("SDL2/SDL_version")
// extern class Version
// {
// 	@:native("SDL_GetRevisionNumber")
//     public static function init():Int;
// }


// @:include("SDL2/SDL_cpuinfo")
// @:keep
// @:native("SDL2/SDL_cpuinfo")
// extern class CpuInfo
// {
// 	@:native("SDL_GetCPUCount")
//     public static function count():Int;

//     @:native("SDL_GetSystemRAM")
//     public static function ram():Int;
// }

// @:include("SDL2/SDL_power")
// @:keep
// @:native("SDL2/SDL_power")
// extern class Power
// {
// 	@:native("SDL_GetPowerInfo")
//     public static function power(?secs:Null<Int>, ?pc:Null<Int>):SDL_PowerState;
// }

// @:native("SDL2/SDL_power")
// extern enum SDL_PowerState
// {

// }
