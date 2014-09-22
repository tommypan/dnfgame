package game.model
{
	import com.deng.fzip.FZip;
	import com.deng.fzip.FZipFile;
	
	import game.model.vo.SkillVo;
	
	import Qmang2D.cacher.Cookie;
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.VersionManager;
	
	import org.robotlegs.mvcs.Actor;
	
	/**英雄VO属性
	 *@author aser_ph
	 *@date 2013-5-5
	 */
	public class HeroModel extends Actor
	{
		
		public var userName :String;
		
		/**
		 * 名字id
		 */		
		public var id :int;
		
		public var soundOpen :Boolean = true;
		
		/**
		 * 等級，根据读取的配置文件判断等级，从而确定下面属性值
		 */		
		public var level :int;
		
		/**
		 * 元宝 
		 */		
		public var yuanbao :int;
		
		/**
		 * 金钱
		 */		
		public var money :int;
		
		/**
		 *战功
		 */		
		public var zhangong :int;
		
		
		
		/**
		 *血量 
		 */		
		public var hp :int;
		
		/**
		 *描述 
		 */		
		public var describe :int;
		
		/**
		 *技能 
		 */		
		public var skills :Array;
		
		/**
		 * 速度X
		 */		
		public var speedX :int;
		
		/**
		 * 速度Y
		 */		
		public var speedY :int;
		
		/**
		 *跳跃高度 
		 */		
		public var jumpHeight :int;
		
		
		/**
		 *攻击范围（主要指竖向） 
		 */		
		public var attackHeight :int;
		
		/**
		 * 防御值
		 */		
		public var defenceNum :int;
		
		/**
		 *击打敌军的连续次数 
		 */		
		public var hitCounter :int;
		
		//todo--------------技能相关发布时要改回来
		public var isHEnable :Boolean = true;
		
		public var isLEnable :Boolean = true;
		
		public var isUEnable :Boolean = true;
		
		public var isIEnable :Boolean = true;
		
		public var isOEnable :Boolean = true;
		
		
		private var _root :String = "res/common/";
		
		private var _cookie :Cookie;
		
		public function HeroModel()
		{
			_cookie = new Cookie("hero");
			
			//			LoaderManager.getInstance().getBlurXml(_root+"skill.dnf",skillInit);
			//LoaderManager.getInstance().getXml(_root+"hero.xml",init);
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root+"hero.dnf"),init2);
		}
		
		public function init():void
		{
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root+"hero.dnf"),init2);
		}
		
		
		private function init2(xmlFile :FZip/*xml:XML*/):void
		{
			var file :FZipFile = xmlFile.getFileByName("hero.xml");
			var xml :XML = new XML(file.content);
			
			
			level = _cookie.getCookie("level") as int;
			(!level) && (level = 1);
			(level) >5 && (level = 5);
			
			yuanbao = _cookie.getCookie("yuanbao") as int;
			(!yuanbao) && (yuanbao = 20);
			
			zhangong = _cookie.getCookie("zhangong") as int;
			(!zhangong) && (zhangong = 100);
			
			money = _cookie.getCookie("money") as int;
			(!money) && (money = 100);
			
			var h :int = _cookie.getCookie("isHEnable") as int;
			(h==1) && (isHEnable = true);
			
			var l :int = _cookie.getCookie("isLEnable") as int;
			(l==1) && (isLEnable = true);
			
			var u :int = _cookie.getCookie("isUEnable") as int;
			(u==1) && (isUEnable = true);
			
			var i2 :int = _cookie.getCookie("isIEnable") as int;
			(i2==1) && (isIEnable = true);
			
			var o :int = _cookie.getCookie("isOEnable") as int;
			(o==1) && (isOEnable = true);
			
			//trace(level,yuanbao,zhangong,money,isUEnable,isIEnable);
			
			id = 1; 	//以后从cookie里面读取，现在先假设为1英雄，1等级
			//var file :FZipFile = xmlFile.getFileByName("hero.xml");
			//var xml :XML = new XML(file.content);
			
			var lev :int;
			(level >= 29) ?  lev = 29 :level = lev;
			
			for each (var i:XML in xml.item) 
			{
				
				if(id == i.@id && lev == i.level)
				{
					hp  = i.hp;
					describe = i.describe;
					speedX = i.speedX;
					speedY = i.speedY;
					jumpHeight	= i.jumpHeight;
					defenceNum = i.defenceNum;
					attackHeight = i.attackHeight;
					break;
				}
				
				
			}
		}
		
		/**
		 *升级后更新玩家属性 
		 * 
		 */		
		public function updateProperties():void
		{
			LoaderManager.getInstance().getXml(_root+"hero.xml",update);
		}
		
		private function update(xml:XML):void
		{
			id = 1; 	//以后从cookie里面读取，现在先假设为1英雄，1等级
			//var file :FZipFile = xmlFile.getFileByName("hero.xml");
			//var xml :XML = new XML(file.content);
			
			for each (var i:XML in xml.item) 
			{
				if(id == i.@id && level == i.level)
				{
					hp  = i.hp;
					describe = i.describe;
					speedX = i.speedX;
					speedY = i.speedY;
					jumpHeight	= i.jumpHeight;
					defenceNum = i.defenceNum;
					attackHeight = i.attackHeight;
					break;
				}
				
			}
			
			setCookie();
		}		
		
		private function setCookie():void
		{
			_cookie.setCookie("level",level);
			
			_cookie.setCookie("yuanbao",yuanbao);
			
			_cookie.setCookie("zhangong",zhangong);
			
			_cookie.setCookie("money",money);
			
			isHEnable == true && _cookie.setCookie("isHEnable",1);
			isLEnable == true && _cookie.setCookie("isLEnable",1);
			isUEnable == true && _cookie.setCookie("isUEnable",1);
			isIEnable == true && _cookie.setCookie("isIEnable",1);
			isOEnable == true && _cookie.setCookie("isOEnable",1);
		}		
		
		/**
		 *增加一个技能 
		 * @param id 技能id，如：h,l,u,i,o等
		 * 
		 */		
		public function addSkill(id :String):void
		{
			switch(id)
			{
				case 'h':
				{
					isHEnable = true;
					break;
				}
					
				case 'l':
				{
					isLEnable = true;
					break;
				}
					
				case 'u':
				{
					isUEnable = true;
					break;
				}
					
				case 'i':
				{
					isIEnable = true;
					break;
				}
					
				case 'o':
				{
					isOEnable = true;
					break;
				}
			}
		}
		
		
	}
}