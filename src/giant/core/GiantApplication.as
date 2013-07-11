package giant.core
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import giant.managers.LayoutManager;

	public class GiantApplication extends UIComponent
	{
		public function GiantApplication()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			GiantGlobals.layoutManager = LayoutManager.getInstance();
			GiantGlobals.stage = stage;
		}
	}
}