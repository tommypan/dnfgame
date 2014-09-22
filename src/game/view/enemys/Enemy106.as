package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy106 extends BaseEnemy
	{
		public function Enemy106()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E6") as MovieClip;
			addChild(_mc);
		}
	}
}