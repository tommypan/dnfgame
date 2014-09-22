package game.view.scene.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	
	import game.event.BattleEvent;
	
	import Qmang2D.display.BitmapMovie;
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	
	public class HitCombo extends Sprite
	{
		private static var _instance :HitCombo;
		
		private var hitNumber1:MovieClip;
		
		private var hitNumber2:MovieClip;
		
		private var hitNumber3:MovieClip;
		
		private var mc:MovieClip;
		
		private var bitmapMovie :BitmapMovie;
		
		public function HitCombo(singltonEnforcer :SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				
				mc = ClassManager.createDisplayObjectInstance("HitCombo") as MovieClip;
				LayerCollection.uiLayer.addChild(mc);
				mc.x =StageProxy.stageWidth()-100;mc.y= 150;
				mc.gotoAndStop(1);
				mc.visible = false;
				
				//bitmapMovie = LoaderManager.getInstance().changeSwfToBitmapMovie("HitCombo",mc);
				
				hitNumber1 = ClassManager.createDisplayObjectInstance("HitNumber") as MovieClip;
				hitNumber2 = ClassManager.createDisplayObjectInstance("HitNumber") as MovieClip;
				hitNumber3 = ClassManager.createDisplayObjectInstance("HitNumber") as MovieClip;
				
				LayerCollection.uiLayer.addChild(hitNumber1);
				hitNumber1.x =StageProxy.stageWidth()-100;hitNumber1.y= 150;
				
				LayerCollection.uiLayer.addChild(hitNumber2);
				hitNumber2.x =StageProxy.stageWidth()-140;hitNumber2.y= 150;
				
				LayerCollection.uiLayer.addChild(hitNumber3);
				hitNumber3.x =StageProxy.stageWidth()-180;hitNumber3.y= 150;
				
				hitNumber1.visible = false;
				hitNumber2.visible = false;
				hitNumber3.visible = false;
			}
			
		}
		
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():HitCombo
		{
			_instance ||= new HitCombo( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 增加连击次数特效ui
		 * @param num连击的次数
		 * @return 
		 * 
		 */		
		public function addHitCombo(num :int):void
		{
			TimerManager.getInstance().remove(remove);
			TimerManager.getInstance().add(2000,remove);
			
			
			var str :String = num.toString();
			
			hitNumber2.visible = false;
			hitNumber3.visible = false;
			
			mc.visible = true;
			mc.gotoAndPlay(45);
			
			if(num >0 && num < 10)
			{
				hitNumber1.visible = true;
				
				hitNumber1.gotoAndStop( int(str.charAt(0))  + 1);
			}
			
			if(num >= 10 && num <100)
			{
				hitNumber1.visible = true;
				hitNumber2.visible = true;
				
				hitNumber1.gotoAndStop( int(str.charAt(1))  + 1);
				
				hitNumber2.gotoAndStop(int(str.charAt(0))  + 1); 
			}
			
			if(num >= 100 && num <1000)
			{
				hitNumber1.visible = true;
				hitNumber2.visible = true;
				hitNumber3.visible = true;
				
				hitNumber1.gotoAndStop( int(str.charAt(2))  + 1);
				
				
				hitNumber2.gotoAndStop(int(str.charAt(1))  + 1); 
				
				
				hitNumber3.gotoAndStop(int(str.charAt(0))  + 1); 
			}
		}
		
		private function remove():void
		{
			TimerManager.getInstance().remove(remove);
			mc.visible = false;
			hitNumber1.visible = false;
			hitNumber2.visible = false;
			hitNumber3.visible = false;
			
			dispatchEvent( new BattleEvent(BattleEvent.CLEAR_HEROMODEL_HITCONTER));
		}		
		
	}
}
internal class SingltonEnforcer{}