package giant.core
{
	import flash.events.IEventDispatcher;
	
	public interface ILayoutManagerClient extends IEventDispatcher
	{
		function validateProperties():void;
		function validateSize():void;
		function validateDisplayList():void;
		function get nestLevel():Number;
		function set nestLevel(value:Number):void;
	}
}