package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy108 extends BaseEnemy
	{
		public function Enemy108()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E8") as MovieClip;
			addChild(_mc);
		}
	}
}