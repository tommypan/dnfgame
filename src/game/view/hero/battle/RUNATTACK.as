package game.view.hero.battle
{
	import flash.display.MovieClip;
	
	import game.view.hero.BaseHero;
	
	import Qmang2D.utils.ClassManager;
	
	/**
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class RUNATTACK extends BaseHero
	{
		
		public function RUNATTACK()
		{
			mc = ClassManager.createDisplayObjectInstance("RUNATTACK_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
		}
		
	}
}