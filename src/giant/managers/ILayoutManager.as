package giant.managers
{
	import giant.core.ILayoutManagerClient;

	public interface ILayoutManager
	{
		function invalidateProperties(obj:ILayoutManagerClient):void;
		function invalidateSize(obj:ILayoutManagerClient):void;
		function invalidateDisplayList(obj:ILayoutManagerClient):void;
	}
}