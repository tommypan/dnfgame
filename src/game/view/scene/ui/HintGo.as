package game.view.scene.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	
	/**
	 *@author aser_ph
	 *@date 2013-5-15
	 */
	public class HintGo extends Sprite
	{
		private var xx :MovieClip 
		
		private var oo :MovieClip;
		
		private static var _instance :HintGo;
		
		public function HintGo(singltonEnforcer:SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				this.mouseChildren = false;
				this.mouseEnabled = false;
				
			}
			
			
			
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():HintGo
		{
			_instance ||= new HintGo( new SingltonEnforcer());
			return _instance;
		}
		
		public function show():void
		{
			hide();
			
			LayerCollection.uiLayer.addChild(this);
			this.x = 500;this.y = 300;
			
			xx = ClassManager.createDisplayObjectInstance("HintGameStart") as MovieClip;
			addChild(xx);
			TimerManager.getInstance().add(5000,fade);
		}
		
		public function hide():void
		{
			if(xx && this.contains(xx))
			{
				removeChild(xx);
				xx.stop();
			}
			
			if(oo && this.contains(oo))
			{
				removeChild(oo);
				oo.stop();
			}
			
			if(LayerCollection.uiLayer.contains(this))
			{
				LayerCollection.uiLayer.removeChild(this);
			}
			
			
			TimerManager.getInstance().remove(fade);
			TimerManager.getInstance().remove(fadeGo);
		}
		
		
		private function fade():void
		{
			xx.stop();
			removeChild(xx);
			TimerManager.getInstance().remove(fade);
			
			dispatchEvent( new Event(Event.COMPLETE));
			
			
			oo = ClassManager.createDisplayObjectInstance("HintGo") as MovieClip;
			addChild(oo);
			oo.x = 630;
			TimerManager.getInstance().add(2500,fadeGo);
		}
		
		private function fadeGo():void
		{
			TimerManager.getInstance().remove(fadeGo);
			oo.stop();
			removeChild(oo);
			oo = null;
		}
		
	}
	
}

internal class SingltonEnforcer{}