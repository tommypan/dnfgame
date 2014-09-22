package Qmang2D.protocol
{
	import flash.utils.Dictionary;
	
	/**
	 * 声音素材swf资源路径与类的绑定
	 *@author as3Lover_ph
	 *@date 2013-2-16
	 */
	public class SoundBind
	{
		private static var _soundBindDic :Dictionary = new Dictionary();
		
	
		/**
		 *音效素材绑定 
		 * id为键，值为资源地址
		 */		
		public static function bind():void
		{
			//打赢了的背景音乐
			_soundBindDic["KO"] = "assets/common.swf";
			//不错
			_soundBindDic["sdAttack1"] = "assets/common.swf";
			//不错
			_soundBindDic["sdAttack2"] = "assets/common.swf";
			
			//不错，一边叫，一般打
			_soundBindDic["sdAttack3"] = "assets/common.swf";
			
			_soundBindDic["click"] = "assets/bgSound.swf";
			
			_soundBindDic["levelUp"] = "assets/bgSound.swf";
			
			_soundBindDic["move"] = "assets/bgSound.swf";
			
			
			//战斗场景的音乐播放
			_soundBindDic["battleBG"] = "assets/bgSound.swf";
			//世界地图的音乐播放
			_soundBindDic["worldBG"] = "assets/bgSound.swf";
			
		
			// and others...........
		}
		
		/**
		 *储存声音字典 只读 
		 * @return 
		 * 
		 */		
		public static function get soundBindDic():Dictionary
		{
			return _soundBindDic;
		}
		
	}
}