package game.model.server
{
	import game.model.SkillModel;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 数据计算，暂时负责类似于后端数据计算功能
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class Calculate extends Actor
	{
		[Inject]
		public var skillModel :SkillModel;
		
		public function Calculate()
		{
		}
		
		/**
		 * 
		 * @param skillLevel 技能伤害等级 0到10
		 * @param hitArea 技能伤害面积值 0到10
		 * @param defence 被攻击对象防御值 0到10
		 * @return 被攻击对象血量减小值
		 * 
		 */		
		public  function calculateHit(skillLevel:*,hitArea:int,defence:int):int
		{
			var skillNum :int;
			if(skillLevel is String)
			{
				if(skillLevel == 'j')
				{
					skillNum = skillModel.jSkillVo.damage;
					
				}else if(skillLevel == 'h'){
					
					skillNum = skillModel.hSkillVo.damage;
					
				}else if(skillLevel == 'l'){
					
					skillNum = skillModel.lSkillVo.damage;
					
				}else if(skillLevel == 'u'){
					
					skillNum = skillModel.uSkillVo.damage;
					
				}else if(skillLevel == 'i'){
					
					skillNum = skillModel.iSkillVo.damage;
					
				}else if(skillLevel == 'o'){
					
					skillNum = skillModel.oSkillVo.damage;
					
				}
				
			}else{
				(skillLevel < 0) && (skillLevel = 0);
				(skillLevel > 10) && (skillLevel = 10);
				skillNum = skillLevel;
			}
			
			
			(hitArea < 0) && (hitArea = 0);
			(hitArea > 10) && (hitArea = 10);
			
			(defence < 0) && (defence = 0);
			(defence > 10) && (defence = 10);
			
			var lucky :int = Math.random() * 10;
			var loseHp :int = lucky * skillNum * hitArea * (defence/10) + 25;
			
			return loseHp;
		}
		
		
		/**
		 * 计算战斗结果
		 * @return 
		 * 
		 */		
		public function calculateBattleResult():Object
		{
			var obj :Object = new Object();
			return obj;
		}
		
		
	}
}