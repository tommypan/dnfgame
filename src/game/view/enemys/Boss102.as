package game.view.enemys
{
	import com.gs.TweenLite;
	
	import flash.display.MovieClip;
	
	import Qmang2D.display.BitmapMovie;
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	
	public class Boss102 extends BaseBoss
	{
		private var _bitmapEffect :BitmapMovie = new BitmapMovie();
		
		private var _aRoot :String = "assets/";
		
		private var _isAttack2 :Boolean;
		
		public function Boss102()
		{
			//super(hp);
			_mc = ClassManager.createDisplayObjectInstance("BOSS2") as MovieClip;
			//LoaderManager.getInstance().getMovieClip(_aRoot+"boss1.swf",_bitmapEffect,true,false,false,onComplete);
			addChild(_mc);
			
			//addChild(_bitmapEffect);
			//_bitmapEffect.y = -50;
			
		}
		
		
		/**
		 * 攻击2
		 */		
		override public function attack2():void
		{
			if(!_isAttack2)
			{
				_isAttack2 = true;
				_mc.gotoAndStop(8);
				TimerManager.getInstance().add(2000,fadeEffect);
			}
			
		}
		
		private function fadeEffect():void
		{
			TimerManager.getInstance().remove(fadeEffect);
			_isAttack2 = false;
			idel();
		}
		
		override public function dispose():void
		{
			_mc.stop();
			_bitmapEffect.stop();
			_isAttack2 = false;
		}
		
	}
}