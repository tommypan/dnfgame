package game.view.maps
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Qmang2D.protocol.LayerCollection;

	public class BaseMap extends Sprite
	{
		protected var bgMap:MovieClip;
		protected var walkMap:MovieClip;
		public function BaseMap()
		{
//			bgMap = ClassManager.createDisplayObjectInstance("bgMap") as MovieClip;
//			addChild(_mcBg);
//			
//			walkMap = ClassManager.createDisplayObjectInstance("walkMap") as MovieClip;
//			addChild(_mcWalk);
//			walkMap.addEventListener(MouseEvent.MOUSE_DOWN,down);
//			walkMap.addEventListener(MouseEvent.MOUSE_UP,up);
			LayerCollection.mapOfBgLayer.addChild(bgMap);
			LayerCollection.mapOfWalkLayer.addChild(walkMap);
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		public function dispose():void{
			LayerCollection.mapOfWalkLayer.removeChild(walkMap);
			walkMap = null;
			LayerCollection.mapOfBgLayer.removeChild(bgMap);
			bgMap = null;
		}
		
//		protected function up(event:MouseEvent):void
//		{
//			walkMap.stopDrag();
//		}
//		
//		protected function down(event:MouseEvent):void
//		{
//			walkMap.startDrag();
//		}
	}
}