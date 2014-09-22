package game.view.hero
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import game.view.ILiving;
	
	import Qmang2D.utils.ClassManager;

	/**
	 *@author aser_ph
	 *@date 2013-5-9
	 */
	public class BaseHero extends Sprite implements ILiving
	{
		public var mc:MovieClip;
		
		public function BaseHero()
		{
			var bitmap :Bitmap = new Bitmap(ClassManager.createBitmapDataInstance("Shader"));
			addChild(bitmap);
			bitmap.x = -70;
			bitmap.y = -20;
		}
		
		public function dispose():void
		{
			mc.stop();
		}
	}
}