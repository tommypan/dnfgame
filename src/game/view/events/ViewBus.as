package game.view.events
{
	import flash.events.EventDispatcher;

	/**
	 * View主线，view层的通信，有时候两个view层之间通信，不涉及到数据和大框架的改变，这个时候可以采用轻量级的viewBus进行通信
	 *@author as3Lover_ph
	 *@date 2013-4-7
	 */
	public class ViewBus extends EventDispatcher
	{
		public static var instance :ViewBus;
		
		private static var _allowInatnce :Boolean;
		
		/**
		 *怪物击中英雄 
		 */		
		//public static const ENEMY_HIT_HERO :String = "enemyHitHero";
		
		public function ViewBus()
		{
			
		}
		
		/**
		 *注册单例，使用时直接使用 instance属性
		 * 
		 */		
		public static function registerInstance():void
		{
			if(!_allowInatnce)
			{
				instance = new ViewBus();
				_allowInatnce = true;
			}
		}
		
	}
}
