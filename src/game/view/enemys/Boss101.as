package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss101 extends BaseBoss
	{
		public function Boss101()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS1") as MovieClip;
			addChild(_mc);
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			removeChild(_mc);
			_mc.stop();
		}
		
		
	}
}