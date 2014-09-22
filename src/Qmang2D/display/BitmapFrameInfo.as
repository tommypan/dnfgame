package  Qmang2D.display 
{
	import Qmang2D.Qmang2D;
	import Qmang2D.cacher.SmartSourceCacher;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	use namespace Qmang2D;
	
	/**
	 * 位图帧基本信息
	 * @author as3Lover_ph
	 *@date 2013-1-25
	 */
	public class BitmapFrameInfo
	{
		/**
		 * x轴偏移
		 */
		Qmang2D var x:Number;
		
		/**
		 * y轴偏移
		 */
		Qmang2D var y:Number;
		
		/**
		 * 位图数据
		 */
		Qmang2D var bitmapData:BitmapData;
		
		
	}
}