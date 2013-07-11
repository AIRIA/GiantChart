package giant.core
{
	import flash.display.DisplayObjectContainer;

	public interface IUIComponent
	{
		function set ower(value:DisplayObjectContainer):void;
		function set explicitWidth(value:Number):void;
		function set explicitHeight(value:Number):void;
		function get owner():DisplayObjectContainer;
		function get explicitWidth():Number;
		function get explicitHeight():Number;
		
	}
}