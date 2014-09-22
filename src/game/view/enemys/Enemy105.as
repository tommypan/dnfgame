package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy105 extends BaseEnemy
	{
		public function Enemy105()
		{
			_mc = ClassManager.createDisplayObjectInstance("E5") as MovieClip;
			addChild(_mc);
		}
	}
}