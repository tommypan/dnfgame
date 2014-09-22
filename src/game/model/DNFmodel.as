package game.model
{
	
	import game.event.BattleEvent;
	import game.model.vo.ChapterVo;
	import game.view.scene.MapScene;
	
	import Qmang2D.cacher.Cookie;
	import Qmang2D.loader.LoaderManager;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 * 主要记录一些游戏关卡存储信息
	 * @author liYang
	 * 
	 */	
	public class DNFmodel extends Actor
	{
		/**目前的关卡数    从2开始。 2----9帧  分别是 1----8 关 */		
		private var currentMission:int = 1;
		
		/**通过的总的关卡数     一般都是用cookie存储 和获得。并且记录通过关卡的最多的数 */		
		private var passNumOfMission:int = 1;
		
		private var cookie:Cookie = new Cookie("MissionNum");
		
		private var _root :String = "assets/";

		public var chapter1EnemyPos:Vector.<ChapterVo>;
		
		
		public function DNFmodel()
		{
			//LoaderManager.getInstance().getBlurXml(_root+"chapter1/enemy.dnf",loadChapter);
		}
		
		/**
		 *获取目前的关卡数
		 * 从2开始。 2----9帧  分别是 1----8 关 
		 */	
		public function getCurrentMission():int
		{
			return currentMission;
		}
		
		/**
		 *设置目前的关卡数
		 * 从2开始。 2----9帧  分别是 1----8 关 
		 */	
		public function setCurrentMission(value:int):void
		{
			currentMission = value;
		}
		/**
		 *得到通过的总的关卡数 cookie
		 *一般都是用cookie存储 和获得。并且记录通过关卡的最多的数 
		 */
		public function getPassNumOfMission():int
		{
			if(cookie.getCookie("MissionNum"))
			{
				return cookie.getCookie("MissionNum") as int;
			}else{
				return passNumOfMission;
			}
		}
		
		
		/**
		 * 设置通过的总的关卡数
		 *一般都是用cookie存储 和获得。并且记录通过关卡的最多的数 
		 */
		public function setPassNumOfMission(value:int):void
		{
			cookie.setCookie("currentMission0",value);
			passNumOfMission = value;
		}
		
//		public function loadChapter(xmlZip:FZip):void
//		{
//			var drugFile :FZipFile = xmlZip.getFileByName("enemy.xml");
//			var xml :XML = new XML(drugFile.content);
//			
//			chapter1EnemyPos = new Vector.<ChapterVo>();
//			
//			for each (var enemy:XML in xml.enemy) 
//			{
//				if(enemy.@id == 1)
//				{
//					
//					//enemy.level;
//					var len :uint = enemy.num;
//					for (var i:int = 0; i < len; i++) 
//					{
//						var chapterVo :ChapterVo = new ChapterVo(1,enemy.location[i].@x,enemy.location[i].@y);
//						chapter1EnemyPos.push(chapterVo);
//					}
//					
//				}
//			}
//			
//			//var battleEvent :BattleEvent = new BattleEvent(BattleEvent.SEND_ENEMY_POS,array);
//			
//		}
//		
		
		
		
	}
}