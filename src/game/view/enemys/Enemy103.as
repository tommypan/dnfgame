package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy103 extends BaseEnemy
	{
		public function Enemy103()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E3") as MovieClip;
			addChild(_mc);
		}
	}
}