package game.controller
{
	import game.event.GameInitializeEvent;
	import game.event.MissionEvent;
	import game.event.ReceiveEvent;
	import game.model.DNFmodel;
	import game.model.HeroModel;
	import game.service.RecieveHeroDataCommand;
	import game.service.SocketService;
	import game.view.mediator.BattleMediator;
	import game.view.mediator.MapSceneMediator;
	import game.view.scene.BattleScene;
	import game.view.scene.MapScene;
	
	import Qmang2D.debug.console.Test;
	
	import org.robotlegs.mvcs.Command;
	
	/** 
	 * 加载世界地图主场景命令
	 * 
	 */
	public class AddMapSceneCommand extends Command
	{
		[Inject]
		public var dnfModel:DNFmodel;
		
		[Inject]
		public var socket :SocketService;
		
		[Inject]
		public var heroModel :HeroModel;
		
		public function AddMapSceneCommand()
		{
		}
		
		override public function execute():void
		{
			
			addListener();
			
//			sendJson();
			
			Test.traceByShowText("进入地图主界面", "mainline");
			mediatorMap.mapView(MapScene, MapSceneMediator);
			trace(dnfModel.getPassNumOfMission());
			
			//获得cookie保存的关卡数
			var mapScene:MapScene = new MapScene(dnfModel.getPassNumOfMission()+1);
			contextView.addChild(mapScene); 
			mapScene.x = -160;
			mapScene.y = -50;
			
			mediatorMap.mapView(BattleScene, BattleMediator);
			
			//获得cookie保存的关卡数
			//todo 可以这样搞？
			var fightScene:BattleScene = new BattleScene();
			contextView.addChild(fightScene); 
			fightScene.visible = false;
			
			//			Fps.setup(contextView);
			//			Fps.visible = true;
			
			
		}
		
		private function sendJson():void
		{
			//2 1发送玩家信息请求
			var obj :Object = {};
			obj.id = heroModel.userName;
			socket.sendJSON(obj,2,1);
		}		
		
		
		/**
		 *添加进入主场景的 相应面板打开的映射
		 * 
		 */		
		private function addListener():void
		{
			//映射 
			commandMap.mapEvent(MissionEvent.GOTO_NUM_MISSION_FOR_COMMAND, EnterBattleCommand, MissionEvent);
			
			//映射 
			commandMap.mapEvent(MissionEvent.GOTO_NUM_MISSION_FOR_COMMAND, MissionCommand, MissionEvent);
			
			//映射 将世界地图显示在屏幕上
			commandMap.mapEvent(MissionEvent.GOTO_MAP_SCENE_FOR_COMMAND, GotoMapSceneCommand, MissionEvent);
			
			//从后端接受到数据
			commandMap.mapEvent(GameInitializeEvent.RECEIVE_BASIC_INFO, RecieveHeroDataCommand,ReceiveEvent,true);
			
		}
		
	}
}