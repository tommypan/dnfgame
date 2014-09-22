package game.view.enemys
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import game.view.ILiving;
	import game.view.scene.ui.BloodProgressBar;
	
	import Qmang2D.pool.interfaces.IPool;
	import Qmang2D.utils.Bezier;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.TimerManager;
	
	public  class BaseEnemy extends Sprite implements ILiving,IPool
	{
		public var redBloodProgress:BloodProgressBar;
		
		public  var hp :int;
		
		protected var _mc:MovieClip;
		
		protected var _isFly :Boolean;
		
		protected var _flyCounter :int;
		
		protected var _isBeHit :Boolean;
		
		/**
		 *是否处于游弋状态 
		 */		
		public var isCruise :Boolean;
		
		public var isWalkStraight :Boolean = true;
		
		/**
		 *是否处于打击状态 
		 */		
		protected var _isHit :Boolean;
		
		/**
		 *目标点 
		 */		
		public var destPoint :Point;
		
		public var id :String;
		
		
		//----------------赛贝尔曲线
		public var steps :int;
		
		public var bezier :Bezier;
		
		public var curStp :int;
		
		private var _totalHp:int;
		
		public function BaseEnemy()
		{
			var _bitmap:Bitmap = new Bitmap(ClassManager.createBitmapDataInstance("bdShadow"));
			addChild(_bitmap);
			_bitmap.x = -50;
			_bitmap.y = -30;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			//默认没有进行播放
			
			
		}
		
		public function addProgressBar(totalHp_:int):void
		{
			_totalHp = totalHp_;
			redBloodProgress = new BloodProgressBar();
			redBloodProgress.drawProgressBar(50,5,totalHp_,new Array(0xc21f03, 0xff0000, 0xb53413));
			addChild(redBloodProgress);
			redBloodProgress.x = 0;
			redBloodProgress.y = -180;
		}
		
		public function updateBlood(curHp:int):void
		{
			(curHp < 0) && (curHp = 0);
			redBloodProgress.update(curHp,_totalHp);
		}
		
		
		/**
		 * 走动 
		 */		
		public function walk():void
		{
			if(!_isFly && !_isBeHit && !_isHit)	
			{
				_mc.gotoAndStop(1);
			}
		}
		
		/**
		 * 死亡
		 */		
		public function dead():void
		{
			_mc.gotoAndStop(2);
		}
		
		/**
		 * 攻击
		 */		
		public function attack():void
		{
			if(!_isFly && !_isBeHit && !_isHit) 
			{
				_mc.gotoAndStop(3);
				TimerManager.getInstance().add(300, hit);
				_isHit = true;
			}
		}
		
		
		private function hit():void
		{
			TimerManager.getInstance().remove(hit);
			_isHit = false;
		}
		
		
		/**
		 * 击飞
		 */		
		public function fly():void
		{
			if(_isFly == false)
			{
				_mc.gotoAndStop(4);
				TimerManager.getInstance().add(30, flyAway);
				_isFly = true;
			}
		}
		
		
		private function flyAway():void
		{
			_flyCounter++;
			if(_flyCounter == 40)
			{
				
				dead();
				//_mc.x += 3;
			}
			
			if(_flyCounter == 70)
			{
				TimerManager.getInstance().remove(flyAway);
				_flyCounter = 0;
				_isFly = false;
			}
		}
		
		
		/**
		 * 倒下
		 */		
		public function fall():void
		{
			if(!_isFly && !_isBeHit && !_isHit)
			{
				_mc.gotoAndStop(5);
			}
		} 
		
		
		/**
		 * 空闲状态
		 */		
		public function idel():void
		{
			if(!_isFly && !_isBeHit && !_isHit) 
			{
				_mc.gotoAndStop(6);
			}
		}
		
		
		/**
		 * 被击打
		 */		
		public function beAttack():void
		{
			if(!_isBeHit && !_isFly && !_isHit)
			{
				_mc.gotoAndStop(7);
				TimerManager.getInstance().add(300, beHit);
				_isBeHit = true;
			}
			
		}
		
		private function beHit():void
		{
			
			TimerManager.getInstance().remove(beHit);
			_isBeHit = false;
			
		}
		
		
		public function dispose():void
		{
			_mc.stop();
			
			this.contains(redBloodProgress)
			removeChild(redBloodProgress);
		}
		
		
		/**
		 *敌人是否处于飞翔状态  
		 * @return 
		 * 
		 */		
		public function get isFly():Boolean
		{
			return _isFly;
		}
		
		/**
		 *敌人是否处于被打击zhuangt 
		 * @return 
		 * 
		 */		
		public function get isBeHit():Boolean
		{
			return _isBeHit;
		}
		
		/**
		 *敌人是否处于打击状态
		 * @return 
		 * 
		 */		
		public function get isHit():Boolean
		{
			return _isHit;
		}
		
		
	}
}