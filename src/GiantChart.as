package
{
	
	import flash.events.Event;
	
	import giant.charts.axis.HorizontalAxis;
	import giant.charts.elements.LineChart;
	import giant.charts.sereis.ColumnSeries;
	import giant.charts.sereis.LineSeries;
	import giant.core.GiantApplication;

	[SWF(width="600",frameRate="60",height="400",backgroundColor="0x222222")]
	public class GiantChart extends GiantApplication
	{
		private var lineChart:LineChart;
		public function GiantChart()
		{
			stage.addEventListener(Event.RESIZE,resizeHandler);
			addEventListener(Event.ADDED_TO_STAGE,addedToStageHandler);
			lineChart = new LineChart();
		}
		
		private function addedToStageHandler(event:Event = null):void{
			var series:Array = [];
			var expenses:LineSeries = new LineSeries("Expenses");
			var profit:LineSeries = new LineSeries("Profit");
			var amount:ColumnSeries = new ColumnSeries("Amount");
			series.push(amount);
			series.push(expenses);
			series.push(profit);
			var hAxis:HorizontalAxis = new HorizontalAxis();
			hAxis.xField = "Month";
			lineChart.dataProvider = TestData.dataObj;
			lineChart.width = stage.stageWidth-80;
			lineChart.height = stage.stageHeight-80;
			lineChart.backgroundColor = 0x333333;
			lineChart.hAxis = hAxis;
			lineChart.series = series;
			lineChart.x = stage.stageWidth - lineChart.width >> 1;
			lineChart.y = stage.stageHeight - lineChart.height >>1;
			addChild(lineChart);
		}
		
		private function resizeHandler(event:Event):void{
			addedToStageHandler();
		}
	}
}