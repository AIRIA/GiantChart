package giant.core
{
	
	public class PriorityQuene
	{
		private var priorityBins:Array = [];
		private var maxPriority:int = -1;
		private var minPriority:int= 0;
		
		public function isEmpty():Boolean
		{
			return maxPriority>minPriority;
		}
		
		/**
		 * 将指定的显示对象 按照优先级 添加到队列中 
		 * @param obj
		 * @param priority
		 * 
		 */		
		public function addObject(obj:Object,priority:int):void{
			if(maxPriority < minPriority){
				maxPriority = minPriority = priority;
			}else{
				if(maxPriority<priority){
					maxPriority = priority;
				}else if(priority<minPriority){
					minPriority = priority;
				}
			}
			//check is there already have this entry
			var bin:PriorityBin = priorityBins[priority];
			if(!bin){
				bin = new PriorityBin();
				bin.items[obj] = true;
				bin.length++;
				priorityBins[priority] = bin;
			}else if(bin.items[obj]==null){
				bin.items[obj] = true;
				bin.length++;
			}
			
		}
		
		public function removeAll():void{
			priorityBins.length = 0;
			maxPriority = -1;
			minPriority = 0;
		}
		
		/**
		 *  @private
		 */
		public function removeSmallest():Object
		{
			var obj:Object = null;
			
			if (minPriority <= maxPriority)
			{
				var bin:PriorityBin = priorityBins[minPriority];
				while (!bin || bin.length == 0)
				{
					minPriority++;
					if (minPriority > maxPriority)
						return null;
					bin = priorityBins[minPriority];
				}           
				for (var key:Object in bin.items )
				{
					obj = key;
					removeChild(ILayoutManagerClient(key), minPriority);
					break;
				}
				
				// Update minPriority if applicable.
				while (!bin || bin.length == 0)
				{
					minPriority++;
					if (minPriority > maxPriority)
						break;
					bin = priorityBins[minPriority];
				}           
			}
			
			return obj;
		}
		/**
		 * 返回队列中的对象 逐个调用validate方法 
		 * @return 
		 * 
		 */		
		public function removeLargest():Object{
			var obj:Object = null;
			if(minPriority<=maxPriority){
				var bin:PriorityBin = priorityBins[maxPriority];
				while(!bin || bin.length==0){
					maxPriority--;
					if(maxPriority<minPriority)
						return null;
					bin = priorityBins[maxPriority];
				}
				
				for(var key:Object in bin.items){
					obj = key;
					removeChild(ILayoutManagerClient(key),maxPriority);
					break;
				}
				while(!bin || bin.length==0){
					maxPriority--;
					if(maxPriority<minPriority)
						return null;
					bin = priorityBins[maxPriority];
				}
				
			}
			return obj;
		}
		
		/**
		 *  @private
		 */
		public function removeChild(client:ILayoutManagerClient, level:int=-1):Object
		{
			var priority:int = (level >= 0) ? level : client.nestLevel;
			var bin:PriorityBin = priorityBins[priority];
			if (bin && bin.items[client] != null)
			{
				delete bin.items[client];
				bin.length--;
				return client;
			}
			return null;
		}
		
	}
}
import flash.utils.Dictionary;

//存放同级的条目
class PriorityBin{
	public var length:int;
	public var items:Dictionary = new Dictionary();
}