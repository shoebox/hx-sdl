package sdl;

import cpp.Pointer;
import sdl.Video;

@:headerCode("#import <SDL2/SDL_messagebox.h>")
class MessageBox
{
	public static function simple(type:MessageBoxType, title:String, message:String, 
		window:Pointer<Window>):Int
	{
		var flag:Int = getFlagValue(type);

		var result:Int = -1;
		untyped __cpp__("result = SDL_ShowSimpleMessageBox(flag, title, message, window)");
		return result;
	}

	inline static function getFlagValue(type:MessageBoxType):Int
	{
		var result = 0;
		switch (type)
		{
			case ERROR:
				result = 0x00000010;

			case WARNING:
				result = 0x00000020;

			case INFORMATION:
				result = 0x00000040;
		}
		
		return result;
	}
}

enum MessageBoxType
{
	ERROR;
	WARNING;
	INFORMATION;
}

