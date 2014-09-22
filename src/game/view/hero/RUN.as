package game.view.hero
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	/**
	 * 快跑
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class RUN extends BaseHero
	{
		
		private var bitmap:Bitmap;
		
		public function RUN()
		{
			mc = ClassManager.createDisplayObjectInstance("RUN_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
			bitmap = new Bitmap(ClassManager.createBitmapDataInstance("bdShadow"));
			addChild(bitmap);
			bitmap.x = -35;
		}
		
	}
}