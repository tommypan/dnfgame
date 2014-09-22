package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss104 extends BaseBoss
	{
		public function Boss104()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS4") as MovieClip;
			addChild(_mc);
		}
	}
}