package giant.charts.elements
{
	import giant.charts.managers.ThemeManager;
	import giant.components.Canvas;
	
	public class HorizontalTick extends Canvas
	{
		public function HorizontalTick()
		{
			super();
		}
		
		override protected function commitProperties():void{
			width = ThemeManager.tickStrokeSize;
			height = 5;
			graphics.beginFill(ThemeManager.tickColor,1.0);
			graphics.drawRect(-width,-height,explicitWidth,explicitHeight);
			graphics.endFill();
		}
		
	}
}