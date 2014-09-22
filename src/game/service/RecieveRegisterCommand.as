package game.service
{
	import game.event.GameInitializeEvent;
	import game.event.ReceiveEvent;
	
	import org.robotlegs.mvcs.Command;

	public class RecieveRegisterCommand extends Command
	{
		[Inject]
		public var event :ReceiveEvent;
		
		public function RecieveRegisterCommand()
		{
		}
		
		override public function execute():void
		{
			var obj :Object = event.data;
			//若服务器直接只发一个值，这边直接读取object就行
			trace("验证结果:",obj);
			
			switch(obj)
			{
				case 1://成功
				{
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_SUCESS,null);
					dispatch(event);
					
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_CLEAR,null);
					dispatch(event);
					break;
				}
					
				case 2://密码错误
				{
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_ERROR,"用户已被注册");
					dispatch(event);
					
					break;
				}
					
					
				default:
				{
					throw new Error("未知包类型");
					break;
				}
			}
		}
		
		
	}
}