package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy104 extends BaseEnemy
	{
		public function Enemy104()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E4") as MovieClip;
			addChild(_mc);
		}
	}
}