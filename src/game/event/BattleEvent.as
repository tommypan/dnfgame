package game.event
{
	import flash.events.Event;
	
	/**
	 * 类似于后端通信事件，携带战斗计算一些数据
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class BattleEvent extends Event
	{
		public var DATA :Object;
		
		public static const SEND_ENEMY_POS :String = "sendEnemyPos";
		
		/**
		 *检查碰撞 
		 */		
		public static const CHECK_HIT :String = "checkHit";
		
		/**
		 *发送英雄vo信息 
		 */		
		public static const SEND_HERO_VO :String = "sendHeroVo";
		
		/**
		 *增加影响技能 
		 */		
		public static const ADD_HERO_SKILL :String = "addBattleSkill";
		
		/**
		 *战斗胜利
		 */		
		public static const BATTLE_SUCCESS :String = "battleSuccess";
		
		/**
		 *战斗失败
		 */		
		public static const BATTLE_FAIL :String = "battleFail";
		
		/**
		 *清除英雄数据里面连续击打敌军次数
		 */		
		public static const CLEAR_HEROMODEL_HITCONTER :String = "clearHeroModelHitcounter";
		
		/**
		 *技能冷却隐藏技能
		 */		
		public static const HIDE_SKILL_CD :String = "hideSkillCd";
		
		/**
		 *技能冷却重置显示技能
		 */		
		public static const RESET_SKILL_CD :String = "resetSkillCd";
		
		
		public function BattleEvent(type:String,data:Object=null)
		{
			super(type);
			(data) && (DATA = data);
		}
	}
}