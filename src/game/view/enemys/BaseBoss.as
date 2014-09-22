package game.view.enemys
{
	public class BaseBoss extends BaseEnemy
	{
		public function BaseBoss()
		{
			//super(hp);
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		/**
		 * 攻击2
		 */		
		public function attack2():void{
			_mc.gotoAndStop(8);
		}
		
		override	public function addProgressBar(totalHp_:int):void
		{
		}
		
		override public function updateBlood(curHp:int):void
		{
		}
		
		override public function dispose():void
		{
			_mc.stop();
		}
		
	}
}