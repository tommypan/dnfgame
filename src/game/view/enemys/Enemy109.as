package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class Enemy109 extends BaseEnemy
	{
		public function Enemy109()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("E9") as MovieClip;
			addChild(_mc);
			
		}
	}
}