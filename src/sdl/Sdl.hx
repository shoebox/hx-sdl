package sdl;

@:include("SDL2/SDL.h")
@:native("SDL2/SDL")
extern class Sdl
{
	@:native("SDL_Init")
	public static function init(flag:Int):Int;

	@:native("SDL_InitSubSystem")
	public static function initSubSystem(flag:Int):Int;

	@:native("SDL_QuitSubSystem")
	public static function quitSubSystem(flag:Int):Void;
	
	@:native("SDL_WasInit") 
	public static function wasInit(flag:Int):Int;

	@:native("SDL_Quit")
	public static function quit():Void;
}

class SdlInitFlag
{
	public static inline var TIMER = 0x00000001;
	public static inline var AUDIO = 0x00000010;
	public static inline var VIDEO = 0x00000020;  /**< VIDEO implies EVENTS */
	public static inline var JOYSTICK = 0x00000200;  /**< JOYSTICK implies EVENTS */
	public static inline var HAPTIC = 0x00001000;
	public static inline var GAMECONTROLLER = 0x00002000;  /**< GAMECONTROLLER implies JOYSTICK */
	public static inline var EVENTS = 0x00004000;
	public static inline var NOPARACHUTE = 0x00100000;  /**< Don't catch fatal signals */
	public static inline var EVERYTHING = TIMER | AUDIO | VIDEO | EVENTS 
		| JOYSTICK | HAPTIC | GAMECONTROLLER;
}
