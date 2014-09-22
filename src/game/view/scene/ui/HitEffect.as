package game.view.scene.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import Qmang2D.pool.interfaces.IPool;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	
	/**
	 *@author aser_ph
	 *@date 2013-5-15
	 */
	public class HitEffect extends Sprite implements IPool
	{

		private var hitEffect:MovieClip;
		
		public function HitEffect()
		{
			
			hitEffect = ClassManager.createDisplayObjectInstance("HitEffect") as MovieClip;
			hitEffect.stop();
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		private function removeHitEffect():void
		{
			hitEffect.stop();
			this.removeChild(hitEffect);
			LayerCollection.effectLayer.removeChild(this);
			TimerManager.getInstance().remove(removeHitEffect);
		}
		
		/**
		 *开始播放 
		 * 
		 */		
		public function play():void
		{
			hitEffect.play();
			addChild(hitEffect);
			TimerManager.getInstance().add(500,removeHitEffect);
		}
		
	}
}