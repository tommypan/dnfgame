package game.event
{
	import flash.events.Event;

	/**
	 * 关卡相关事件
	 * @author liYang
	 * 
	 */	
	public class MissionEvent extends Event
	{
		/**
		 *点击的时候 存储点击的关卡数 
		 */
		public var currentMissionNum:int;
		
		/**用户点击的时候执行 跳转到某一关 View*/
		public static const GOTO_NUM_MISSION:String = "gotoNumMission";
		/**用户点击的时候执行 跳转到某一关 command*/
		public static const GOTO_NUM_MISSION_FOR_COMMAND:String = "gotoNumMissionForCommand";
		/**用户点击的时候执行 跳转到某一关 mediator*/
		public static const GOTO_NUM_MISSION_FOR_MEDIATOR:String = "gotoNumMissionForMediator";
		
		public static const GOTO_NUM_FIGHT_SCENE:String = "gotoNumFightScene";
		
		/**下一关  view*/		
		public static const GOTO_NEXT_MISSION:String = "gotoNextMission";
		/**下一关 Mediator*/
		public static const GOTO_NEXT_MISSION_FOR_MEDIATOR:String = "gotoNextMissionForMediator";
		/**下一关 Command*/
		public static const GOTO_NEXT_MISSION_FOR_COMMAND:String = "gotoNextMissionForCommand";
		
		/**点击世界的时候dingdinganniu  进入世界地图*/
		public static const GOTO_MAP_SCENE:String = "gotoMapScene";
		/**点击世界的时候  进入世界地图*/
		public static const GOTO_MAP_SCENE_FOR_COMMAND:String = "gotoMapSceneForCommand";
		/**点击世界的时候  进入世界地图*/
		public static const GOTO_MAP_SCENE_FOR_MEDIATOR:String = "gotoMapSceneForMediator";
		public function MissionEvent(type:String)
		{
			super(type);
		}
	}
}