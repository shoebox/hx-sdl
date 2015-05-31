package sdl;

import haxe.macro.Context;
import haxe.macro.Expr;

class ExternMacro
{
	static public function build():Array<Field>
	{
		var fields = Context.getBuildFields();
		for (field in fields)
		{
			var pos = Context.currentPos();
			var name = macro 'SDL_${field.name}';
			
			var entry:MetadataEntry =
			{
				name : ":native",
				params : [name],
				pos : pos
			};

			field.meta = [entry];
		}

		return fields;
	}
}
