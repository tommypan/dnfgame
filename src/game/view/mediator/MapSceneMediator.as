package game.view.mediator
{
	import game.event.MissionEvent;
	import game.view.scene.BattleScene;
	import game.view.scene.MapScene;
	
	import org.robotlegs.mvcs.Mediator;

	public class MapSceneMediator extends Mediator
	{
		[Inject]
		public var mapScene:MapScene;
		
		public function MapSceneMediator()
		{
		}
		override public function onRegister():void
		{
			this.addContextListener(MissionEvent.GOTO_NUM_MISSION_FOR_MEDIATOR,mapVisible);
			//映射
			eventMap.mapListener(mapScene,MissionEvent.GOTO_NUM_MISSION,gotoMission,MissionEvent);
	
			//监听世界按钮的点击  然后进入世界地图场景
			this.addContextListener(MissionEvent.GOTO_MAP_SCENE_FOR_MEDIATOR,addMap);
		}
		
		private function addMap(e:MissionEvent):void
		{
			mapScene.visible = true;
			mapScene.addFire();
			mapScene.updateMission(e.currentMissionNum);
		}

		
		private function mapVisible(e:MissionEvent):void
		{
			mapScene.visible = false;
		}
		
		private function gotoMission(e:MissionEvent):void
		{
			trace("dispatch MissionEvent.GOTO_NUM_MISSION_FOR_COMMAND at midator",e.currentMissionNum);
			var evt:MissionEvent = new MissionEvent(MissionEvent.GOTO_NUM_MISSION_FOR_COMMAND);
			evt.currentMissionNum = e.currentMissionNum;
			dispatch(evt);
		}
	}
}