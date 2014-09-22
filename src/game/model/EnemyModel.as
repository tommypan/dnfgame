package game.model
{
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.VersionManager;
	
	import com.deng.fzip.FZip;
	import com.deng.fzip.FZipFile;
	
	import game.model.vo.EnemyVo;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 存储从配置文件读取的敌军种类，攻击力等属性配置
	 *@author aser_ph
	 *@date 2013-5-5
	 */
	public class EnemyModel extends Actor
	{
		/**
		 *敌军不同种类具有不同的属性值所在的数据结构集合 
		 */		
		public var _enemyVoKinds :Vector.<EnemyVo>;
		
		private var _root :String = "res/common/";
		
		
		public function EnemyModel()
		{
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root+"enemy.dnf"),init)
//			LoaderManager.getInstance().getXml(_root+"enemy.xml",init)
		}
		
		/**
		 *初始化 
		 * 
		 */		
		private function init(xmlZip:FZip/*xml:XML*/):void
		{
			var file :FZipFile = xmlZip.getFileByName("enemy.xml");
			var xml :XML = new XML(file.content);
			_enemyVoKinds = new Vector.<EnemyVo>();
			
			for each (var i:XML in xml.item) 
			{
				
				var obj :Object = new Object();
				
				obj.id             = i.@id;
				obj.level         = i.level
				obj.hp           = i.hp
				obj.describe = i.describe
				obj.speedX = i.speedX
				obj.speedY = i.speedY
				obj.iq = i.iq
				obj.skills = i.skills
				obj.defenceNum = i.defenceNum
				obj.attackHeight = i.attackHeight
				
				
				var enemyVo :EnemyVo = new EnemyVo(obj);
				
				_enemyVoKinds.push(enemyVo);
			}
			
		}
		
		
		
	}
}