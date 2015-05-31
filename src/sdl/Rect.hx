package sdl;

import cpp.Pointer;

@:unreflective
@:headerCode("#import <SDL2/SDL_rect.h>")
class Rect
{
	public var native(default, null):SDLRect;
	public var x(default, set):Int;
	function set_x(value:Int):Int
	{
		native.x = value;
		return this.x = value;
	}

	public var y(default, set):Int;
	function set_y(value:Int):Int
	{
		native.y = value;
		return this.y = value;
	}

	public var width(default, set):Int;
	function set_width(value:Int):Int
	{
		native.w = value;
		return this.width = value;
	}

	public var height(default, set):Int;
	function set_height(value:Int):Int
	{
		native.h = value;
		return this.height = value;
	}

	public function new(?x:Int, ?y:Int, ?width:Int, ?height:Int)
	{
		native = create(x, y, width, height);
		invalidate();
	}

	public function invalidate()
	{
		x = native.x;
		y = native.y;
		width = native.w;
		height = native.h;
	}

	public function toString():String
	{
		return '[Rect x:$x \t y:$y \t w:$width \t h:$height]';
	}

	@:functionCode("return SDL_RectEmpty(&native);")
	public function isEmpty():Bool
	{
		return false;
	}

	@:functionCode("return SDL_RectEquals(&native, &to->native);")
	public function equals(to:Rect):Bool
	{
		return false;
	}

	@:functionCode("return SDL_HasIntersection(&native, &against->native);")
	public function hasIntersection(against:Rect)
	{
		return false;
	}

	public function intersectRect(against:Rect, ?result:Rect):Rect
	{
		if (result == null) result = new Rect();
		untyped __cpp__('SDL_IntersectRect(&native, &against->native, &result->native)');
		result.invalidate();
		return result;
	}

	public function union(with:Rect, ?result:Rect):Rect
	{
		if (result == null) result = new Rect();
		untyped __cpp__('SDL_UnionRect(&native, &with->native, &result->native)');
		result.invalidate();
		return result;
	}

	@:cpp static var empty:SDLRect;
	@:functionCode("
		SDL_Rect rect = {x, y, w, h};
		return rect;
	")
	static function create(x:Int, y:Int, w:Int, h:Int):SDLRect
	{
		return empty;
	}
}

@:include("SDL2/SDL_rect.h")
@:native("SDL_Rect")
@:structAccess
extern class SDLRect
{
	public var x:Int;
	public var y:Int;
	public var w:Int;
	public var h:Int;
}
