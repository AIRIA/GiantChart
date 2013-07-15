package giant.charts.sereis
{
	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Quint;
	import com.greensock.plugins.EndArrayPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.Graphics;
	
	import giant.charts.managers.ThemeManager;

	public class LineSeries extends SeriesBase
	{
		public function LineSeries(yField:String="")
		{
			super();
			this.yField = yField;
		}
		private function createWithEffect():void{
			//Bounce.easeOut
			//Back.easeIn
			//Quint.easeInOut
			TweenLite.to(startArray, 1, {endArray:points(),onUpdate:render,onUpdateParams:[startArray],ease:Quint.easeInOut});
		}
		
		private function render(rtPoint:Object):void{
			var fpX:Number = getHorzontalPos(0)+blockSize/2;
			var fpY:Number = rtPoint[0]+ThemeManager.seriesStrokeSize/2;
			var fpX1:Number,fpY1:Number;
			graphics.clear();
			graphics.lineStyle(ThemeManager.seriesStrokeSize,seriesColor,1);
			graphics.moveTo(fpX,fpY);
			var hotPointGra:Graphics = hotPointLayer.graphics;
			hotPointGra.clear();
			hotPointGra.beginFill(seriesColor,1);
			for(var i:int=0;i<pointsNum;i++){
				fpX = getHorzontalPos(i)+blockSize/2;
				fpY = rtPoint[i]+ThemeManager.seriesStrokeSize/2;
				if(i==pointsNum-1){
					fpX1 = getHorzontalPos(i+1)+blockSize/2;
					fpY1 = rtPoint[i+1]+ThemeManager.seriesStrokeSize/2;
				}else{
					fpX1 = fpX;
					fpY1 = fpY;
				}
				
				graphics.lineTo(fpX,fpY);
//				graphics.curveTo(fpX,fpY,Math.random()*500,Math.random()*300)
				hotPointGra.drawCircle(fpX,fpY,ThemeManager.hotPointSize);
			}
			hotPointGra.endFill();
		}
		
		override protected function updateDisplayList():void{
			createWithEffect();
//			render(points());
		}
		
	}
}

