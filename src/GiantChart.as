package
{
	
	import giant.charts.axis.HorizontalAxis;
	import giant.charts.elements.LineChart;
	import giant.charts.sereis.ColumnSeries;
	import giant.charts.sereis.LineSeries;
	import giant.core.GiantApplication;

	[SWF(width="1000",frameRate="60",height="600",backgroundColor="0x222222")]
	public class GiantChart extends GiantApplication
	{
		public function GiantChart()
		{
			var series:Array = [];
			var expenses:LineSeries = new LineSeries("Expenses");
			var profit:LineSeries = new LineSeries("Profit");
			var amount:ColumnSeries = new ColumnSeries("Amount");
			series.push(amount);
			series.push(expenses);
			series.push(profit);
			var lineChart:LineChart = new LineChart();
			var hAxis:HorizontalAxis = new HorizontalAxis();
			hAxis.xField = "Month";
			lineChart.dataProvider = TestData.data;
			lineChart.width = 600;
			lineChart.height = 330;
			lineChart.backgroundColor = 0x333333;
			lineChart.hAxis = hAxis;
			lineChart.series = series;
			addChild(lineChart);
			
			lineChart.x = stage.stageWidth - lineChart.width >> 1;
			lineChart.y = stage.stageHeight - lineChart.height >>1;
		}
	}
}