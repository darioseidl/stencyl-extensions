import com.stencyl.Input;
import openfl.ui.Keyboard;

class CustomControls
{
	public static function setControl(control:String, keyCode:Int)
	{
		trace("Set control " + control + " to key code " + keyCode + ".");
		Input.define(control, [keyCode]);
	}
	
	public static function setControlByName(control:String, key:String)
	{
		trace("Set control " + control + " to key " + key + ".");
		if (Reflect.hasField(Keyboard, key))
		{
			var keyCode:Int = Reflect.field(Keyboard, key);
			Input.define(control, [keyCode]);
		}
		else
		{
			trace("Failed to set control " + control + " to unknown key " + key + ".");
		}
	}
	
	public static function addKeyToControl(control:String, keyCode:Int)
	{
		trace("Add key code " + keyCode + " to control " + control + ".");
		Input.mapKey(keyCode, control);
	}
	
	public static function addKeyToControlByName(control:String, key:String)
	{
		trace("Add key " + key + " to control " + control + ".");
		if (Reflect.hasField(Keyboard, key))
		{
			var keyCode:Int = Reflect.field(Keyboard, key);
			Input.mapKey(keyCode, control);
		}
		else
		{
			trace("Failed to add unknown key " + key + " to control " + control + ".");
		}
	}
	
	@:access(com.stencyl.Input._controlMap)
	public static function getControlConfig():Array<String>
	{
		var controlConfig:Array<String> = new Array<String>();
		var controlMap:Map<String,Control> = Input._controlMap;
		for (control in controlMap.keys())
		{
			controlConfig.push(control + ";" + controlMap.get(control).keys.join(","));
			trace(control + ";" + controlMap.get(control).keys.join(","));
		}
		return controlConfig;
	}
	
	public static function applyControlConfig(config:Array<Dynamic>)
	{
		for(i in 0...config.length)
		{
			var controlKeys:Array<String> = cast(config[i], String).split(";");
			var control:String = controlKeys[0];
			Input.unmapControl(control);
			
			var keyStrings:Array<String> = controlKeys[1].split(",");
			for (j in 0...keyStrings.length)
			{
				Input.mapKey(Std.parseInt(keyStrings[j]), control);
			}
			
			trace("Set control " + control + " to keys " + keyStrings + ".");
		}
	}
}
