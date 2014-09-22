package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy112 extends BaseEnemy
	{
		public function Enemy112()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E12") as MovieClip;
			addChild(_mc);
		}
	}
}