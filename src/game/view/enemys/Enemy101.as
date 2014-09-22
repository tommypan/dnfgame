package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Enemy101 extends BaseEnemy
	{
		public function Enemy101()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E1") as MovieClip;
			addChild(_mc);
		}
	}
}