package game.controller
{
	import game.model.DNFmodel;
	import game.event.MissionEvent;
	
	import org.robotlegs.mvcs.Command;
	
	/**
	 * 隐藏世界地图
	 * 
	 */	
	public class MissionCommand extends Command
	{
		[Inject]
		public var missionEvent:MissionEvent;
		
		[Inject]
		public var dnfModel:DNFmodel;
		
		public function MissionCommand()
		{
		}
		
		override public function execute():void{
			trace(" at MissionCommand");
			
			//隐藏世界地图
			var e:MissionEvent = new MissionEvent(MissionEvent.GOTO_NUM_MISSION_FOR_MEDIATOR);
			dispatch(e);
		}
		
	}
}