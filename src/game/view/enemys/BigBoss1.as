package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class BigBoss1 extends BaseBoss
	{
		public function BigBoss1()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BIGBOSS1") as MovieClip;
			addChild(_mc);
		}
		public function attack3():void{
			_mc.gotoAndStop(9);
		}
	}
}