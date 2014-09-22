package game.view.scene
{
	import Qmang2D.display.BitmapMovie;
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.protocol.EnhancedProgressEvent;
	import Qmang2D.protocol.LoadingScene;
	import Qmang2D.protocol.VersionManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import game.event.GameInitializeEvent;
	
	/** 
	 * 初始化场景，进入游戏前，初始化游戏数据和资源场景
	 * 那些ui没有加载怎么显示上去的？？？
	 * <p> 2013-3-7 下午3:02:07
	 */
	public class InitScene extends Sprite
	{
		//animation
		private var _aRoot :String = "assets/";
		
		//config
		private var _cRoot :String = "res/";
		
		private var _loaderInstance :LoaderManager;
		
		private var teachArr:Array = ["walk","run","jump","attack","skillu","skilli","skillo","skillh","skilll","skillspace"];
		private var i:int = 0;
		private var attack:MovieClip;
		
		public function InitScene()
		{
			
			LoadingScene.instance.drawProgressBar(600,40);
			LoadingScene.instance.x = 300;
			LoadingScene.instance.y = 300;
			addChild(LoadingScene.instance);
			//var by :ByteArray = new ByteArray();
			//by.
			_loaderInstance = LoaderManager.getInstance();
			
			_loaderInstance.addEventListener(ProgressEvent.PROGRESS, onHandleProgress);
			_loaderInstance.getModualSwf(_aRoot+"map/teach11.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/teach12.swf",onC);
			_loaderInstance.getModualSwf(_aRoot+"map/rightUpBtn.swf");
			//			LoaderManager.getInstance().getBlurXml("assets/common/hero.xml",null,true);
			//			LoaderManager.getInstance().getBlurXml("assets/common/enemy.xml",null,true);
			//			LoaderManager.getInstance().getBlurXml("assets/chapter/enemyConfig.xml",null,true);
			_loaderInstance.getBlurXml(VersionManager.encode(_cRoot+"common/hero.dnf"),null,true);
			_loaderInstance.getBlurXml(VersionManager.encode(_cRoot+"common/enemy.dnf"),null,true);
			_loaderInstance.getBlurXml(VersionManager.encode(_cRoot+"common/skill.dnf"),null,true);
			_loaderInstance.getBlurXml(VersionManager.encode(_cRoot+"chapter/enemyConfig.dnf"),null,true);
			_loaderInstance.getBlurXml(VersionManager.encode(_cRoot+"chapter/rewardConfig.dnf"),null,true);
			_loaderInstance.getModualSwf(_aRoot+"map/mainScene.swf");
			
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap1.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap2.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap3.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap4.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap5.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap6.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap7.swf");
			_loaderInstance.getModualSwf(_aRoot+"map/BattleMap8.swf");
			_loaderInstance.getModualSwf(_aRoot+"hero/shader[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"battleResult.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/101.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/102.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/103.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/104.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/105.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/106.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/107.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/108.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/109.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/110.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/111.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/112.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/113.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/201.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/202.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/203.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/204.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/205.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/206.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/207.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/208.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/301.swf");
			_loaderInstance.getModualSwf(_aRoot+"enemy/302.swf");
			_loaderInstance.getMovieClip(_aRoot+"boss1.swf",new BitmapMovie(),true);
			_loaderInstance.getModualSwf(_aRoot+"login.swf");
			_loaderInstance.getModualSwf(_aRoot+"loginUI.swf");
			_loaderInstance.getModualSwf(_aRoot+"hero/5a[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"common.swf");
			_loaderInstance.getModualSwf(_aRoot+"hints.swf");
			_loaderInstance.getModualSwf(_aRoot+"hint.swf");
			_loaderInstance.getModualSwf(_aRoot+"map[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"zhanchuan[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"wushuang.swf");
			_loaderInstance.getModualSwf(_aRoot+"hero/5b[1].swf",onComplete);
		}
		
		private function onC():void
		{
			if(attack!=null){
				attack.stop();
				removeChild(attack);
				attack = null;
				TimerManager.getInstance().remove(onC);
			}
			
			if(i>=teachArr.length)
			{
				
				return;
			}
			
			attack = ClassManager.createDisplayObjectInstance(teachArr[i]) as MovieClip;
			addChild(attack);
			attack.x = 600;
			attack.y = 150;
			
			TimerManager.getInstance().add(1000,onC);
			i++;
		}
		
		private function onComplete():void
		{
			if(attack!=null)
			{
				attack.stop();
				removeChild(attack);
				TimerManager.getInstance().remove(onC);
				attack = null;
			}
			removeChild(LoadingScene.instance);
			LoaderManager.getInstance().removeEventListener(ProgressEvent.PROGRESS, onHandleProgress);
			dispatchEvent(new Event(GameInitializeEvent.READY));
		}
		
		protected function onHandleProgress(event:EnhancedProgressEvent):void
		{
			switch(event.resType)
			{
				case _aRoot+"map/rightUpBtn.swf":
					LoadingScene.instance.setContent("");
					LoadingScene.instance.update(1/43);
					break;
				
				case VersionManager.encode(_cRoot+"common/hero.dnf"):
					LoadingScene.instance.setContent("英雄配置");
					LoadingScene.instance.update(2/43);
					break;
				
				case VersionManager.encode(_cRoot+"common/enemy.dnf"):
					LoadingScene.instance.setContent("敌军配置");
					LoadingScene.instance.update(3/43);
					break;
				
				case VersionManager.encode(_cRoot+"common/skill.dnf"):
					LoadingScene.instance.setContent("技能配置");
					LoadingScene.instance.update(4/43);
					break;
				
				case VersionManager.encode(_cRoot+"chapter/enemyConfig.dnf"):
					LoadingScene.instance.setContent("关卡配置");
					LoadingScene.instance.update(5/43);
					break;
				
				case VersionManager.encode(_cRoot+"chapter/rewardConfig.dnf"):
					LoadingScene.instance.setContent("奖励配置");
					LoadingScene.instance.update(6/43);
					break;
				
				case _aRoot+"map/mainScene.swf":
					LoadingScene.instance.setContent("主场景资源");
					LoadingScene.instance.update(7/43);
					break;
				
				case _aRoot+"map/BattleMap1.swf":
					LoadingScene.instance.setContent("地图1资源");
					LoadingScene.instance.update(8/43);
					break;
				
				case _aRoot+"map/BattleMap2.swf":
					LoadingScene.instance.setContent("地图2资源");
					LoadingScene.instance.update(9/43);
					break;
				
				case _aRoot+"map/BattleMap3.swf":
					LoadingScene.instance.setContent("地图3资源");
					LoadingScene.instance.update(10/43);
					break;
				
				case _aRoot+"map/BattleMap4.swf":
					LoadingScene.instance.setContent("地图4资源");
					LoadingScene.instance.update(11/43);
					break;
				
				case _aRoot+"map/BattleMap5.swf":
					LoadingScene.instance.setContent("地图5资源");
					LoadingScene.instance.update(12/43);
					break;
				
				case _aRoot+"map/BattleMap6.swf":
					LoadingScene.instance.setContent("地图6资源");
					LoadingScene.instance.update(13/43);
					break;
				
				case _aRoot+"map/BattleMap7.swf":
					LoadingScene.instance.setContent("地图7资源");
					LoadingScene.instance.update(14/43);
					break;
				
				case _aRoot+"map/BattleMap8.swf":
					LoadingScene.instance.setContent("地图8资源");
					LoadingScene.instance.update(15/43);
					break;
				
				case _aRoot+"battleResult.swf":
					LoadingScene.instance.setContent("战斗结果资源");
					LoadingScene.instance.update(16/43);
					break;
				
				case _aRoot+"enemy/101.swf":
					LoadingScene.instance.setContent("敌军素材1资源");
					LoadingScene.instance.update(17/43);
					break;
				
				case _aRoot+"enemy/102.swf":
					LoadingScene.instance.setContent("敌军素材2资源");
					LoadingScene.instance.update(18/43);
					break;
				
				case _aRoot+"enemy/103.swf":
					LoadingScene.instance.setContent("敌军素材3资源");
					LoadingScene.instance.update(19/43);
					break;
				
				case _aRoot+"enemy/104.swf":
					LoadingScene.instance.setContent("敌军素材4资源");
					LoadingScene.instance.update(20/43);
					break;
				
				case _aRoot+"enemy/105.swf":
					LoadingScene.instance.setContent("敌军素材5资源");
					LoadingScene.instance.update(21/43);
					break;
				
				case _aRoot+"enemy/106.swf":
					LoadingScene.instance.setContent("敌军素材6资源");
					LoadingScene.instance.update(22/43);
					break;
				
				case _aRoot+"enemy/107.swf":
					LoadingScene.instance.setContent("敌军素材7资源");
					LoadingScene.instance.update(23/43);
					break;
				
				case _aRoot+"enemy/108.swf":
					LoadingScene.instance.setContent("敌军素材3资源");
					LoadingScene.instance.update(24/43);
					break;
				
				case _aRoot+"enemy/109.swf":
					LoadingScene.instance.setContent("敌军素材9资源");
					LoadingScene.instance.update(25/43);
					break;
				
				case _aRoot+"enemy/110.swf":
					LoadingScene.instance.setContent("敌军素材10资源");
					LoadingScene.instance.update(26/43);
					break;
				
				case _aRoot+"enemy/111.swf":
					LoadingScene.instance.setContent("敌军素材11资源");
					LoadingScene.instance.update(27/43);
					break;
				
				case _aRoot+"enemy/112.swf":
					LoadingScene.instance.setContent("敌军素材12资源");
					LoadingScene.instance.update(28/43);
					break;
				
				case _aRoot+"enemy/113.swf":
					LoadingScene.instance.setContent("敌军素材13资源");
					LoadingScene.instance.update(29/43);
					break;
				
				case _aRoot+"enemy/201.swf":
					LoadingScene.instance.setContent("敌军素材14资源");
					LoadingScene.instance.update(30/43);
					break;
				
				case _aRoot+"enemy/202.swf":
					LoadingScene.instance.setContent("敌军素材15资源");
					LoadingScene.instance.update(31/43);
					break;
				
				case _aRoot+"enemy/203.swf":
					LoadingScene.instance.setContent("敌军素材16资源");
					LoadingScene.instance.update(32/43);
					break;
				
				case _aRoot+"enemy/204.swf":
					LoadingScene.instance.setContent("敌军素材17资源");
					LoadingScene.instance.update(33/43);
					break;
				
				case _aRoot+"enemy/205.swf":
					LoadingScene.instance.setContent("敌军素材18资源");
					LoadingScene.instance.update(34/43);
					break;
				
				case _aRoot+"enemy/206.swf":
					LoadingScene.instance.setContent("敌军素材19资源");
					LoadingScene.instance.update(35/43);
					break;
				
				case _aRoot+"enemy/207.swf":
					LoadingScene.instance.setContent("敌军素材20资源");
					LoadingScene.instance.update(36/43);
					break;
				
				case _aRoot+"enemy/208.swf":
					LoadingScene.instance.setContent("敌军素材21资源");
					LoadingScene.instance.update(37/43);
					break;
				
				case _aRoot+"enemy/209.swf":
					LoadingScene.instance.setContent("敌军素材22资源");
					LoadingScene.instance.update(38/43);
					break;
				case _aRoot+"common.swf":
					LoadingScene.instance.setContent("公有资源");
					LoadingScene.instance.update(39/43);
					break;
				
				case _aRoot+"hint.swf":
					LoadingScene.instance.setContent("提示信息资源");
					LoadingScene.instance.update(40/43);
					break;
				
				case _aRoot+"zhanchuan[1].swf":
					LoadingScene.instance.setContent("特效资源");
					LoadingScene.instance.update(41/43);
					break;
				
				case _aRoot+"wushuang.swf":
					LoadingScene.instance.setContent("提示信息资源2");
					LoadingScene.instance.update(42/43);
					break;
				
				case _aRoot+"hero/5b[1].swf":
					LoadingScene.instance.setContent("提示信息资源3");
					LoadingScene.instance.update(43/43);
					break;
				
			}
			//LoadingScene.instance.update(event.bytesLoaded/event.bytesTotal);
			
		}
		
	}
}