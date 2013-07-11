package giant.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 实现失效和 验证生效的延迟渲染机制 避免重复渲染
	 * 所有的显示列表对象 都应该继承UIComponent类 来遵循invalidate-validate验证机制
	 * 当需要更新显示对象的属性 并且要反映到屏幕上的时候 调用invalidate方法 将invalidateXXXFlag失效标识设置成true 标记为已经失效
	 * 此时UI控件已经添加到了LayoutManager的验证管理器中
	 * 在下一帧渲染的时候 会调用ILayoutManager的validateXXX 方法 与此同时 会将invalidateXXXFlag失效标识设置成false 标记为已经生效 
	 * 在相应的validate方法中 调用处理的逻辑 来更新屏幕的显示内容
	 */
	public class UIComponent extends GiantSprite implements IUIComponent,ILayoutManagerClient,IInvalidating
	{
		// 失效验证的标识 如果flag设置为true的话 会标记为失效 会在下一帧渲染的时候 调用相应的validate方法
		private var invalidateProperteisFlag:Boolean = false;
		private var invalidateSizeFlag:Boolean = false;
		private var invalidateDisplayListFlag:Boolean = false;
		
		private var _owner:DisplayObjectContainer;
		private var _nestLevel:Number = 0;
		private var _explicitWidth:Number = 0;
		private var _explicitHeight:Number = 0;
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		override public function get width():Number{
			return _width;
		}
		
		override public function get height():Number{
			return _height;
		}
		
		override public function set width(value:Number):void{
			if(_width!=value){
				_width = value;
				_explicitWidth = value;
				invalidateProperties();
				invalidateSize();
			}
		}
		
		override public function set height(value:Number):void{
			if(_height!=value){
				_height = value;
				_explicitHeight = value;
				invalidateProperties();
				invalidateSize();
			}
		}
		
		private var initialized:Boolean = false;
		
		override public function addChild(child:DisplayObject):DisplayObject{
			var uiCmp:UIComponent = child as UIComponent;
			if(uiCmp){
				uiCmp.nestLevel = nestLevel+1;
				if(uiCmp.initialized == false){
					uiCmp.initialize();
					uiCmp.initialized = true;
				}
			}
			super.addChild(child);
			return child;
		}
		
		private function initialize():void{
			createChildren();
			invalidateProperties();
			invalidateSize();
			invalidateDisplayList();
		}
		
		protected function createChildren():void{
			
		}
		
		/**
		 * 提交属性信息
		 */
		protected function commitProperties():void{
			
		}
		/**
		 * 根据属性信息开始测量组件的尺寸
		 */
		protected function measureSize():void{
		
		}
		/**
		 * 根据组件的尺寸来对子组件进行布局
		 */
		protected function updateDisplayList():void{
		
		}
		
		public function UIComponent()
		{
			super();
		}
		
		public function invalidateDisplayList():void
		{
			if(!invalidateDisplayListFlag){
				invalidateDisplayListFlag = true;
				GiantGlobals.layoutManager.invalidateDisplayList(this);
			}
		}
		
		public function invalidateProperties():void
		{
			if(!invalidateProperteisFlag){
				invalidateProperteisFlag = true;
				GiantGlobals.layoutManager.invalidateProperties(this);
			}
		}
		
		public function invalidateSize():void
		{
			if(!invalidateSizeFlag){
				invalidateSizeFlag = true;
				GiantGlobals.layoutManager.invalidateSize(this);
			}
		}
		
		public function validateNow():void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function validateDisplayList():void
		{
			if(invalidateDisplayListFlag){
				updateDisplayList();
				invalidateDisplayListFlag = false;
			}
		}
		
		public function validateProperties():void
		{
			if(invalidateProperteisFlag){
				commitProperties();
				invalidateProperteisFlag = false;
			}
		}
		
		public function validateSize():void
		{
			if(invalidateSizeFlag){
				measureSize();
				invalidateSizeFlag = false;
			}
		}
		
		public function set explicitHeight(value:Number):void
		{
			if(_explicitHeight!=value){
				_explicitHeight = value;
				invalidateProperties();
			}
		}
		
		public function get explicitHeight():Number
		{
			return _explicitHeight;
		}
		
		public function set explicitWidth(value:Number):void
		{
			if(_explicitWidth!=value){
				_explicitWidth = value;
				invalidateProperties();
			}
		}
		
		public function get explicitWidth():Number
		{
			return _explicitWidth;
		}
		
		public function get nestLevel():Number
		{
			return _nestLevel;
		}
		
		public function set nestLevel(value:Number):void
		{
			if(_nestLevel!=value){
				_nestLevel = value;
				value++;
				/**
				 * 可以达到级联设置子级显示列表nestLevel的效果
				 */
				for(var i:int=0;i<numChildren;i++){
					var ui:UIComponent = getChildAt(i) as UIComponent;
					if(ui){
						ui.nestLevel = value;
					}
				}
			}
		}
		
		public function set ower(value:DisplayObjectContainer):void
		{
			if(_owner!=value){
				_owner = value;
			}
		}
		
		public function get owner():DisplayObjectContainer
		{
			return _owner;
		}
		
	}
}