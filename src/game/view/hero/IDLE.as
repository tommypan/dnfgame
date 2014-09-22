package game.view.hero
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	/**
	 * 站起耍酷
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class IDLE extends BaseHero
	{

		private var bitmap:Bitmap;
		
		public function IDLE()
		{
			mc = ClassManager.createDisplayObjectInstance("IDLE_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
			bitmap = new Bitmap(ClassManager.createBitmapDataInstance("bdShadow"));
			addChild(bitmap);
			bitmap.x = -35;
		}
		
	}
}