package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss105 extends BaseBoss
	{
		public function Boss105()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS5") as MovieClip;
			addChild(_mc);
		}
	}
}