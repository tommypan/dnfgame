package game.event
{
	import flash.events.Event;

	/**
	 * 战斗相关事件
	 * @author liYang
	 * 
	 */	
	public class FightEvent extends Event
	{
		public var currentMission:int;
		public static const GOTO_NUM_FIGHT_SCENE_FOR_MEDIATOR:String = "gotoNumFightForMediator";
		public function FightEvent(type:String)
		{
			super(type);
		}
	}
}