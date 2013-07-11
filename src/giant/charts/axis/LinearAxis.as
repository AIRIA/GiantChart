package giant.charts.axis
{
	import giant.charts.elements.ChartBase;

	public class LinearAxis extends Axis
	{
		public var interval:Number;
		public var maximum:Number = 0;
		public var minimum:Number = 0;
		public var minerInterval:Number;
		public var ticks:Array = [];
		public var chart:ChartBase;
		public function LinearAxis()
		{
			super();
		}
	}
}