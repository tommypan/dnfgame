package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy113 extends BaseEnemy
	{
		public function Enemy113()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E13") as MovieClip;
			addChild(_mc);
		}
	}
}