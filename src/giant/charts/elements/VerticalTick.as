package giant.charts.elements
{
	import giant.charts.managers.ThemeManager;
	import giant.components.Canvas;
	
	public class VerticalTick extends Canvas
	{
		public function VerticalTick()
		{
			super();
		}
		override protected function commitProperties():void{
			super.commitProperties();
			width = 5;
			height = ThemeManager.tickStrokeSize;
			graphics.beginFill(ThemeManager.tickColor,1.0);
			graphics.drawRect(0,-height,explicitWidth,explicitHeight);
			graphics.endFill();
		}
	}
}