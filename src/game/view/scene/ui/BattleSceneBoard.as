package game.view.scene.ui
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	
	public class BattleSceneBoard extends Sprite
	{
		private static var _instance :BattleSceneBoard;
		
		private var battleBoardDown:MovieClip;
		
		private var _pauseModal :MovieClip;
		
		private var battleBoardUp:Bitmap;
		
		private var _root :String = "assets/map/";
		
		public function BattleSceneBoard(singltonEnforcer:SingltonEnforcer)
		{
			
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				battleBoardDown = ClassManager.createDisplayObjectInstance("changjing") as MovieClip;
				battleBoardUp = new Bitmap(ClassManager.createBitmapDataInstance("battleBoardBMP"));
				_pauseModal = ClassManager.createInstance("LostFocus") as MovieClip;
			}
			
		}
		
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():BattleSceneBoard
		{
			_instance ||= new BattleSceneBoard( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 
		 * @param heroName
		 * @param speak
		 * 
		 */		
		public function show(heroName:String,speak:String):void
		{
			var bitmap :Bitmap = new Bitmap();
			LoaderManager.getInstance().getBitmap(_root+"role.png",bitmap);
			
			
			battleBoardDown.heroName.text = "重邮的勇士们:";
			battleBoardDown.speak.text = speak
			MovieClip(battleBoardDown.characters).addChild(bitmap);
			
			LayerCollection.uiLayer.addChild(battleBoardDown);
			battleBoardDown.x = 0;battleBoardDown.y = StageProxy.stageHeight()-80;

			
			StageProxy.stage.addEventListener(MouseEvent.MOUSE_DOWN, onHide);
			
			
			LayerCollection.uiLayer.addChild(battleBoardUp);
			battleBoardUp.x = 0; battleBoardUp.y = 120;
			battleBoardUp.scaleY = -1;
			LayerCollection.uiLayer.addChild(_pauseModal);
			_pauseModal.x = StageProxy.stageWidth()/2;
			_pauseModal.y = StageProxy.stageHeight()/2;
		}
		
		
		public function onHide(e:MouseEvent = null):void
		{
			StageProxy.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onHide);
			TimerManager.getInstance().add(30,fade);
			
		}
		
		
		private function fade():void
		{
			battleBoardDown.y +=3;
			battleBoardUp.y   -= 3;
			if(battleBoardDown.y >= StageProxy.stageHeight())
			{
				dispatchEvent( new Event(Event.COMPLETE));
				TimerManager.getInstance().remove(fade);
				LayerCollection.uiLayer.removeChild(battleBoardDown);
				LayerCollection.uiLayer.removeChild(battleBoardUp);
				LayerCollection.uiLayer.removeChild(_pauseModal);
			}
		}		
		
		
	}
}
internal class SingltonEnforcer{}