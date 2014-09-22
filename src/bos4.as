package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import game.GameContext;
	
	import Qmang2D.utils.CloneObject;
	
	[SWF(backgroundColor="#000000")]
	public class bos4 extends Sprite
	{
		private var context:GameContext;
		
		public function bos4()
		{
			if(stage==null) this.addEventListener(Event.ADDED_TO_STAGE,init1);
			else  init2();
			
		}
		
		private function init1(e:Event):void
		{
			init2();
		}
		
		private function init2():void
		{
			context = new GameContext(this.parent);
		}
		
		
	}
}

