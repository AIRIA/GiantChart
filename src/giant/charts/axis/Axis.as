package giant.charts.axis
{
	import giant.components.Canvas;
	
	public class Axis extends Canvas
	{
		private var _chartDataProvider:Array;
		public var displayName:String;
		public var title:String;
		
		public function get chartDataProvider():Array
		{
			return _chartDataProvider;
		}

		public function set chartDataProvider(value:Array):void
		{
			if(_chartDataProvider!=value){
				_chartDataProvider = value;
				invalidateDisplayList();
			}
			
		}
		
		public function Axis()
		{
			super();
		}

	}
}