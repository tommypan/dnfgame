package game.view.hero.battle
{
	import flash.display.MovieClip;
	
	import game.view.hero.BaseHero;
	
	import Qmang2D.utils.ClassManager;
	
	/**
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class EFFECT1 extends BaseHero
	{
		
		
		public function EFFECT1()
		{
			mc = ClassManager.createDisplayObjectInstance("EFFECT1_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
		}
		
	}
}