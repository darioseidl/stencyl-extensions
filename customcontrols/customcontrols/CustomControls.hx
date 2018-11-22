import com.stencyl.Input;
import openfl.ui.Keyboard;

class CustomControls
{
	public static function setControl(control:String, keyCode:Int)
	{
		trace("Set control " + control + " to key code " + keyCode + ".");
		getControl(control).keys = [keyCode];
	}
	
	public static function setControlByName(control:String, key:String)
	{
		trace("Set control " + control + " to key " + key + ".");
		if (Reflect.hasField(Keyboard, key))
		{
			var keyCode:Int = Reflect.field(Keyboard, key);
			getControl(control).keys = [keyCode];
		}
		else
		{
			trace("Failed to set control " + control + " to unknown key " + key + ".");
		}
	}
	
	public static function addKeyToControl(control:String, keyCode:Int)
	{
		trace("Add key code " + keyCode + " to control " + control + ".");
		var keys:Array<Int> = Input.getControlMap().get(control).keys;
		keys.remove(keyCode);
		keys.push(keyCode);
	}
	
	public static function addKeyToControlByName(control:String, key:String)
	{
		trace("Add key " + key + " to control " + control + ".");
		if (Reflect.hasField(Keyboard, key))
		{
			var keyCode:Int = Reflect.field(Keyboard, key);
			var keys:Array<Int> = Input.getControlMap().get(control).keys;
			keys.remove(keyCode);
			keys.push(keyCode);
		}
		else
		{
			trace("Failed to add unknown key " + key + " to control " + control + ".");
		}
	}
	
	public static function getControlConfig():Array<String>
	{
		var controlConfig:Array<String> = new Array<String>();
		var controlMap:Map<String,Control> = Input.getControlMap();
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
			var keyStrings:Array<String> = controlKeys[1].split(",");
			var keys:Array<Int> = new Array<Int>();
			for (j in 0...keyStrings.length)
			{
				keys.push(Std.parseInt(keyStrings[j]));
			}
			getControl(control).keys = keys;
			trace("Set control " + control + " to keys " + keys + ".");
		}
	}
	
	private static function getControl(controlName:String):Control
	{
		if(Input.getControlMap().exists(controlName))
		{
			return Input.getControlMap().get(controlName);
		}
		return Input.define(controlName);
	}
}
