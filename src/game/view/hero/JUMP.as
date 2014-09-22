package game.view.hero
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	/**
	 * 跳起来耍
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class JUMP extends BaseHero
	{
		
		private var bitmap:Bitmap;
		
		public function JUMP()
		{
			mc = ClassManager.createDisplayObjectInstance("JUMP_h1") as MovieClip;
			mc.stop();
			addChild(mc);
			
			bitmap = new Bitmap(ClassManager.createBitmapDataInstance("bdShadow"));
			addChild(bitmap);
			bitmap.x = -35;
		}
		
	}
}