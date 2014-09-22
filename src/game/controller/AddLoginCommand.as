package game.controller
{
	
	import game.event.GameInitializeEvent;
	import game.event.ReceiveEvent;
	import game.model.ChapterEnemyConfigModel;
	import game.model.ChapterEnemyModel;
	import game.model.EnemyModel;
	import game.model.HeroModel;
	import game.model.RewardModel;
	import game.model.SkillModel;
	import game.model.server.Calculate;
	import game.service.RecieveRegisterCommand;
	import game.service.SocketService;
	import game.view.mediator.LoginSceneMediator;
	import game.view.scene.LoginScene;
	
	import Qmang2D.utils.StageProxy;
	
	import org.robotlegs.mvcs.Command;
	
	public class AddLoginCommand extends Command
	{
		[Inject]
		public var socket :SocketService;
		
		public function AddLoginCommand()
		{
		}
		
		override public function execute():void
		{
			addModel();
			
			commandMap.mapEvent(GameInitializeEvent.LOGIN_SUCESS, AddMapSceneCommand,null,true);
			commandMap.mapEvent(GameInitializeEvent.RECEIVE_REGISTER_RESULT, RecieveRegisterCommand,ReceiveEvent);
			mediatorMap.mapView(LoginScene,LoginSceneMediator);
			
			var loginScene :LoginScene = new LoginScene();
			contextView.addChild(loginScene);
			loginScene.x = StageProxy.stageWidth()/2 - 100;
			loginScene.y = StageProxy.stageHeight()/2 - 70;
			
			
		}
		
		private function addModel():void
		{
			//注入敌军model
			injector.mapSingleton(EnemyModel);
			
			//注入英雄model
			injector.mapSingleton(HeroModel);
			
			//注入关卡配置
			injector.mapSingleton(ChapterEnemyConfigModel);
			
			//注入技能配置
			injector.mapSingleton(SkillModel);
			
			//
			injector.mapSingleton(Calculate);
			
			//注入过关奖励配置
			injector.mapSingleton(RewardModel);
			
			//每关的敌人配置以及敌人Vo属性
			injector.mapSingleton(ChapterEnemyModel);
		}
		
		
	}
}