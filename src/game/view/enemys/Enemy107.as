package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy107 extends BaseEnemy
	{
		public function Enemy107()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E7") as MovieClip;
			addChild(_mc);
		}
	}
}