package giant.components
{
	import giant.core.UIComponent;
	
	public class Canvas extends UIComponent
	{
		private var _backgroundColor:uint = 0xFFFFFF;
		private var _backgroundAlpha:Number = 1;
		
		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(value:Number):void
		{
			if(_backgroundAlpha!=value){
				_backgroundAlpha = value;
				invalidateProperties();
			}
		}

		public function set backgroundColor(value:uint):void{
			if(_backgroundColor!=value){
				_backgroundColor = value;
				invalidateProperties();
			}
		}
		public function get backgroundColor():uint{
			return _backgroundColor;
		}
		public function Canvas()
		{
			super();
		}
		
		override protected function commitProperties():void{
			graphics.beginFill(backgroundColor,backgroundAlpha);
			graphics.drawRect(0,0,explicitWidth,explicitHeight);
			graphics.endFill();
		}
	}
}