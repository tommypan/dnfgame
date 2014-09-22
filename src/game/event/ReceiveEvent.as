package game.event
{
	import flash.events.Event;

	/** 
	 * 接收服务器事务事件
	 * 
	 * @author pengbinke
	 * <p> 2013-3-14 下午6:12:04
	 */
	public class ReceiveEvent extends Event
	{
		/**逻辑业务*/
		public var data :Object;
		
		public function ReceiveEvent( type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			this.data = data;
			
			super(type, bubbles, cancelable);
		}
	}
}