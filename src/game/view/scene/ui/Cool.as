package game.view.scene.ui
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.protocol.LayerCollection;
	import Qmang2D.protocol.SoundManager;
	
	public class Cool extends MovieClip
	{
		private static var _instance :Cool;
		
		private var _cool:MovieClip;
		
		public function Cool(singltonEnforcer:SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				var shape :Shape = new Shape();
				shape.graphics.beginFill(0x333333,1);
				shape.graphics.drawRect(0,0,StageProxy.stageWidth(),StageProxy.stageHeight());
				addChild(shape);
			
				
				_cool = ClassManager.createDisplayObjectInstance("cool") as MovieClip;
				addChild(_cool);
				_cool.stop();
				
				
				
				//this.visible = false;
				
			}
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():Cool
		{
			_instance ||= new Cool( new SingltonEnforcer());
			return _instance;
		}
		
		/**
		 * 
		 * @param point 播放位置点
		 * 
		 */		
		public function show(point :Point):void
		{
			LayerCollection.uiLayer.addChild(this);
			
			point.y += 50;
			
			(point.x <= 200)  && (point.x = 200);
			(point.x >=  StageProxy.stageWidth()-250)  && (point.x =  StageProxy.stageWidth()-250);
			(point.y <= 50) && (point.y = 50);
			(point.y >= StageProxy.stageHeight()-50) && (point.y = StageProxy.stageHeight()-50);
			
			_cool.x = point.x; _cool.y = point.y;
			
			_cool.play();
			SoundManager.getInstance().MusicPuase();
			SoundManager.getInstance().playEffectSound("KO",1);
		}
		
		public function hide():void
		{
			if(LayerCollection.uiLayer.contains(this))
				LayerCollection.uiLayer.removeChild(this);
			
			_cool.stop();
		}
		
		
		
	}
}
internal class SingltonEnforcer{}