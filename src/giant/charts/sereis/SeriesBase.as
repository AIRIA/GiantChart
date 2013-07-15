package giant.charts.sereis
{
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import giant.charts.axis.LinearAxis;
	import giant.charts.elements.ChartBase;
	import giant.components.Canvas;
	
	public class SeriesBase extends Canvas
	{
		public var xField:String;
		public var yField:String;
		public var vAxis:LinearAxis = null;
		public var dataProvider:Object;
		public var seriesColor:uint = 0x233333;
		protected var hotPointLayer:Canvas;
		protected var originArray:Array = [];
		protected var seriesData:Array = [];
		public var chart:ChartBase;
		protected var startArray:Array = [];
		public function points():Array{
			var pointsArr:Array = [];
			for(var i:int=0;i<pointsNum;i++){
				startArray.push(height);
				pointsArr.push(getVerticalPos(i));
			}
			return pointsArr;
		}
		
		public function SeriesBase()
		{
			super();
			backgroundAlpha = 0;
			hotPointLayer = new Canvas();
			hotPointLayer.backgroundAlpha = 0;
			//开启endArray插件
			TweenPlugin.activate([EndArrayPlugin]);
		}
		
		protected function initSeriesData():void{
			var len:int = dataProvider.data.length;
			for(var i:int=0;i<len;i++){
				seriesData[i] = getValue(i);
				originArray[i] = 0;
			}
		}
		
		protected function get pointsNum():Number{
			return dataProvider.data.length;
		}
		
		protected function get blockSize():Number{
			return width/pointsNum;
		}
		
		protected function getHorzontalPos(idx:int):Number{
			return blockSize*idx;
		}
		
		protected function getValue(idx:int):Number{
			return dataProvider.data[idx][yField];
		}
		
		protected function getVerticalPos(idx:int):Number{
			var y:Number = height-getValue(idx)/vAxis.maximum*height
			return y;
		}
		
		override protected function createChildren():void{
			hotPointLayer.width = width;
			hotPointLayer.height = height;
			addChild(hotPointLayer);
		}
		
	}
}