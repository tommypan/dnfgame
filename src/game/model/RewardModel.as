package game.model
{
	import com.deng.fzip.FZip;
	import com.deng.fzip.FZipFile;
	
	import game.model.vo.RewardVo;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.VersionManager;
	
	import org.robotlegs.mvcs.Actor;

	/**
	 *@author aser_ph
	 *@date 2013-5-16
	 */
	public class RewardModel extends Actor
	{
		/**
		 *第一关的奖励vo信息 
		 */		
		public var reward1 :RewardVo;
		
		/**
		 *第二关的奖励vo信息 
		 */		
		public var reward2 :RewardVo;
		
		/**
		 *第三关的奖励vo信息 
		 */		
		public var reward3 :RewardVo;
		
		/**
		 *第四关的奖励vo信息 
		 */		
		public var reward4 :RewardVo;
		
		/**
		 *第五关的奖励vo信息 
		 */		
		public var reward5 :RewardVo;
		
		/**
		 *第六关的奖励vo信息 
		 */		
		public var reward6 :RewardVo;
		
		/**
		 *第七关的奖励vo信息 
		 */		
		public var reward7 :RewardVo;
		
		/**
		 *第八关的奖励vo信息 
		 */		
		public var reward8 :RewardVo;
		
		private var _root :String = "res/chapter/";
		
		public function RewardModel()
		{
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root + "rewardConfig.dnf"),initReward);
		}
		
		private function initReward(xmlFile :FZip/*xml :XML*/):void
		{
			var file :FZipFile = xmlFile.getFileByName("rewardConfig.xml");
			var xml :XML = new XML(file.content);
			
			var object :Object;
			
			for each (var i:XML in xml.item) 
			{
				object = new Object();
				
				object.money = i.money;
				object.skillId = i.skillId
				object.levelUp = i.levelUp;
				
				if(i.@id == 1)
				{
					reward1 = new RewardVo(object);
				}else if(i.@id == 2){
					reward2 = new RewardVo(object);
				}else if(i.@id == 3){
					reward3 = new RewardVo(object);
				}else if(i.@id == 4){
					reward4 = new RewardVo(object);
				}else if(i.@id == 5){
					reward5 = new RewardVo(object);
				}else if(i.@id == 6){
					reward6 = new RewardVo(object);
				}else if(i.@id == 7){
					reward7 = new RewardVo(object);
				}else if(i.@id == 8){
					reward8 = new RewardVo(object);
				}
				
			}
			
			
		}		
		
	}
}