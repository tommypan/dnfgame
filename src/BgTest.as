package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	
	import game.view.maps.BattleMap1;
	import game.view.maps.BattleMap2;
	import game.view.maps.BattleMap3;
	import game.view.maps.BattleMap4;
	import game.view.maps.BattleMap5;
	import game.view.maps.BattleMap6;
	import game.view.maps.BattleMap7;
	import game.view.maps.BattleMap8;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;

	public class BgTest extends Sprite
	{
		private var _mcBg:MovieClip;
		private var _mcWalk:MovieClip;
		public function BgTest()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.quality = StageQuality.MEDIUM;  
			
//			LoaderManager.getInstance().getModualSwf("res/BattleMap1.swf",onC);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap2.swf",onC2);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap3.swf",onC3);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap4.swf",onC4);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap5.swf",onC5);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap6.swf",onC6);
//			LoaderManager.getInstance().getModualSwf("res/BattleMap7.swf",onC7);
			LoaderManager.getInstance().getModualSwf("res/BattleMap8.swf",onC8);
		}
		
		
		private function onC():void
		{
			var battleMap1:BattleMap1 = new BattleMap1();
			addChild(battleMap1);
		}
		private function onC2():void
		{
			var battleMap2:BattleMap2 = new BattleMap2();
			addChild(battleMap2);
			
		}
		private function onC3():void
		{
			var battleMap2:BattleMap3 = new BattleMap3();
			addChild(battleMap2);
			
		}
		private function onC4():void
		{
			var battleMap2:BattleMap4 = new BattleMap4();
			addChild(battleMap2);
			
		}
		private function onC5():void
		{
			var battleMap2:BattleMap5 = new BattleMap5();
			addChild(battleMap2);
			
		}
		private function onC6():void
		{
			var battleMap2:BattleMap6 = new BattleMap6();
			addChild(battleMap2);
			
		}
		private function onC7():void
		{
			var battleMap2:BattleMap7 = new BattleMap7();
			addChild(battleMap2);
			
		}
		private function onC8():void
		{
			var battleMap2:BattleMap8 = new BattleMap8();
			addChild(battleMap2);
			
		}
	}
}