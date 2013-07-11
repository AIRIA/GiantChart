package giant.charts.elements
{
	import flash.globalization.LocaleID;
	import flash.globalization.NumberFormatter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import giant.charts.axis.LinearAxis;
	import giant.charts.managers.ThemeManager;
	
	public class VerticalAxis extends LinearAxis
	{
		public var xField:String;
		public var yField:String;
		public function VerticalAxis()
		{
			super();
		}
		
		private function getNearest(value:Number):Number{
			if(value>10){
				var i:int = 1;
				value = int(value /= 10);
				while(value>10){
					i++;
					value = int(value /= 10);
				}
				value += 1;
				while(i>0){
					i--;
					value *= 10;
				}
			}else if(value>1){
				value = Math.floor(++value);
			}
			return value;
		}
		
		private function formatMaximum():void{
			maximum = getNearest(maximum);
			var nf:NumberFormatter = new NumberFormatter(LocaleID.DEFAULT);
			trace(maximum);
			if(maximum>=1){
				nf.trailingZeros = true;
				nf.fractionalDigits = 2;
				interval =maximum/5;
				if(interval<1){
					var formatStr:String = nf.formatNumber(interval);
					interval = Number(formatStr);
				}else{
					
				}
				
			}else{
				
			}
		}
		
		override protected function commitProperties():void{
			graphics.beginFill(ThemeManager.axisColor,1.0);
			graphics.drawRect(40,0,ThemeManager.axisStrokeSize,explicitHeight);
			graphics.endFill();
		}
		
		override protected function createChildren():void{
			formatMaximum();
			var blockSize:Number = height/5;
			
			var fix:int = 0;
			if(String(interval).indexOf(".")!=-1){
				fix = String(interval).length - String(interval).indexOf(".") - 1;
			}
			for(var i:int=5;i>=0;i--){
				var tickLabel:TextField = new TextField();
				var textFormat:TextFormat = new TextFormat("Arial",ThemeManager.tickLabelSize,ThemeManager.tickLabelColor);
				tickLabel.autoSize = TextFieldAutoSize.RIGHT;
				tickLabel.selectable = false;
				tickLabel.defaultTextFormat = textFormat;
				
				tickLabel.text = ((5-i)*interval).toFixed(fix);
				var vTick:VerticalTick = new VerticalTick();
				vTick.y = blockSize*i+ThemeManager.axisStrokeSize;
				vTick.x = 40+ThemeManager.axisStrokeSize;
				tickLabel.y = blockSize*i - tickLabel.height/2;
				tickLabel.x = vTick.x - tickLabel.width;
				addChild(vTick);
				addChild(tickLabel);
				
			}
		}
	}
}