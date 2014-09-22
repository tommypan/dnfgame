package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class BigBoss2 extends BaseBoss
	{
		public function BigBoss2()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BIGBOSS2") as MovieClip;
			addChild(_mc);
		}
		public function attack3():void{
			_mc.gotoAndStop(9);
		}
	}
}