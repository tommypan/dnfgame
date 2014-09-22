package game.model
{
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.VersionManager;
	
	import com.deng.fzip.FZip;
	import com.deng.fzip.FZipFile;
	
	import game.model.vo.ChapterVo;
	
	import org.robotlegs.mvcs.Actor;
	
	/**存储从enemyConfig读取出来的敌人配置
	 *@author aser_ph
	 *@date 2013-5-5
	 */
	public class ChapterEnemyConfigModel extends Actor
	{
		//todo 以后会融合在一起
		private var _root :String = "res/chapter/";
		
		public var chapterEnemyCfgs :Vector.<Vector.<ChapterVo>> = new Vector.<Vector.<ChapterVo>>();
		
		/**第一章敌军配置*/
		private var _chapterEnemyCfgs1 :Vector.<ChapterVo>;
		
		/**第二章敌军配置*/
		private var _chapterEnemyCfgs2 :Vector.<ChapterVo>;
		
		/**第三章敌军配置*/
		private var _chapterEnemyCfgs3 :Vector.<ChapterVo>;
		
		/**第四章敌军配置*/
		private var _chapterEnemyCfgs4 :Vector.<ChapterVo>;
		
		/**第五章敌军配置*/
		private var _chapterEnemyCfgs5 :Vector.<ChapterVo>;
		
		/**第六章敌军配置*/
		private var _chapterEnemyCfgs6 :Vector.<ChapterVo>;
		
		/**第七章敌军配置*/
		private var _chapterEnemyCfgs7 :Vector.<ChapterVo>;
		
		/**第八章敌军配置*/
		private var _chapterEnemyCfgs8 :Vector.<ChapterVo>;
		
		public function ChapterEnemyConfigModel()
		{
			LoaderManager.getInstance().getBlurXml(VersionManager.encode(_root+"enemyConfig.dnf"),init);
			//			LoaderManager.getInstance().getXml(_root+"enemyConfig.xml",init);
		}
		
		private function init(xmlFile :FZip/*xml:XML*/):void
		{
			var file :FZipFile = xmlFile.getFileByName("enemyConfig.xml");
			var xml :XML = new XML(file.content);
			
			_chapterEnemyCfgs1 = new  Vector.<ChapterVo>();
			_chapterEnemyCfgs2 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs3 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs4 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs5 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs6 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs7 = new Vector.<ChapterVo>();
			_chapterEnemyCfgs8 = new Vector.<ChapterVo>();
			chapterEnemyCfgs.push(_chapterEnemyCfgs1);
			chapterEnemyCfgs.push(_chapterEnemyCfgs2);
			chapterEnemyCfgs.push(_chapterEnemyCfgs3);
			chapterEnemyCfgs.push(_chapterEnemyCfgs4);
			chapterEnemyCfgs.push(_chapterEnemyCfgs5);
			chapterEnemyCfgs.push(_chapterEnemyCfgs6);
			chapterEnemyCfgs.push(_chapterEnemyCfgs7);
			chapterEnemyCfgs.push(_chapterEnemyCfgs8);
			
			for each (var i:XML in xml.chapter) 
			{
				
				for each (var j:XML in i.item) 
				{
					var obj :Object = new Object();
					
					obj.id             = j.@id;
					obj.level         = j.@level
					obj.x         = j.@x
					obj.y         = j.@y
					obj.scene     = j.@scene;
					trace(obj.scene);
					var chapter :ChapterVo = new ChapterVo(obj);
					
					if(i.@id == 1)
					{
						_chapterEnemyCfgs1.push(chapter);
						
					}
					if(i.@id == 2)  _chapterEnemyCfgs2.push(chapter);
					if(i.@id == 3)  _chapterEnemyCfgs3.push(chapter);
					if(i.@id == 4)	_chapterEnemyCfgs4.push(chapter);
					if(i.@id == 5)  _chapterEnemyCfgs5.push(chapter);
					if(i.@id == 6)  _chapterEnemyCfgs6.push(chapter);
					if(i.@id == 7)  _chapterEnemyCfgs7.push(chapter);
					if(i.@id == 8)  _chapterEnemyCfgs8.push(chapter);
				}
				
				
			}
		}
		
		
	}
}