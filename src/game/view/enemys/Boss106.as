package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss106 extends BaseBoss
	{
		public function Boss106()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS6") as MovieClip;
			addChild(_mc);
		}
	}
}