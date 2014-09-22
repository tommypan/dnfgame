package game.controller
{
	import game.event.BattleEvent;
	import game.event.FightEvent;
	import game.event.MissionEvent;
	import game.model.ChapterEnemyConfigModel;
	import game.model.ChapterEnemyModel;
	import game.model.DNFmodel;
	import game.model.EnemyModel;
	import game.model.HeroModel;
	import game.model.vo.ChapterVo;
	import game.model.vo.EnemyVo;
	
	import Qmang2D.ui.ChangeViewVo;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * 读model里面的数据，然后进入战斗场景
	 */	
	public class EnterBattleCommand extends Command
	{
		[Inject]
		public var dnfModel:DNFmodel;
		
		[Inject]
		public var enemyModel :EnemyModel;
		
		[Inject]
		public var heroModel :HeroModel;
		
		[Inject]
		public var chapterModel :ChapterEnemyConfigModel;
		
		[Inject]
		public var chapterEnemyModel :ChapterEnemyModel;
		
		[Inject]
		public var missionEvent :MissionEvent;
		
		public function EnterBattleCommand()
		{
		}
		
		override public function execute():void
		{
			var chapterNum :int = missionEvent.currentMissionNum;
			trace("chapterNum",chapterNum);
			dnfModel.setCurrentMission(missionEvent.currentMissionNum);
			
			var chapterEnemyCfgs1 :Vector.<ChapterVo> = chapterModel.chapterEnemyCfgs[chapterNum-1];
			
			var chapterModelLen:uint = chapterEnemyCfgs1.length;
			var enemyModelLen :uint = enemyModel._enemyVoKinds.length;
			
			for (var i:int = 0; i < chapterModelLen; i++) 
			{
				var chapterVo :ChapterVo = chapterEnemyCfgs1[i];
				
				for (var j:int = 0; j < enemyModelLen; j++) 
				{
					var enemyVo :EnemyVo = enemyModel._enemyVoKinds[j];
					
					if(chapterVo.id == enemyVo.id && chapterVo.level == enemyVo.level)
					{
						enemyVo.x = chapterVo.x;
						enemyVo.y = chapterVo.y;
						enemyVo.scene = chapterVo.scene;
						//trace("obj.x,obj.y",enemyModel._enemyVoKinds[j].x,enemyModel._enemyVoKinds[j].y);
						chapterEnemyModel.addEnemy(enemyVo);
					}
				}
			}
			
			//必须在下面
			var evt:FightEvent = new FightEvent(FightEvent.GOTO_NUM_FIGHT_SCENE_FOR_MEDIATOR);
			evt.currentMission = missionEvent.currentMissionNum;
			dispatch(evt);
			
			//heroModel.updateProperties();
		}
		
		
		
		
	}
}