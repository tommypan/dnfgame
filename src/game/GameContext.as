package game
{
	import flash.display.DisplayObjectContainer;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.registerClassAlias;
	
	import game.controller.InitCommand;
	import game.controller.StartupCommand;
	import game.model.DNFmodel;
	import game.model.vo.ChapterVo;
	import game.model.vo.EnemyVo;
	import game.model.vo.SkillVo;
	import game.service.SocketService;
	import game.view.events.ViewBus;
	
	import Qmang2D.debug.console.Test;
	import Qmang2D.utils.KeyBoardControl;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.protocol.LoadingScene;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;

	public class GameContext extends Context
	{
		public function GameContext(contextView:DisplayObjectContainer, autoStartup:Boolean=true )
		{
			super( contextView, autoStartup );
			contextView.stage.scaleMode = StageScaleMode.NO_SCALE;
			contextView.stage.align = StageAlign.TOP_LEFT;
			contextView.stage.quality = StageQuality.MEDIUM;  
			
		}
		
		
		override public function startup():void
		{
			registerInstance();
			
			injectModel();
			
//			Context创建完成后，单机测试，直接开启资源加载界面
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitCommand, ContextEvent, true);
			
			super.startup();
		}
		
		/**
		 *正式进入游戏之前的注册
		 * 
		 */		
		private function registerInstance():void
		{
			//注册测试输出器，在控制台和游戏中输出测试数据
			Test.registerShowText(contextView);
			
			//注册舞台，避免传参
			StageProxy.registed(contextView.stage);
			
			//加载场景进度条
			LoadingScene.registerInstance();
			
			//viewBus注册
			ViewBus.registerInstance();
			
			//键盘控制
			KeyBoardControl.register();
			
			//AMF编码，主要想装逼 (-_-)
			registerClassAlias("enemy",EnemyVo);
			registerClassAlias("chapter",ChapterVo);
			registerClassAlias("skill",SkillVo);
			
		}
		
		
		private function injectModel():void
		{
			//注入DNF的MODLE，注入后，只要使用正确，都可以马上执行
			injector.mapSingleton(DNFmodel);
			
			injector.mapSingleton(SocketService);
			
		}	
		
	}
}