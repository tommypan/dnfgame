package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Enemy102 extends BaseEnemy
	{
		public function Enemy102()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E2") as MovieClip;
			addChild(_mc);
		}
	}
}