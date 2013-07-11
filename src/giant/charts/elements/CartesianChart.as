package giant.charts.elements
{
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	
	import giant.charts.axis.HorizontalAxis;
	import giant.charts.managers.ThemeManager;
	import giant.charts.sereis.ColumnSeries;
	import giant.charts.sereis.SeriesBase;
	import giant.components.Canvas;

	/**
	 * 笛卡尔图表
	 */
	public class CartesianChart extends ChartBase
	{
		public var tipRenderer:Function = null;
		public var verticalLabelRenderer:Function = null;
		public var horizontalLabelRenderer:Function = null;
		
		
		private var _hAxis:HorizontalAxis;
		private var _vAxis:VerticalAxis;
		private var hAxisHolder:Canvas;
		private var vAxisHolder:Canvas;
		private var seriesHolder:Canvas;
		//详细数据tip layer
		private var dataTipHolder:Canvas = new Canvas();
		
		private var columnSerires:Array = [];
		public function CartesianChart()
		{
			super();
		}

		private function setVerticalAxis():VerticalAxis{
			var vAxis:VerticalAxis = new VerticalAxis();
			return vAxis;
		}
		
		/**
		 * 根据柱状图的数量 设置柱状图的偏移量和宽度因子
		 */
		private function setColumnSeriesPro():void{
			var cs:ColumnSeries = null;
			for(var i:int=0;i<columnSeriesNum;i++){
				
				cs = columnSerires[i];
				var cwr:Number = cs.columnWidthRatio;
				cs.columnWidthRatio /= columnSeriesNum;
				cs.offsetRatio = (1-cwr)/2+cs.columnWidthRatio*i;
			}
		}
		
		override protected function commitProperties():void{
			var seriesLen:int = series.length;
			var dpLen:int = dataProvider.length;
			for(var i:int=0;i<seriesLen;i++){
				var currentSeries:SeriesBase = series[i];
				currentSeries.width = seriesHolder.width;
				currentSeries.height = seriesHolder.height;
				currentSeries.seriesColor = ThemeManager.seriesColor[i];
				currentSeries.dataProvider= dataProvider;
				currentSeries.chart = this;
				if(currentSeries is ColumnSeries){
					columnSeriesNum++;
					columnSerires.push(currentSeries);
				}
				if(currentSeries.vAxis==null){
					currentSeries.vAxis = vAxis;
				}
				for(var j:int=0;j<dpLen;j++){
					var currentValue:Number = dataProvider[j][currentSeries.yField]
					if(vAxis.maximum < currentValue){
						vAxis.maximum = currentValue;
					}
					if(vAxis.minimum > currentValue){
						vAxis.minimum = currentValue;
					}
				}
				seriesHolder.addChild(currentSeries);
			}
			vAxisHolder.addChild(vAxis);
			setColumnSeriesPro();
		}
		
		override protected function createChildren():void{
			vAxis = setVerticalAxis();
			hAxisHolder = new Canvas();
			vAxisHolder = new Canvas();
			seriesHolder = new Canvas();
			dataTipHolder.backgroundAlpha = seriesHolder.backgroundAlpha = 0;
			
			vAxisHolder.width = 40;
			hAxisHolder.height = 40;
			vAxis.height = vAxisHolder.height = height - hAxisHolder.height;
			hAxis.width = hAxisHolder.width = width - vAxisHolder.width;
			dataTipHolder.width = seriesHolder.width = width - vAxisHolder.width;
			dataTipHolder.height = seriesHolder.height = height - hAxisHolder.height;
			dataTipHolder.x = seriesHolder.x = vAxisHolder.width ;
			dataTipHolder.mouseEnabled = false;
			seriesHolder.mouseChildren = false;
			
			hAxisHolder.y = vAxisHolder.height;
			hAxisHolder.x = vAxisHolder.width;
			
			hAxisHolder.backgroundColor = 0x443322;
			vAxisHolder.backgroundColor = 0x342123;
			hAxisHolder.addChild(hAxis);
			seriesHolder.addEventListener(MouseEvent.MOUSE_MOVE,showTipHandler);
			addChild(vAxisHolder);
			addChild(hAxisHolder);
			addChild(seriesHolder);
			addChild(dataTipHolder);
			
		}
		
		private function showTipHandler(event:MouseEvent):void{
			var localX:Number = event.localX;
			var blockNum:Number = dataProvider.length;
			var blockWidth:Number = dataTipHolder.width/blockNum;
			for(var i:int = blockNum-1;i>=0;i--){
				if(localX>(blockWidth*i)){
					var tipGraphic:Graphics = dataTipHolder.graphics;
					tipGraphic.clear();
					tipGraphic.lineStyle(1,0xFFFFFF);
					var x:Number = blockWidth*(i+0.5);
					var y:Number = dataTipHolder.height;
					tipGraphic.moveTo(x,0);
					tipGraphic.lineTo(x,y);
					break;
				}
			}
			
//			if(tipRenderer){
//				tipRenderer(seriesHolder);
//			}else{
//				
//			}
		}
		
		override protected function updateDisplayList():void{
			
		}
		
		public function get vAxis():VerticalAxis
		{
			return _vAxis;
		}

		public function set vAxis(value:VerticalAxis):void
		{
			if(_vAxis!=value){
				_vAxis = value;
				_vAxis.chartDataProvider = dataProvider;
				_vAxis.chart = this;
				
			}
		}

		public function get hAxis():HorizontalAxis
		{
			return _hAxis;
		}

		public function set hAxis(value:HorizontalAxis):void
		{
			if(_hAxis!=value){
				_hAxis = value;
				_hAxis.chartDataProvider = dataProvider;
				_hAxis.chart = this;
			}
		}

	}
}