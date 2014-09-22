package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss108 extends BaseBoss
	{
		public function Boss108()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS8") as MovieClip;
			addChild(_mc);
		}
	}
}