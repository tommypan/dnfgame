package game.service
{
	import game.event.GameInitializeEvent;
	import game.event.ReceiveEvent;
	
	import org.robotlegs.mvcs.Command;
	
	public class RecieveAccountCommand extends Command
	{
		[Inject]
		public var event :ReceiveEvent;
		
		public function RecieveAccountCommand()
		{
		}
		
		public override function execute():void
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
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_ERROR,"密码错误");
					dispatch(event);
					
					break;
				}
					
				case 4://账户冻结
				{
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_ERROR,"账户冻结");
					dispatch(event);
					break;
				}
					
				case 5://账户在线中
				{
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_ERROR,"账户在线中");
					dispatch(event);
					break;
				}
					
				case 6://请重新创建账号
				{
					event = new ReceiveEvent(GameInitializeEvent.LOGIN_ERROR,"请注册账户");
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