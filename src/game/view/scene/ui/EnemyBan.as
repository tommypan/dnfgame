package game.view.scene.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.protocol.LayerCollection;
	
	public class EnemyBan extends Sprite
	{
		private static var _instance :EnemyBan;
		
		private var redBloodProgress:BloodProgressBar;
		
		private var _totalHp :int;
		
		private var _root :String = "assets/map/";
		
		
		public function EnemyBan(singltonEnforcer :SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				var _bitmap :Bitmap = new Bitmap();
				LoaderManager.getInstance().getBitmap(_root+"enemy.png",_bitmap);
				_bitmap.x = 320;
				_bitmap.y = -10;
				addChild(_bitmap);
				
				LayerCollection.uiLayer.addChild(this);
				this.x = StageProxy.stageWidth() -420;
				this.y = StageProxy.stageHeight() -120;
				
				redBloodProgress = new BloodProgressBar();
			}
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():EnemyBan
		{
			_instance ||= new EnemyBan( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 
		 * 
		 */		
		public function addProgressBlood(totalHp_:int):void
		{
			_totalHp = totalHp_;
			
			
			redBloodProgress.drawProgressBar(400,20,totalHp_,new Array(0xc21f03, 0xff0000, 0xb53413));
			addChild(redBloodProgress);
			redBloodProgress.x = 0;
			redBloodProgress.y = 70;
			
		}
		
		public function updateBlood(cur:int):void
		{
			(cur <= 0) && (cur = 0);
			redBloodProgress.update(cur,_totalHp);
		}
		
		
	}
}
internal class SingltonEnforcer{}