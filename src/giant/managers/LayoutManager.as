package giant.managers
{
	import flash.events.Event;
	
	import giant.core.GiantGlobals;
	import giant.core.ILayoutManagerClient;
	import giant.core.PriorityQuene;

	/**
	 * singleton
	 */
	public class LayoutManager implements ILayoutManager
	{
		
		private static var _instance:LayoutManager = new LayoutManager();
		
		public static function getInstance():LayoutManager{
			return _instance;
		}
		
		
		private var invalidatePropertiesQuene:PriorityQuene = new PriorityQuene();
		private var invalidateSizeQuene:PriorityQuene = new PriorityQuene();
		private var invalidateDisplayListQuene:PriorityQuene = new PriorityQuene();
		
		/**
		 * 标识是不是要开始进行invalidate--validate渲染
		 */
		private var invalidatePropertiesFlag:Boolean = false;
		private var invalidateSizeFlag:Boolean = false;
		private var invalidateDisplayListFlag:Boolean = false;
		/**
		 * 是不是已经添加了enter_frame事件侦听
		 */
		private var listenersAttached:Boolean = false;
		//添加侦听器 延迟一帧执行
		private function attachListeners():void{
			listenersAttached = true;
			GiantGlobals.stage.addEventListener(Event.ENTER_FRAME,waitAFrame);
		}
		
		private function waitAFrame(event:Event):void{
			GiantGlobals.stage.removeEventListener(Event.ENTER_FRAME,waitAFrame);
			GiantGlobals.stage.addEventListener(Event.ENTER_FRAME,renderApp);
		}
		
		private function renderApp(event:Event):void{
			trace("[LayoutManager]:开始渲染");
			GiantGlobals.stage.removeEventListener(Event.ENTER_FRAME,renderApp);
			listenersAttached = false;
			validateProperties();
			validateSize();
			validateDisplayList();
			trace("[LayoutManager]:渲染完毕");
		}
		
		public function LayoutManager()
		{
			if(_instance){
				throw new Error("singleton class can't create instance");
			}
		}
		
		private function validateProperties():void{
			if(invalidatePropertiesFlag){
				invalidatePropertiesFlag = false;
				var obj:ILayoutManagerClient = ILayoutManagerClient(invalidatePropertiesQuene.removeSmallest());
				while(obj){
					obj.validateProperties();
					obj = ILayoutManagerClient(invalidatePropertiesQuene.removeSmallest());
				}
			}
		}
		
		private function validateSize():void{
			if(invalidateSizeFlag){
				invalidateSizeFlag = false;
				var obj:ILayoutManagerClient = ILayoutManagerClient(invalidateSizeQuene.removeSmallest());
				while(obj){
					obj.validateSize();
					obj = ILayoutManagerClient(invalidateSizeQuene.removeLargest());
				}
			}
		}
		
		private function validateDisplayList():void{
			if(invalidateDisplayListFlag){
				invalidateDisplayListFlag = false;
				var obj:ILayoutManagerClient = ILayoutManagerClient(invalidateDisplayListQuene.removeSmallest());
				while(obj){
					obj.validateDisplayList();
					obj = ILayoutManagerClient(invalidateDisplayListQuene.removeSmallest());
				}
			}
		}
		
		public function invalidateProperties(obj:ILayoutManagerClient):void
		{
			if(!invalidatePropertiesFlag){
				invalidatePropertiesFlag = true;
				if(!listenersAttached){
					attachListeners();
				}
			}
			invalidatePropertiesQuene.addObject(obj,obj.nestLevel);
		}
		
		public function invalidateSize(obj:ILayoutManagerClient):void
		{
			if(!invalidateSizeFlag){
				invalidateSizeFlag = true;
				if(!listenersAttached){
					attachListeners();
				}
			}
			invalidateSizeQuene.addObject(obj,obj.nestLevel);
		}
		
		public function invalidateDisplayList(obj:ILayoutManagerClient):void
		{
			if(!invalidateDisplayListFlag){
				invalidateDisplayListFlag = true;
				if(!listenersAttached){
					attachListeners();
				}
			}
			invalidateDisplayListQuene.addObject(obj,obj.nestLevel);
		}
	}
}