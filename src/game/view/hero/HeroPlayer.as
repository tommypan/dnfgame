package game.view.hero
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import game.event.BattleEvent;
	import game.view.ILiving;
	import game.view.hero.battle.ATTACK0;
	import game.view.hero.battle.ATTACK1;
	import game.view.hero.battle.ATTACK2;
	import game.view.hero.battle.BEATTACK;
	import game.view.hero.battle.DEAD;
	import game.view.hero.battle.EFFECT1;
	import game.view.hero.battle.EFFECT2;
	import game.view.hero.battle.EFFECT3;
	import game.view.hero.battle.JUMPATTACK;
	import game.view.scene.BattleScene;
	
	import Qmang2D.utils.KeyBoardControl;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	
	/**
	 * 英雄player，跟敌军不一样，这里是自己玩家自己操作。所以，提供的接口与EnemyPlayer不一样
	 * 将人物走动与打斗键盘控制播放分开 ||解决
	 * 321go可以增加,ui与游戏融合，比如：血条，退出，跑图，技能，打斗特效，过关奖励宝箱等逻辑。
	 * 敌人AI改进(打击，发散功能，代码优化),boss系统，缓动效果，技能数据配置系统与相关战斗数据计算。
	 * || boss系统，缓动效果，技能数据配置系统还没搞
	 * 下个游戏考虑后端因素，写后台简单的数据读取
	 * 数据流程已拉通 ||
	 * 敌人动画播放融合 ||
	 * 可以将全局变量传参 ||
	 * 缓冲池 ||
	 * Logger as3使用，与java差不多了，那个trace和Test完全被干掉
	 * 狗日的，pop和splice在vector中要分清，害的老子找了半天
	 * len   xx.length
	 *@author aser_ph
	 *@date 2013-5-4
	 */
	public class HeroPlayer extends Sprite implements ILiving
	{
		//private var point:Shape = new Shape();	不用，直接用this
		//开始没有检测到碰撞，是因为自己移除在移除后在进行检测。。。
		
		private var _walk :WALK = new WALK();
		
		private var _idel:IDLE = new IDLE();
		
		private var _jump :JUMP = new JUMP();
		
		private var _beAttack :BEATTACK = new BEATTACK();
		
		private var _attack :ATTACK0 = new ATTACK0();
		
		private var _attack1 :ATTACK1 = new ATTACK1();
		
		private var _attack2 :ATTACK2 = new ATTACK2();
		
		private var _effect1 :EFFECT1 = new EFFECT1();
		
		private var _effect2 :EFFECT2 = new EFFECT2();
		
		private var _effect3 :EFFECT3 = new EFFECT3();
		
		private var _dead :DEAD = new DEAD();
		
		//----------------------------------------判断相关
		/**跳跃高度索引，用于判断*/
		private var _jumpHeightIndex :int;
		
		/**是否处于跳跃状态*/
		private var _isJump :Boolean;
		
		private var _JLock :Boolean = true;//kaisuo
		
		public static var _peopleCenterPointX:Number = StageProxy.stageWidth()/2;
		
		public var beAttack :Boolean;
		
		private var _speedX :int;
		
		private var _speedY :int;
		
		private var _isHit :Boolean;
		
		//todo--------------------技能相关,发布时要改回来
		private var _isHEnable :Boolean = true;
		
		private var _isLEnable :Boolean = true;
		
		private var _isUEnable :Boolean = true;
		
		private var _isIEnable :Boolean = true;
		
		private var _isOEnable :Boolean = true;
		
		private var preRightRestriantX:Number = 0;
		
		public function HeroPlayer()
		{
			addChild(_idel);
			_idel.mc.play();
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			this.addEventListener(Event.ENTER_FRAME, onHandleHeroPlay);
			this.addEventListener(BattleEvent.SEND_HERO_VO, onHandleHeroVo);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		protected function onHandleHeroVo(event:BattleEvent):void
		{
			_speedX = event.DATA.speedX;
			_speedY = event.DATA.speedY;
		}
		
		private function onKeyUp(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.J || event.keyCode == Keyboard.H || 
				event.keyCode == Keyboard.U|| event.keyCode == Keyboard.I || 
				event.keyCode == Keyboard.O || event.keyCode == Keyboard.L)
				
				_JLock = true;
		}
		
		private function onKeyDown(event:KeyboardEvent):void
		{
			if(_JLock == true )
			{
				switch(event.keyCode)	//小绝招，非跑状态
				{
					case Keyboard.J:
					{
						attackCommom(_attack);
						break;
					}
						
					case Keyboard.H: //attack1
					{
						if(_isHEnable)
						{
							//_isHEnable = false;
							//dispatchEvent( new BattleEvent(BattleEvent.HIDE_SKILL_CD,'h'));
							//TimerManager.getInstance().add(800,resetH);
							attackCommom(_attack1);
						}
						break;
					}	
						
					case Keyboard.L: //attack2
					{
						if(_isLEnable)
						{
							//_isLEnable = false;
							//dispatchEvent( new BattleEvent(BattleEvent.HIDE_SKILL_CD,'l'));
							//TimerManager.getInstance().add(1000,resetL);
							attackCommom(_attack2);
						}
						break;
					}	
						
					case Keyboard.U: //effect1
					{
						if(_isUEnable)
						{
							//_isUEnable = false;
							//dispatchEvent( new BattleEvent(BattleEvent.HIDE_SKILL_CD,'u'));
							//TimerManager.getInstance().add(1500,resetU);
							attackCommom(_effect1);
						}
						break;
					}	
						
					case Keyboard.I: //effect2
					{
						if(_isIEnable)
						{
							//_isIEnable = false;
							//dispatchEvent( new BattleEvent(BattleEvent.HIDE_SKILL_CD,'i'));
							//TimerManager.getInstance().add(2000,resetI);
							attackCommom(_effect2);
						}
						break;
					}	
						
					case Keyboard.O: //effect3
					{
						if(_isOEnable)
						{
							//_isOEnable = false;
							//dispatchEvent( new BattleEvent(BattleEvent.HIDE_SKILL_CD,'o'));
							//TimerManager.getInstance().add(1000,resetO);
							attackCommom(_effect3);
						}
						break;
					}	
						
					case Keyboard.K: //jump
					{
						
						if(_isJump==false)
						{
							_isJump = true;
							removeAll();
							TimerManager.getInstance().add(50,jumpUp);
							addChild(_jump);
							_jump.mc.play();
						}
						break;
					}	
						
				}
			}
		}
		
		private function resetO():void
		{
			_isOEnable = true;
			TimerManager.getInstance().remove(resetO);
			dispatchEvent(new BattleEvent(BattleEvent.RESET_SKILL_CD,'o'));
		}
		
		private function resetI():void
		{
			_isIEnable = true;
			TimerManager.getInstance().remove(resetI);
			dispatchEvent(new BattleEvent(BattleEvent.RESET_SKILL_CD,'i'));
		}
		
		private function resetU():void
		{
			_isUEnable = true;
			TimerManager.getInstance().remove(resetU);
			dispatchEvent(new BattleEvent(BattleEvent.RESET_SKILL_CD,'u'));
		}
		
		private function resetL():void
		{
			_isLEnable = true;
			TimerManager.getInstance().remove(resetL);
			dispatchEvent(new BattleEvent(BattleEvent.RESET_SKILL_CD,'l'));
		}
		
		private function resetH():void
		{
			_isHEnable = true;
			TimerManager.getInstance().remove(resetH);
			dispatchEvent(new BattleEvent(BattleEvent.RESET_SKILL_CD,'h'));
		}
		
		private function onHandleHeroPlay(event:Event):void
		{
			
			if(KeyBoardControl.isDown(Keyboard.W)) //上走
			{
				
				walkCommom();
				
				if(this.y<340)
				{
					return;
				}
				
				this.y -= _speedY;
			}
			
			if(KeyBoardControl.isDown(Keyboard.S)) //下走
			{
				walkCommom();
				
				if(this.y>590)
				{
					return;
				}
				
				this.y += _speedY;
			}
			
			
			if(KeyBoardControl.isDown(Keyboard.A)) //左走
			{
				
				walkCommom();
				
				if(this.x<BattleScene.leftRestriantX)//0 600 1600
				{
					return;
				}
				this.x -= _speedX;
				this.scaleX = -1;
				if(this.x<_peopleCenterPointX)
				{
					//					if(LayerCollection.mapOfWalkLayer.x>=BattleScene.leftRestriantX)
					//						return;
					if(LayerCollection.mapOfWalkLayer.x>=-(BattleScene.leftRestriantX))
						return;
					LayerCollection.mapOfWalkLayer.x += _speedX;
					LayerCollection.mapOfBgLayer.x  += 3;
					_peopleCenterPointX = this.x;
					
					//					if(preRightRestriantX > BattleScene.rightRestriantX){
					//						_peopleCenterPointX = LayerCollection.mapOfWalkLayer .x+StageProxy.stageWidth()/2;
					//					}else{
					//						preRightRestriantX = BattleScene.rightRestriantX;
					//					}
				}
				
			}
			
			
			if(KeyBoardControl.isDown(Keyboard.D)) //右走
			{
				walkCommom();
				
				
				if(this.scaleX==-1)
					
				{
					this.scaleX = 1;
				}
				if(this.x>BattleScene.rightRestriantX)//1900 2500 3100
				{
					return; //--------
				}
				
				this.x += _speedX;
				
				
				if(this.x>_peopleCenterPointX)
				{
					if(LayerCollection.mapOfWalkLayer.x<=-(BattleScene.rightRestriantX-StageProxy.stageWidth())+10)
						return;
					LayerCollection.mapOfWalkLayer.x -= _speedX;
					LayerCollection.mapOfBgLayer.x  -= 3;
					_peopleCenterPointX = this.x;
					
					//					if(preRightRestriantX < BattleScene.leftRestriantX){
					//						_peopleCenterPointX = LayerCollection.mapOfWalkLayer .x+StageProxy.stageWidth()/2;
					//					}else{
					//						preRightRestriantX = BattleScene.leftRestriantX;
					//					}
					
				}
			}
			
			if(KeyBoardControl.isUp(Keyboard.W) || KeyBoardControl.isUp(Keyboard.W)//松开上下左右键
				|| KeyBoardControl.isUp(Keyboard.A) || KeyBoardControl.isUp(Keyboard.D))
			{
				if(!_isJump)
				{
					removeAll();
					addChild(_idel);
					_idel.mc.play();
				}
			}
			
		}
		
		private function checkHit(target:BaseHero):void
		{
			var battleEvent :BattleEvent;
			
			switch(target)
			{
				case _attack:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"j");
					break;
				}
					
				case _attack1:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"h");
					break;
				}
					
				case _attack2:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"l");
					break;
				}
				case _effect1:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"u")
					break;
				}
					
				case _effect2:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"i")
					break;
				}
					
				case _effect3:
				{
					battleEvent = new BattleEvent(BattleEvent.CHECK_HIT,"o")
					break;
				}
					
				default:
				{
					throw new Error("未知技能招数");
					break;
				}
					
			}
			dispatchEvent(battleEvent);
			
		}
		
		private function attackCommom(target:BaseHero):void
		{
			_isJump = true;
			removeAll();
			
			if(this.contains(target)==false)
			{
				_JLock = false;//关锁
				addChild(target);
				target.mc.play();
				checkHit(target);
				TimerManager.getInstance().add(1000,backToIdel);
			}
		}
		
		private function backToIdel():void
		{
			TimerManager.getInstance().remove(backToIdel);
			_isJump = false;
			
			if( this.contains(_attack) || this.contains(_attack1) || 
				this.contains(_attack2) || this.contains(_effect1) || 
				this.contains(_effect2) || this.contains(_beAttack) ||
				this.contains(_effect3))
			{
				removeAll();
				addChild(_idel);
				_idel.mc.play();
			}
			
		}
		
		private function walkCommom():void
		{
			if(!_isJump)
			{
				removeAll();
				
				if(this.contains(_walk) == false)
				{
					addChild(_walk);
					_walk.mc.play();
				}
			}
		}
		
		private function removeAll():void
		{
			if(this.contains(_walk))	
			{
				removeChild(_walk); 
				_walk.mc.stop();
				return;
			}
			
			if(this.contains(_idel))	
			{
				removeChild(_idel); 
				_idel.mc.stop();
				return;
			}
			
			if(this.contains(_jump))	
			{
				removeChild(_jump); 
				_jump.mc.stop();
				return;
			}
			
			if(this.contains(_attack))
			{
				removeChild(_attack); 
				_attack.mc.stop();
				return;
			}
			
			if(this.contains(_attack1))	
			{
				removeChild(_attack1); 
				_attack1.mc.stop();
				return;
			}
			
			if(this.contains(_attack2))
			{
				removeChild(_attack2); 
				_attack2.mc.stop();
				return;
			}
			
			if(this.contains(_effect1))
			{
				removeChild(_effect1); 
				_effect1.mc.stop();
				return;
			}
			
			if(this.contains(_effect2)) 
			{
				removeChild(_effect2); 
				_effect2.mc.stop();
				return;
			}
			
			if(this.contains(_effect3)) 
			{
				removeChild(_effect3); 
				_effect3.mc.stop();
				return;
			}
			
			
			if(this.contains(_beAttack))
			{
				removeChild(_beAttack);
				_beAttack.mc.stop();
				return;
			}
			
		}
		
		private function jumpDown():void
		{
			this.y += _speedY;
			_jumpHeightIndex--;
			if(_jumpHeightIndex==0)
			{
				TimerManager.getInstance().remove(jumpDown);
				removeAll();
				addChild(_idel);
				_idel.mc.play();
				_isJump = false;
			}
		}
		
		private function jumpUp():void
		{
			_jumpHeightIndex++;
			if(_jumpHeightIndex==8)
			{
				TimerManager.getInstance().remove(jumpUp);
				TimerManager.getInstance().add(50,jumpDown);
			}
			this.y -= _speedY;
		}
		
		/**
		 *播放被攻击动画 
		 * 
		 */		
		public function playBeAttack(isFade :Boolean = false):void
		{
			_isJump = true;
			removeAll();
			
			if(this.contains(_beAttack)==false)
			{
				addChild(_beAttack);
				_beAttack.mc.play();
				//checkHit();
				TimerManager.getInstance().add(500,backToIdel);
			}
			if(isFade == true)
			{
				_isHit = true;
				this.alpha = .5;
				TimerManager.getInstance().add(2000,beAttackOver);
				StageProxy.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
				StageProxy.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				KeyBoardControl.unRegister();
			}else{
				
			}
		}
		
		private function beAttackOver():void
		{
			_isHit = false;
			this.alpha = 1;
			TimerManager.getInstance().remove(beAttackOver);
			KeyBoardControl.register();
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 *播放死亡动画 
		 * 
		 */		
		public function playDead():void
		{
			removeAll();
			addChild(_dead);
			_dead.mc.play();
		}
		
		/**
		 *播放站立动画 
		 * 
		 */		
		public function playIdle():void
		{
			addChild(_idel);
		}
		
		
		/**
		 * 停止播放英雄，移除英雄。在切换关卡后，并不是调用dispose方法，而是调用stop方法，将其移除，停止掉。
		 * 进入新的关卡后，直接调用此play方法即可
		 */			
		public function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, onHandleHeroPlay);
			removeAll();
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		/**
		 * 开始播放英雄，在切换关卡后，并不是调用dispose方法，而是调用stop方法，将其移除，停止掉。
		 * 进入新的关卡后，直接调用此play方法即可
		 */		
		public function play():void
		{
			addEventListener(Event.ENTER_FRAME, onHandleHeroPlay);
			addChild(_idel);
			_idel.mc.play();
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			//-------------------重置
			_jumpHeightIndex = 0;
			_isJump = false;
			_JLock = true;//kaisuo
			_peopleCenterPointX = StageProxy.stageWidth()/2;
			
		}
		
		/**
		 *彻底释放英雄资源 
		 * 
		 */		
		public function dispose():void
		{
			removeEventListener(Event.ENTER_FRAME, onHandleHeroPlay);
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			StageProxy.stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			removeAll();
			
			_walk.dispose();
			_idel.dispose();
			_jump.dispose();
			_attack.dispose();
			_beAttack.dispose(); 
			_attack1.dispose();  
			_attack2.dispose();  
			_effect1.dispose();  
			_effect2.dispose();  
			_effect3.dispose();  
			_dead.dispose();  
		}
		
		/**
		 *增加一个技能 
		 * @param id 技能id，如：h,l,u,i,o等
		 * 
		 */		
		public function addSkill(id :String):void
		{
			switch(id)
			{
				case 'h':
				{
					_isHEnable = true;
					break;
				}
					
				case 'l':
				{
					_isLEnable = true;
					break;
				}
					
				case 'u':
				{
					_isUEnable = true;
					break;
				}
					
				case 'i':
				{
					_isIEnable = true;
					break;
				}
					
				case 'o':
				{
					_isOEnable = true;
					break;
				}
			}
		}
		
		
		
		/**
		 *是否处在被攻击状态，进而处于受保护的时间 
		 * @return 
		 * 
		 */		
		public function get isHit():Boolean
		{
			return _isHit;
		}
		
		
	}
}