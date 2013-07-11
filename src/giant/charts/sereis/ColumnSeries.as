package giant.charts.sereis
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Quint;
	
	import giant.components.Canvas;

	public class ColumnSeries extends SeriesBase
	{
		public var columnWidthRatio:Number = 0.65;
		public var offsetRatio:Number = 0;
		public var columnColor:uint;
		private var columns:Array = [];
		public function ColumnSeries()
		{
			super();
		} 
		
		override protected function createChildren():void{
			for(var i:int=0;i<pointsNum;i++){
				var column:Canvas = new Canvas();
				columns.push(column);
				addChild(column);
			}
		}
		
		private function createWithEffect():void{
			TweenLite.to(startArray, 1, {endArray:points(),onUpdate:render,onUpdateParams:[startArray],ease:Quint.easeInOut});
		}
		
		private function render(rtPoint:Array):void{
			for(var i:int=0;i<pointsNum;i++){
				var column:Canvas = columns[i];
				column.graphics.clear();
				column.graphics.lineStyle(1,seriesColor);
				column.graphics.beginFill(seriesColor,0.5);
				column.graphics.drawRect(0,rtPoint[i],blockSize*columnWidthRatio,height-rtPoint[i]);
				column.graphics.endFill();
				column.x = blockSize*(i+offsetRatio);
			}
		}
		
		override protected function updateDisplayList():void{
			
			render(points());
//			createWithEffect();
		}
	}
}