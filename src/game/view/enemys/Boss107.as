package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class Boss107 extends BaseBoss
	{
		public function Boss107()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS7") as MovieClip;
			addChild(_mc);
		}
	}
}