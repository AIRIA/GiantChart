package giant.charts.elements
{
	import flash.display.DisplayObject;
	
	import giant.components.Canvas;
	
	public class ChartBase extends Canvas
	{
		public var dataProvider:Object;
		private var _anotationElements:Array = [];
		private var _backgroundElements:Array = [];
		protected var anotationLayer:Canvas;
		protected var backgroundLayer:Canvas;
		protected var chartLayer:Canvas;
		public var columnSeriesNum:Number=0;
		private var _series:Array = [];
		
		public function get series():Array
		{
			return _series;
		}
		
		public function set series(value:Array):void
		{
			if(_series!=value){
				_series = value;
				invalidateProperties();
			}
			
		}
		
		private function createCanvas():Canvas{
			var canvas:Canvas = new Canvas();
			canvas.backgroundAlpha = 0;
			return canvas;
		}
		
		public function ChartBase()
		{
			super();
			anotationLayer = createCanvas();
			backgroundLayer = createCanvas();
			chartLayer = createCanvas();
			addChild(backgroundLayer);
			addChild(chartLayer);
			addChild(anotationLayer);
		}
		
		override protected function commitProperties():void{
			anotationLayer.width = backgroundLayer.width = chartLayer.width = width;
			anotationLayer.height = backgroundLayer.height = chartLayer.height = height;
			super.commitProperties();
		}
		
		override protected function updateDisplayList():void{
			for(var bgEle:Object in backgroundElements){
				backgroundLayer.addChild(DisplayObject(bgEle));
			}
			for(var anEle:Object in anotationElements){
				backgroundLayer.addChild(DisplayObject(anEle));
			}
		}

		public function get backgroundElements():Array
		{
			return _backgroundElements;
		}

		public function set backgroundElements(value:Array):void
		{
			if(_backgroundElements!=value){
				_backgroundElements = value;
				invalidateDisplayList();
			}
		}

		public function get anotationElements():Array
		{
			return _anotationElements;
		}

		public function set anotationElements(value:Array):void
		{
			if(_anotationElements!=value){
				_anotationElements = value;
				invalidateDisplayList();
			}
		}

	}
}