package game.controller
{
	import flash.events.Event;
	
	import game.event.GameInitializeEvent;
	import game.model.DNFmodel;
	import game.service.SocketService;
	import game.view.mediator.InitSceneMediator;
	import game.view.scene.InitScene;
	
	import Qmang2D.debug.console.Test;
	
	import org.robotlegs.mvcs.Command;
	
	/** 
	 * 进入游戏初始化，加载资源控制器
	 */
	public class InitCommand extends Command
	{
		[Inject]
		public var socketServer :SocketService;
		
		public function InitCommand()
		{
		}
		
		override public function execute():void
		{
			//1 1玩家登陆请求
			//			var obj :Object = {};
			//			//obj.zhangong = 200;
			//			//obj.level = 2;
			//			//obj.yuanbao = 2;
			//			obj.pwd = "tommypan2012";
			//			obj.id = "ph";
			//			socketServer.sendJSON(obj,1,1);
			
			
			//2 2发送玩家信息存储
			//			var obj :Object = {};
			//			obj.id = "nj";
			//			obj.yuanbao = 200;
			//			obj.level = 10;
			//			obj.zhangong = 3000;
			//			obj.money = 20;
			//			socketServer.sendJSON(obj,2,2);
			
			
			//监听到加载完成做两件事
			commandMap.mapEvent(GameInitializeEvent.READY, RemoveInitSceneCommand, Event, true);
			commandMap.mapEvent(GameInitializeEvent.READY, AddLoginCommand, Event, true);
			Test.traceByShowText("进入初始化资源加载界面", "mainline");
			mediatorMap.mapView(InitScene, InitSceneMediator);
			
			contextView.addChild(new InitScene());
			
		}
		
		
		
	}
}