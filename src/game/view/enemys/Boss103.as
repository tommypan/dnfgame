package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss103 extends BaseBoss
	{
		public function Boss103()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS3") as MovieClip;
			addChild(_mc);
		}
	}
}