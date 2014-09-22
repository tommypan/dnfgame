package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.view.enemys.Boss102;
	
	import Qmang2D.display.BitmapMovie;
	import Qmang2D.display.EnhancedMovieClip;
	import Qmang2D.loader.LoaderManager;
	
	public class TestUi extends Sprite
	{
		//animation
		private var _aRoot :String = "assets/";
		
		private var _loaderInstance :LoaderManager;
		
		private var hitNumber1:MovieClip;
		
		private var hitNumber2:MovieClip;
		
		private var hitNumber3:MovieClip;
		
		private var mc:MovieClip;

		private var _bitmapEffect:BitmapMovie;

		private var boss:Boss102;
		
		public function TestUi()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			_loaderInstance = LoaderManager.getInstance();
			
			_loaderInstance.getModualSwf(_aRoot+"map/rightUpBtn.swf");
			//			LoaderManager.getInstance().getBlurXml("assets/common/hero.xml",null,true);
			//			LoaderManager.getInstance().getBlurXml("assets/common/enemy.xml",null,true);
			//			LoaderManager.getInstance().getBlurXml("assets/chapter/enemyConfig.xml",null,true);
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
			_loaderInstance.getModualSwf(_aRoot+"hero/5a[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"common.swf");
			_loaderInstance.getModualSwf(_aRoot+"hints.swf");
			_loaderInstance.getModualSwf(_aRoot+"hint.swf");
			_loaderInstance.getModualSwf(_aRoot+"map[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"zhanchuan[1].swf");
			_loaderInstance.getModualSwf(_aRoot+"wushuang.swf");
			_loaderInstance.getModualSwf(_aRoot+"hero/5b[1].swf",onComplete);
		}
		
		private function onComplete():void
		{
			boss = new Boss102();
			addChild(boss);
			boss.x = 500;boss.y = 400;
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}		
		
		protected function onClick(event:MouseEvent):void
		{
			boss.attack2();
		}
		
	}
}