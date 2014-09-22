package game.view.scene.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	
	public class SimpleGo extends Sprite
	{
		private var oo :MovieClip;
		
		public function SimpleGo()
		{
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
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