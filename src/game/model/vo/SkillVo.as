package game.model.vo
{
	/**
	 *@author aser_ph
	 *@date 2013-5-6
	 */
	public class SkillVo
	{
		/**
		 *id索引 
		 */		
		public var id :String;
		
		/**
		 *伤害值 
		 */		
		public var damage :int;
		
		/**
		 *技能冷却时间 
		 */		
		public var reviveTime :int;
		
		/**
		 *技能描述 
		 */		
		public var describe :String;
		
		
		public function SkillVo($object :Object)
		{
			id = $object.id;
			damage = $object.damage;
			reviveTime = $object.reviveTime;
			describe = $object.describe;
		}
		
	}
	
}