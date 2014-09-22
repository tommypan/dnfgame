package game.view.hero.battle
{
	import flash.display.MovieClip;
	
	import game.view.hero.BaseHero;
	
	import Qmang2D.utils.ClassManager;

	/**
	 *@author aser_ph
	 *@date 2013-5-7
	 */
	public class DEAD extends BaseHero
	{
		
		public function DEAD()
		{
			mc = ClassManager.createDisplayObjectInstance("DEAD_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
		}
		
	}
}
