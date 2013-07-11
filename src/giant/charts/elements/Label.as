package giant.charts.elements
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import giant.components.Canvas;
	
	public class Label extends Canvas
	{
		private var textField:TextField;
		private var textFormat:TextFormat;
		private var _text:String;
		
		public function Label()
		{
			super();
		}
		
		override protected function createChildren():void{
			textField = new TextField();
			textField.autoSize = TextFieldAutoSize.CENTER;
		}
		
		override protected function commitProperties():void{
			
		}
	}
}