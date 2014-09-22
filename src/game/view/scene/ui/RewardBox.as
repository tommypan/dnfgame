package game.view.scene.ui
{
	import com.gs.TweenLite;
	import com.gs.easing.Strong;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	import Qmang2D.protocol.SoundManager;
	
	/**
	 *所有面板应该写成单例 
	 * @author panhao
	 * 
	 */	
	public class RewardBox extends Sprite implements IPanel
	{
		private static var _instance :RewardBox;
		
		private var rewardBox :MovieClip;
		
		private var openBox:MovieClip;
		
		/**
		 *
		 */		
		private var moneyNum :TextField;
		
		/**
		 *
		 */		
		private var jiNengMc :MovieClip;
		
		/**
		 *技能文本(一般没用) 
		 */		
		private var jiNeng :TextField;
		
		/**
		 *
		 */		
		public var jiNengName :String;
		
		private var button:TextField;
		
		public var battleGet:MovieClip;
		
		
		public function RewardBox(singltonEnforcer:SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				rewardBox = ClassManager.createDisplayObjectInstance("McBoxForUproarHeaven") as MovieClip;
				
				
				
				openBox = ClassManager.createDisplayObjectInstance("McOpenBox") as MovieClip;
				
				
				battleGet = ClassManager.createDisplayObjectInstance("shiqu") as MovieClip;
				
				
				button = new TextField();
				battleGet.addChild(button);
				button.text = "  ";
				button.width = 100;button.height = 50;
				button.y = 60;button.x = -65;
				
			}
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():RewardBox
		{
			_instance ||= new RewardBox( new SingltonEnforcer());
			return _instance;
		}
		
		
		/**
		 *展示战斗元宝箱 
		 * @param moneyNum_ 获得金币数量文本 
		 * @param jiNengMc_放置技能的图片 
		 * @param jiNengName_技能名文本 
		 * 
		 */		
		public function show(moneyNum_:int,jiNengMc_:MovieClip,jiNengName_:String=null):void
		{
			battleGet.moneyNum.text = String(moneyNum_);
			jiNengMc = jiNengMc_;
			
			if(!jiNengName_)
			{
			}else{
				
				battleGet.jiNengName.text = jiNengName;
			}
			
			LayerCollection.mapOfWalkLayer.addChild(rewardBox);
			rewardBox.x = 2500;rewardBox.y = -200;
			TweenLite.to(rewardBox, 0.8, {alpha:1, y:400,x:2500, ease:com.gs.easing.Strong.easeIn, onComplete:onFinishTween});
			function onFinishTween():void
			{
				LayerCollection.mapOfWalkLayer.addChild(openBox);
				openBox.x= 2700;openBox.y = 400;
			}
			
			rewardBox.gotoAndStop(1);
			
			addListeners();
		}
		
		private function addListeners():void
		{
			rewardBox.addEventListener(MouseEvent.CLICK, onOpenRewardBox);	
			
			button.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.addEventListener(MouseEvent.CLICK, hide);
		}
		
		
		public function reset():void
		{
			
		}
		
		
		/**
		 * 隐藏战斗元宝箱及相关
		 * @param e
		 * 
		 */			
		public function hide(e:MouseEvent = null):void
		{
			if(e)
			{
				TweenLite.to(jiNengMc,2,{x:-750,y:-370,onComplete:onFinish});
				SoundManager.getInstance().playEffectSound("click",1);
				SoundManager.getInstance().playEffectSound("move",1);
			}
			
			if(LayerCollection.mapOfWalkLayer.contains(rewardBox))
			{
				
				TimerManager.getInstance().add(30,fade1);
			}
			
			if(LayerCollection.uiLayer.contains(battleGet))
			{
				TimerManager.getInstance().add(30,fade2);
			}
			
			if(LayerCollection.mapOfWalkLayer.contains(openBox))
			{
				TimerManager.getInstance().add(30,fade3);
			}
			
			
			Mouse.cursor=MouseCursor.AUTO;
			removeListeners();
		}
		
		private function onFinish():void
		{
			MovieClip(battleGet.jiNengMc).removeChild(jiNengMc);
			dispatchEvent( new Event(Event.COMPLETE));
		}
		
		private function fade3():void
		{
			openBox.alpha -= .05
			if(openBox.alpha <= 0)
			{
				TimerManager.getInstance().remove(fade3);
				LayerCollection.mapOfWalkLayer.removeChild(openBox);
				openBox.alpha = 1;
			}
			
		}
		
		private function fade2():void
		{
			battleGet.alpha -= .05
			if(battleGet.alpha <= 0)
			{
				TimerManager.getInstance().remove(fade2);
				LayerCollection.uiLayer.removeChild(battleGet);
				battleGet.alpha = 1;
			}
			
		}
		
		private function fade1():void
		{
			rewardBox.alpha -= .05
			if(rewardBox.alpha <= 0)
			{
				TimerManager.getInstance().remove(fade1);
				LayerCollection.mapOfWalkLayer.removeChild(rewardBox);
				rewardBox.alpha = 1;
			}
			
		}
		
		
		
		private function removeListeners():void
		{
			rewardBox.removeEventListener(MouseEvent.CLICK, onOpenRewardBox);	
			
			button.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.removeEventListener(MouseEvent.CLICK, hide);
		}		
		
		/**
		 *打开奖励箱子 
		 * @param event
		 * 
		 */		
		private function onOpenRewardBox(event:MouseEvent):void
		{
			SoundManager.getInstance().playEffectSound("click",1);
			
			rewardBox.gotoAndStop(2);
			
			var point :Point = new Point(rewardBox.x,rewardBox.y);
			point = LayerCollection.mapOfWalkLayer.localToGlobal(point);
			
			battleGet.scaleX = 0;
			battleGet.scaleY = 0;
			battleGet.x = point.x;
			battleGet.y = point.y;
			LayerCollection.uiLayer.addChild(battleGet);
			TweenLite.to(battleGet,1.5,{scaleX:1,scaleY:1,x:600,y:300});
			
			MovieClip(battleGet.jiNengMc).addChild(jiNengMc);
			jiNengMc.y = -5;
			
		}		
		
		
		private function onOut(event:MouseEvent):void
		{
			Mouse.cursor=MouseCursor.ARROW;
		}
		
		private function onOver(event:MouseEvent):void
		{
			Mouse.cursor=MouseCursor.BUTTON;
		}
		
		
	}
}
internal class SingltonEnforcer{}