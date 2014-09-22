package game.view.enemys
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	
	public class EnemyQ1 extends BaseEnemy
	{
		public function EnemyQ1(hp:int)
		{
			super(hp);
			_mc = ClassManager.createDisplayObjectInstance("Q1") as MovieClip;
			addChild(_mc);
		}
		/**
		 * 攻击2
		 */		
		public function attack2():void{
			_mc.gotoAndStop(8);
		}
	}
}