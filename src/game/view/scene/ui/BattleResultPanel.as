package game.view.scene.ui
{
	import com.gs.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	import Qmang2D.protocol.SoundManager;
	
	public class BattleResultPanel extends Sprite
	{
		private static var _instance :BattleResultPanel;
		
		private var battleResultPanel:MovieClip;
		
		private var button:TextField;
		
		private var mc1:MovieClip;
		
		
		public function BattleResultPanel(singltonEnforcer:SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				battleResultPanel = ClassManager.createDisplayObjectInstance("battleResult") as MovieClip;
				
				button = new TextField();
				battleResultPanel.addChild(button);
				button.text = "  ";
				button.width = 100;button.height = 50;
				button.y = 100;button.x = -45;
			}
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():BattleResultPanel
		{
			_instance ||= new BattleResultPanel( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 
		 *  @param dengji 获得等级
		 * @param zhangong 获得战功
		 * @param yuanBao 获得元宝数
		 * @param jiqiao 技巧得分
		 * @param time 时间得分
		 * @param lianji 连击得分
		 * @param shadi 杀敌得分
		 * 
		 */		
		public function show(dengji:int,zhangong:int,yuanBao :int,jiqiao:int,time:int,lianji:int,shadi:int):void
		{
			LayerCollection.uiLayer.addChild(battleResultPanel);
			battleResultPanel.x = 600;battleResultPanel.y = 300;
			battleResultPanel.scaleX = 0; battleResultPanel.scaleY = 0;
			TweenLite.to(battleResultPanel,1.2,{scaleX:1,scaleY:1,onComplete:onFinishTween});
			function onFinishTween():void
			{
				battleResultPanel.dengji.text = String(dengji);
				battleResultPanel.zhangong.text = String(zhangong);
				battleResultPanel.yuanBa.text = String(yuanBao);
				
				battleResultPanel.jiqiao.text = String(jiqiao);
				battleResultPanel.shijian.text = String(time);
				battleResultPanel.lianji.text = String(lianji);
				battleResultPanel.shadi.text = String(shadi);
				
				
				var total :int = jiqiao+time+lianji+shadi;
				if(total >= 7000)
				{
					mc1 = ClassManager.createDisplayObjectInstance("FLBalance3") as MovieClip;
					MovieClip(battleResultPanel.pingjiaMc).addChild(mc1);
				}else if(total >= 5800){
					mc1 = ClassManager.createDisplayObjectInstance("FLBalance2") as MovieClip;
					MovieClip(battleResultPanel.pingjiaMc).addChild(mc1);
				}else{
					mc1 = ClassManager.createDisplayObjectInstance("FLBalance1") as MovieClip;
					MovieClip(battleResultPanel.pingjiaMc).addChild(mc1);
				}
				battleResultPanel.zongfen.text = String(total);
				
				TimerManager.getInstance().add(1000,stopAnimation);
				addListeners();
			}
			
		}
		
		private function stopAnimation():void
		{
			TimerManager.getInstance().remove(stopAnimation);
			mc1.stop();
		}		
		
		
		/**
		 * 隐藏战斗元宝箱及相关
		 * @param e
		 * 
		 */			
		public function hide(e:MouseEvent = null):void
		{
			if(e) SoundManager.getInstance().playEffectSound("click",1);
			
			if(LayerCollection.uiLayer.contains(battleResultPanel))
				LayerCollection.uiLayer.removeChild(battleResultPanel);
			
			if(mc1 && battleResultPanel.pingjiaMc.contains(mc1))
				battleResultPanel.pingjiaMc.removeChild(mc1);
			
			removeListeners();
			Mouse.cursor = MouseCursor.AUTO;
			
			dispatchEvent( new MouseEvent(MouseEvent.CLICK));
		}
		
		private function addListeners():void
		{
			
			button.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.addEventListener(MouseEvent.CLICK, hide);
		}
		
		
		private function removeListeners():void
		{
			
			button.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
			button.removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			button.removeEventListener(MouseEvent.CLICK, hide);
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