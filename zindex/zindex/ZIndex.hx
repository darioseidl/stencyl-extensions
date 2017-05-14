import com.stencyl.models.Actor;

class ZIndex
{
	public static function moveToBottom(actor:Actor)
	{
		actor.parent.setChildIndex(actor,0);
	}
	
	public static function moveToTop(actor:Actor)
	{
		actor.parent.setChildIndex(actor,actor.parent.numChildren-1);
	}
	
	public static function moveDown(actor:Actor)
	{
		var index:Int = actor.parent.getChildIndex(actor);
		if (index > 0)
		{
			actor.parent.setChildIndex(actor,index-1);
		}
	}
	
	public static function moveUp(actor:Actor)
	{
		var index:Int = actor.parent.getChildIndex(actor);
		var max:Int = actor.parent.numChildren-1;
		if (index < max)
		{
			actor.parent.setChildIndex(actor,index+1);
		}
	}
	
	public static function getZIndex(actor:Actor):Int
	{
		return actor.parent.getChildIndex(actor);
	}
	
	public static function getNumberOfActors(actor:Actor):Int
	{
		return actor.parent.numChildren;
	}
}
