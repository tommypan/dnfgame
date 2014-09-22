package game.view.hero.battle
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.view.ILiving;
	import game.view.hero.BaseHero;
	
	import Qmang2D.utils.ClassManager;

	/**
	 *@author aser_ph
	 *@date 2013-5-6
	 */
	public class BEATTACK extends BaseHero
	{
		
		public function BEATTACK()
		{
			mc = ClassManager.createDisplayObjectInstance("BEATTACK_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
		}
		
	}
}