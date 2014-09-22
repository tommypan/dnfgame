package game.model
{
	
	import game.model.vo.EnemyVo;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 进行匹配后(通过id和level进行匹配)每一关敌人详细信息配置Model
	 *@author aser_ph
	 *@date 2013-5-6
	 */
	public class ChapterEnemyModel extends Actor
	{
		/**进行匹配后(通过id和level进行匹配)每一关敌人详细信息配置*/
		public var enemyChapterVos :Vector.<EnemyVo> = new Vector.<EnemyVo>();
		
		public function ChapterEnemyModel()
		{
			
		}
		
		/**
		 * 增加一个EnemyVo
		 * @param $enemyVo
		 * 
		 */		
		public function addEnemy($enemyVo :EnemyVo):void
		{
			var object :Object = new Object();
			object.x = $enemyVo.x;
			object.y = $enemyVo.y;
			object.id	= $enemyVo.id;
			object.level   = $enemyVo.level;
			object.scene = $enemyVo.scene;
			
			
			object.hp      = $enemyVo.hp;
			object.describe= $enemyVo.describe;
			object.speedX   = $enemyVo.speedX;
			object.speedY = $enemyVo.speedY;
			object.iq		= $enemyVo.iq;
			//skills	= $object.skills;
			object.defenceNum = $enemyVo.defenceNum;
			object.attackHeight = $enemyVo.attackHeight;
			
			var enemyVo :EnemyVo = new EnemyVo(object);
			this.enemyChapterVos.push(enemyVo);
		}
		
		/**
		 * 根据id索引移除一个EnemyVo
		 * @param id索引
		 * 
		 */		
		public function removeEnemy(id:String):void
		{
			for each (var enemyVo:EnemyVo in EnemyVo) 
			{
				if(enemyVo.id == id)
				{
					enemyChapterVos.splice(enemyChapterVos.indexOf(enemyVo),1);
				}
			}
			
		}
		
		/**
		 * 清理所有EnemyChapterVo
		 * 
		 */		
		public function removeAll():void
		{
			var len :int =  enemyChapterVos.length;
			for (var i:int = 0; i < len; i++) 
			{
				enemyChapterVos.pop();
			}
			
		}
		
		/**
		 * 根据索引得到EnemyVo
		 * @param id索引
		 * @return 
		 * 
		 */		
		public function getEnemyChapterVo_id(id:String):EnemyVo
		{
			for each(var enemyVo:EnemyVo in enemyChapterVos)
			{
				if(enemyVo.id == id)
				{
					return enemyVo;
				}
			}
			return null;
		}
		
		/**
		 * 遍历返回每个EnemyChapterVo属性
		 * @return EnemyChapterVo
		 * 
		 */		
		public function getEnemyChapterVo():EnemyVo
		{
			for each(var enemyVo:EnemyVo in enemyChapterVos)
			{
				return enemyVo;
			}
			return null;
		}
		
		
		/**
		 *获得敌军数量 
		 * @return 敌军数量 
		 * 
		 */		
		public function getLength():int
		{
			return enemyChapterVos.length;
		}
		
		
	}
}