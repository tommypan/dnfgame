package game.model.vo
{
	/**
	 * 敌人VO属性
	 *@author aser_ph
	 *@date 2013-4-27
	 */
	public dynamic class EnemyVo
	{
		/**
		 *id 
		 */		
		public var id :String;
		
		/**
		 * 等級，根据读取的配置文件判断等级，从而确定下面属性值
		 */		
		public var level :int;
		
		
		/**
		 *所处场景 
		 */		
		public var scene :int;
		
		/**
		 * 血量
		 */		
		public var hp :int;
		
		/**
		 * 描述
		 */		
		public var describe :String;
		
		/**
		 * 速度X
		 */		
		public var speedX :int;
		
		
		/**
		 * 速度Y
		 */		
		public var speedY :int;
		
		/**
		 * 智商
		 */		
		public var iq :int;
		
		/**
		 * 技能
		 */		
		public var skills :Array;
		
		/**
		 * 防御值
		 */		
		public var defenceNum :int;
		
		/**
		 *攻击范围（主要指竖向） 
		 */		
		public var attackHeight :int;
		
		/**
		 * 初始x坐标，动态添加
		 */		
		public var x :int;
		
		/**
		 * 初始y坐标，动态添加
		 */		
		public var y :int;
		
		/**
		 * 被击打的次数
		 * */
		public var hitCounter :int;
		
		public var flyCounter :int;
		
		public function EnemyVo($object :Object)
		{
			
			if( $object.x)x = $object.x;
			if( $object.y)y = $object.y;
			id	= $object.id;
			level   = $object.level;
			
			scene = $object.scene;
			hp      = $object.hp;
			describe= $object.describe;
			speedX   = $object.speedX;
			speedY = $object.speedY;
			iq		= $object.iq;
			//skills	= $object.skills;
			defenceNum = $object.defenceNum;
			attackHeight = $object.attackHeight;
			
		}
		
		
	}
}