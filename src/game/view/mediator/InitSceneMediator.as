package game.view.mediator
{
	import flash.events.Event;
	
	import game.event.GameInitializeEvent;
	import game.service.SocketService;
	import game.view.scene.InitScene;
	
	import org.robotlegs.mvcs.Mediator;

	/** 
	 * 初始化场景中介
	 * 
	 * @author pengbinke
	 * <p> 2013-3-21 下午2:06:33
	 */
	public class InitSceneMediator extends Mediator
	{
		[Inject]
		public var initScene :InitScene;
		
		[Inject]
		public var socket :SocketService;
		
		public function InitSceneMediator()
		{
		}
		
		override public function onRegister():void
		{
			
			addViewListener(GameInitializeEvent.READY, onSendEnterGame, Event);
		}
		
		override public function onRemove():void
		{
			removeViewListener(GameInitializeEvent.READY, onSendEnterGame, Event);
		}
		
		private function onSendEnterGame(e:Event):void
		{
			dispatch(e);
		}
	}
}