package game.model
{
	import com.deng.fzip.FZip;
	import com.deng.fzip.FZipFile;
	
	import game.model.vo.SkillVo;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.VersionManager;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 *@author aser_ph
	 *@date 2013-5-16
	 */
	public class SkillModel extends Actor
	{
		private var _root :String = "res/common/";
		
		/**
		 *j技能
		 */		
		public var jSkillVo :SkillVo;
		
		/**
		 *h技能
		 */		
		public var hSkillVo :SkillVo;
		
		/**
		 *l技能
		 */		
		public var lSkillVo :SkillVo;
		
		/**
		 *u技能
		 */		
		public var uSkillVo :SkillVo;
		
		/**
		 *i技能
		 */		
		public var iSkillVo :SkillVo;
		
		/**
		 *o技能
		 */		
		public var oSkillVo :SkillVo;
		
		public function SkillModel()
		{
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root+"skill.dnf"),skillInit);
		}
		
		private function skillInit(xmlFile :FZip/*xml:XML*/):void
		{
			var file :FZipFile = xmlFile.getFileByName("skill.xml");
			var xml :XML = new XML(file.content);
			
			var object :Object;
			
			for each (var i:XML in xml.item) 
			{
				object = new Object();
				
				object.id = i.@id;
				object.damage = i.damage;
				object.reviveTime = i.reviveTime
				object.describe = i.describe;
				
				
				if(i.@id == 'J')
				{
					jSkillVo = new SkillVo(object);
				}else if(i.@id == 'H'){
					hSkillVo = new SkillVo(object);
				}else if(i.@id == 'L'){
					lSkillVo = new SkillVo(object);
				}else if(i.@id == 'U'){
					uSkillVo = new SkillVo(object);
				}else if(i.@id == 'I'){
					iSkillVo = new SkillVo(object);
				}else if(i.@id == 'O'){
					oSkillVo = new SkillVo(object);
				}
			}
			
		}
		
		
	}
}