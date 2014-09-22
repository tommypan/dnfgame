package game.controller
{
	import game.event.MissionEvent;
	import game.model.ChapterEnemyModel;
	import game.model.DNFmodel;
	import game.model.HeroModel;
	
	import org.robotlegs.mvcs.Command;

	public class GotoMapSceneCommand extends Command
	{
		[Inject]
		public var dnfModel:DNFmodel;
		
		[Inject]
		public var chapterEnemyModel :ChapterEnemyModel;
		
		[Inject]
		public var heroModel :HeroModel;
		
		public function GotoMapSceneCommand()
		{
		}
		
		override public function execute():void
		{
			trace("jinRu 世界地图场景");
			var evt:MissionEvent = new MissionEvent(MissionEvent.GOTO_MAP_SCENE_FOR_MEDIATOR);
			evt.currentMissionNum = dnfModel.getPassNumOfMission();
			dispatch(evt);
			
			
			//清空所有数据
			chapterEnemyModel.removeAll();
			
			heroModel.updateProperties()
		}
	}
}