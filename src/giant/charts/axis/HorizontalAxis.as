package giant.charts.axis
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import giant.charts.managers.ThemeManager;
	import giant.charts.elements.HorizontalTick;
	
	public class HorizontalAxis extends LinearAxis
	{
		public var xField:String;
		public var yField:String;
		public function HorizontalAxis()
		{
			super();
		}
		
		override protected function createChildren():void{
			graphics.beginFill(ThemeManager.axisColor);
			graphics.drawRect(0,0,explicitWidth,ThemeManager.axisStrokeSize);
			graphics.endFill();
			var tickLen:int = chartDataProvider.labels.length;
			var blockSize:Number = width/tickLen;
			var obj:Object = null;
			for(var i:int=0;i<tickLen;i++){
				var hTick:HorizontalTick = new HorizontalTick();
				hTick.x = blockSize*i;
				ticks[i] = hTick;
				var tickLabel:TextField = new TextField();
				var textFormat:TextFormat = new TextFormat("Arial",ThemeManager.tickLabelSize,ThemeManager.tickLabelColor);
				tickLabel.autoSize = TextFieldAutoSize.CENTER;
				tickLabel.defaultTextFormat = textFormat;
				tickLabel.text = chartDataProvider.labels[i];
				tickLabel.x = hTick.x + blockSize/2 - tickLabel.width/2;
				tickLabel.y = 5;
				tickLabel.selectable = false;
				if(i!=0){
					addChild(hTick);
				}
				
				addChild(tickLabel);
			}
		}
		
		override protected function commitProperties():void{
			super.commitProperties();
			
		}
		
		override protected function updateDisplayList():void{
			
		}
		
	}
}