package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy111 extends BaseEnemy
	{
		public function Enemy111()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E11") as MovieClip;
			addChild(_mc);
		}
	}
}