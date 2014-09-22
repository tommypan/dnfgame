package game.model.vo
{
	/**
	 *@author aser_ph
	 *@date 2013-5-16
	 */
	public class RewardVo
	{
		/**
		 * 战斗胜利后的奖励金币
		 */		
		public var money :int;
		
		/**
		 *  战斗胜利后的奖励升级
		 */		
		public var levelUp :int;
		
		/**
		 *  战斗胜利后的奖励技能
		 */		
		public var skillId :String;
		
		//---------------------后端计算所得
		
		public function RewardVo($object :Object)
		{
			money = $object.money;
			levelUp = $object.levelUp;
			skillId = $object.skillId;
		}
		
	}
}