package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy110 extends BaseEnemy
	{
		public function Enemy110()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E10") as MovieClip;
			addChild(_mc);
		}
	}
}