package game.view.scene
{
	import Qmang2D.pool.ObjectPool;
	import Qmang2D.pool.ObjectPoolManager;
	import Qmang2D.protocol.LayerCollection;
	import Qmang2D.protocol.SoundManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	
	import com.gs.TweenLite;
	
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import game.event.MissionEvent;
	import game.model.SkillModel;
	import game.model.vo.EnemyVo;
	import game.view.enemys.BaseBoss;
	import game.view.enemys.BaseEnemy;
	import game.view.enemys.Boss101;
	import game.view.enemys.Boss102;
	import game.view.enemys.Boss103;
	import game.view.enemys.Boss104;
	import game.view.enemys.Boss105;
	import game.view.enemys.Boss106;
	import game.view.enemys.Boss107;
	import game.view.enemys.Boss108;
	import game.view.enemys.Enemy101;
	import game.view.enemys.Enemy102;
	import game.view.enemys.Enemy103;
	import game.view.enemys.Enemy104;
	import game.view.enemys.Enemy105;
	import game.view.enemys.Enemy106;
	import game.view.enemys.Enemy107;
	import game.view.enemys.Enemy108;
	import game.view.enemys.Enemy109;
	import game.view.enemys.Enemy110;
	import game.view.enemys.Enemy111;
	import game.view.enemys.Enemy112;
	import game.view.enemys.Enemy113;
	import game.view.hero.HeroPlayer;
	import game.view.maps.BaseMap;
	import game.view.maps.BattleMap1;
	import game.view.maps.BattleMap2;
	import game.view.maps.BattleMap3;
	import game.view.maps.BattleMap4;
	import game.view.maps.BattleMap5;
	import game.view.maps.BattleMap6;
	import game.view.maps.BattleMap7;
	import game.view.maps.BattleMap8;
	import game.view.scene.ui.AlertBan;
	import game.view.scene.ui.BattleResultPanel;
	import game.view.scene.ui.BattleSceneBoard;
	import game.view.scene.ui.Cool;
	import game.view.scene.ui.EnemyBan;
	import game.view.scene.ui.HintGo;
	import game.view.scene.ui.HitEffect;
	import game.view.scene.ui.RewardBox;
	import game.view.scene.ui.RoleBan;
	import game.view.scene.ui.SimpleGo;
	
	
	public class BattleScene extends Sprite
	{
		
		//--------------------------------对象池相关
		private var _objPool1:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy101);
		private var _objPool2:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy102);
		private var _objPool3:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy103);
		private var _objPool4:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy104);
		private var _objPool5:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy105);
		private var _objPool6:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy106);
		private var _objPool7:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy107);
		private var _objPool8:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy108);
		private var _objPool9:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy109);
		private var _objPool10:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy110);
		private var _objPool11:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy111);
		private var _objPool12:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy112);
		private var _objPool13:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Enemy113);
		
		
		private var _objPool14:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss101,1);
		private var _objPool15:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss102,1);
		private var _objPool16:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss103,1);
		private var _objPool17:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss104,1);
		private var _objPool18:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss105,1);
		private var _objPool19:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss106,1);
		private var _objPool20:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss107,1);
		private var _objPool21:ObjectPool = ObjectPoolManager.getInstance().getObjectPool(Boss108,1);
		private var _hitEffectPool :ObjectPool = ObjectPoolManager.getInstance().getObjectPool(HitEffect,10);
		
		
		
		/**开始打斗的地图*/
		public var bgMap:MovieClip;
		
		/**开始移动的地图*/
		public var walkMap:MovieClip;
		
		//与此类的实例同生死共存亡
		public var _hero:HeroPlayer = new HeroPlayer();
		
		public var _enemys:Vector.<BaseEnemy> = new Vector.<BaseEnemy>();
		
		private var flWorldMapBtn:SimpleButton;
		
		private var _roleBan:RoleBan = RoleBan.getInstance();;
		
		public var _soundOn :SimpleButton;
		
		public var _soundOff :SimpleButton;
		
		/**
		 *当前战斗关卡数 
		 */		
		public var _missionNum:int;
		
		private var battleMap:BaseMap;
		
		private var alert:AlertBan;
		
		private var _isAlertOpen :Boolean;
		
		private var _pauseModal :MovieClip;
		
		private var _isPause :Boolean;
		
		
		private var _simpleGo :SimpleGo;
		
		
		private var _skillIcon :MovieClip;
		
		private var _skillId :String;
		
		/**
		 *場景的左x界限 
		 */		
		public static var leftRestriantX :int;
		
		/**
		 *場景的右x界限 
		 */		
		public static var rightRestriantX :int;
		
		private var successMc:MovieClip;
		
		/**
		 *上一个场景 
		 */		
		private var _preScene:int = 1;
		
		public function BattleScene()
		{
			addChild(LayerCollection.mapOfBgLayer);
			addChild(LayerCollection.mapOfWalkLayer);
			LayerCollection.playerLayer.addChild(LayerCollection.effectLayer);
			addChild(LayerCollection.uiLayer);
			
		}
		
		/**
		 * 绘制相应的战斗关卡地图
		 * @param num
		 * 
		 */		
		public function initBattleMap(num:int):void
		{
			_missionNum = num;
			
			switch(_missionNum)
			{
				case 1:
				{
					battleMap = new BattleMap1();
					break;
				}
					
				case 2:
				{
					battleMap = new BattleMap2();
					break;
				}
					
				case 3:
				{
					battleMap = new BattleMap3();
					break;
				}
					
				case 4:
				{
					battleMap = new BattleMap4();
					break;
				}
					
				case 5:
				{
					battleMap = new BattleMap5();
					break;
				}
					
				case 6:
				{
					battleMap = new BattleMap6();
					break;
				}
					
				case 7:
				{
					battleMap = new BattleMap7();
					break;
				}
					
				case 8:
				{
					battleMap = new BattleMap8();
					break;
				}
					
				default:
				{
					throw new Error("未知地图索引");
					break;
				}
			}
			
			LayerCollection.mapOfWalkLayer.addChild(LayerCollection.playerLayer);
			
			LayerCollection.uiLayer.addChild(_roleBan);
			
			
			
			flWorldMapBtn = ClassManager.createInstance("FlWorldMapBtn") as SimpleButton;
			LayerCollection.uiLayer.addChild(flWorldMapBtn);
			flWorldMapBtn.x = StageProxy.stageWidth() - 60;
			flWorldMapBtn.y = 15;
			flWorldMapBtn.addEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
			
			_soundOn = ClassManager.createInstance("soundOn") as SimpleButton;
			_soundOff = ClassManager.createInstance("soundOff") as SimpleButton;
			
			
			_soundOn.x = StageProxy.stageWidth() - 100;
			_soundOn.y = 15;
			_soundOn.addEventListener(MouseEvent.CLICK, onPlaySound);
			
			_soundOff.x = StageProxy.stageWidth() - 100;
			_soundOff.y = 15;
			_soundOff.addEventListener(MouseEvent.CLICK, onStopSound);
			
			addEventListener(Event.DEACTIVATE, autoPause);
			addEventListener(Event.ACTIVATE, autoPause);
		}
		
		private function onPlaySound(event:MouseEvent):void
		{
			
			SoundManager.getInstance().MusicPuase();
			LayerCollection.uiLayer.removeChild(_soundOn);
			LayerCollection.uiLayer.addChild(_soundOff);
		}
		
		private function onStopSound(event:MouseEvent):void
		{
			SoundManager.getInstance().playEffectSound("click",1);
			SoundManager.getInstance().playBgSound("battleBG",1);
			LayerCollection.uiLayer.removeChild(_soundOff);
			LayerCollection.uiLayer.addChild(_soundOn);
		}
		
		/**
		 *显示初始化玩家  
		 * @param vector
		 * @param scene玩家处于第几个场景
		 * 
		 */			
		public function initPlayer(vector:Vector.<EnemyVo>,scene :int):void
		{
			var enemy :BaseEnemy;
			var len :uint = vector.length;
			for (var i:int = 0; i < len; i++) 
			{
				if(vector[i].scene == scene)
				{
					switch(vector[i].id)
					{
						case '1':
						{
							enemy = _objPool1.getObject() as BaseEnemy;
							break;
						}
						case '2':
						{
							enemy = _objPool2.getObject() as BaseEnemy;
							break;
						}
						case '3':
						{
							enemy = _objPool3.getObject() as BaseEnemy;
							break;
						}
						case '4':
						{
							enemy = _objPool4.getObject() as BaseEnemy;
							break;
						}
						case '5':
						{
							enemy = _objPool5.getObject() as BaseEnemy;
							break;
						}
						case '6':
						{
							enemy = _objPool6.getObject() as BaseEnemy;
							break;
						}
						case '7':
						{
							enemy = _objPool7.getObject() as BaseEnemy;
							break;
						}
						case '8':
						{
							enemy = _objPool8.getObject() as BaseEnemy;
							break;
						}
						case '9':
						{
							enemy = _objPool9.getObject() as BaseEnemy;
							break;
						}
						case '10':
						{
							enemy = _objPool10.getObject() as BaseEnemy;
							break;
						}
						case '11':
						{
							enemy = _objPool11.getObject() as BaseEnemy;
							break;
						}
						case '12':
						{
							enemy = _objPool12.getObject() as BaseEnemy;
							break;
						}
						case '13':
						{
							enemy = _objPool13.getObject() as BaseEnemy;
							break;
						}
						case '14':
						{
							enemy = _objPool14.getObject() as BaseBoss;
							break;
						}
						case '15':
						{
							enemy = _objPool15.getObject() as BaseBoss;
							break;
						}
						case '16':
						{
							enemy = _objPool16.getObject() as BaseBoss;
							break;
						}
						case '17':
						{
							enemy = _objPool17.getObject() as BaseBoss;
							break;
						}
						case '18':
						{
							enemy = _objPool18.getObject() as BaseBoss;
							break;
						}
						case '19':
						{
							enemy = _objPool19.getObject() as BaseBoss;
							break;
						}
						case '20':
						{
							enemy = _objPool20.getObject() as BaseBoss;
							break;
						}
						case '21':
						{
							enemy = _objPool21.getObject() as BaseBoss;
							break;
						}
						default:
						{
							break;
						}
					}
					
					enemy.x = vector[i].x;
					enemy.y = vector[i].y;
					enemy.id = vector[i].id;
					enemy.idel();
					
					
					if(enemy is BaseBoss)
					{
						EnemyBan.getInstance().addProgressBlood(vector[i].hp);
					}else{
						enemy.addProgressBar(vector[i].hp);
					}
					
					LayerCollection.playerLayer.addChild(enemy);
					_enemys.push(enemy);
				}//if结束
			}//循环结束
			
			//場景活動範圍
			if(scene == 1){
				
				leftRestriantX = 0;
				rightRestriantX = 1600;
				
				if(LayerCollection.playerLayer.contains(_hero) == false)
				{
					LayerCollection.playerLayer.addChild(_hero);
					_hero.blendMode = BlendMode.INVERT;
				}else{
					_hero.play();
				}
				_hero.x = 100;_hero.y = StageProxy.stageHeight()/2;
				
				
				BattleSceneBoard.getInstance().show("潘大帅哥:","把那些畜生给我往死里打----(^-^)");
				BattleSceneBoard.getInstance().addEventListener(Event.COMPLETE, onShowHintGo);
			}else if(scene == 2){
				
				leftRestriantX = 750;
				rightRestriantX = 2350;
				
				if(_hero.x <= leftRestriantX)
					_hero.x = 610;
				
				
				_simpleGo = new SimpleGo();
				LayerCollection.uiLayer.addChild(_simpleGo);
				_simpleGo.x = StageProxy.stageWidth()-800;_simpleGo.y = 300;
			}else if(scene == 3){
				
				leftRestriantX = 1500;
				rightRestriantX = 3100;
				
				if(_hero.x <= leftRestriantX)
					_hero.x = 1610;
				
				
				_simpleGo = new SimpleGo();
				LayerCollection.uiLayer.addChild(_simpleGo);
				_simpleGo.x =StageProxy.stageWidth()-800;_simpleGo.y = 300;
				
			}
			
			
			//			var mc :MovieClip = ClassManager.createDisplayObjectInstance("A2") as MovieClip;
			//			LayerCollection.playerLayer.addChild(mc);
			//			mc.x =300;mc.y= 300;
			//			
			//			var mc :MovieClip = ClassManager.createDisplayObjectInstance("A3") as MovieClip;
			//			LayerCollection.playerLayer.addChild(mc);
			//			mc.x =1100;mc.y= 250;
			//			
			//			//-------------------------
			//			var mc :MovieClip = ClassManager.createDisplayObjectInstance("A1") as MovieClip;
			//			LayerCollection.playerLayer.addChild(mc);
			//			mc.x =600;mc.y= 450;
			//			
			//			var mc :MovieClip = ClassManager.createDisplayObjectInstance("A4") as MovieClip;
			//			LayerCollection.playerLayer.addChild(mc);
			//			mc.x =600;mc.y= 50;
			if(_preScene != scene){
				_hero.x = leftRestriantX;
				LayerCollection.mapOfWalkLayer.x = -leftRestriantX;
				HeroPlayer._peopleCenterPointX = leftRestriantX+StageProxy.stageWidth()/2;
			}
			_preScene = scene;////////////////////////////////////////////////////////////////////
			
		}
		
		/**
		 *当战斗场景模板完成后，在继续hintGo提示 
		 * @param event
		 * 
		 */		
		private function onShowHintGo(event:Event):void
		{
			BattleSceneBoard.getInstance().removeEventListener(Event.COMPLETE,onShowHintGo);
			HintGo.getInstance().show();
			
		}
		
		private function onWorldMapBtnClick(event:MouseEvent):void
		{
			SoundManager.getInstance().playEffectSound("click",1);
			flWorldMapBtn.removeEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
			if(!_isAlertOpen)
			{
				alert = new AlertBan(sureFun,cancelFun);
				LayerCollection.uiLayer.addChild(alert);
				alert.scaleX = 0;
				alert.scaleY = 0;
				alert.x = StageProxy.stageWidth();
				
				TweenLite.to(alert,1,{scaleX:1,scaleY:1,x:500,y:220,onComplete:onOpenFinish});
				function onOpenFinish():void
				{
					flWorldMapBtn.addEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
				}
				_isAlertOpen = true
			}else{
				TweenLite.to(alert,1,{scaleX:0,scaleY:0,x:StageProxy.stageWidth(),y:0,onComplete:onCloseFinish});
				function onCloseFinish():void
				{
					LayerCollection.uiLayer.removeChild(alert);
					flWorldMapBtn.addEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
				}
				
				_isAlertOpen = false;
			}
			
		}
		
		private function cancelFun():void
		{
			SoundManager.getInstance().playEffectSound("click",1);
			alert.dispose();
			//flWorldMapBtn.removeEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
			_isAlertOpen = false;
			LayerCollection.uiLayer.removeChild(alert);
			return;
		}
		
		private function sureFun():void
		{
			SoundManager.getInstance().playEffectSound("click",1);
			if(alert && LayerCollection.uiLayer.contains(alert))
			{
				alert.dispose();
				LayerCollection.uiLayer.removeChild(alert);
			}
			
			flWorldMapBtn.removeEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
			updateSkill();
			dispatchEvent(new MissionEvent(MissionEvent.GOTO_MAP_SCENE));
		}
		
		
		/**
		 * 
		 * @param level
		 * @param money
		 * @param yuanbao
		 * @param zhangong
		 * 
		 */
		public function updateRoleBan(level:int,money:int,yuanbao:int,zhangong:int):void
		{
			RoleBan.getInstance().lvText.text = String(level);
			RoleBan.getInstance().moneyText.text = String(money);
			RoleBan.getInstance().yuanBaoText.text = String(yuanbao);
			RoleBan.getInstance().battlePowerText.text = String(zhangong);
		}
		
		
		
		/**
		 *过关奖励 
		 * 
		 */		
		public function addReward(skillId:String,skillModel:SkillModel,level:int,money:int,yuanbao:int,zhangong:int):void
		{
			flWorldMapBtn.removeEventListener(MouseEvent.CLICK, onWorldMapBtnClick);
			
			
			_hero.addSkill(skillId); 
			
			_skillId = skillId
			RewardBox.getInstance().addEventListener(Event.COMPLETE, updateSkill);
			
			switch(skillId)
			{
				case 'u':
					_skillIcon = ClassManager.createDisplayObjectInstance("USkill") as MovieClip;
					RewardBox.getInstance().jiNengName = skillModel.uSkillVo.describe;
					break;
				
				case 'i':
					_skillIcon = ClassManager.createDisplayObjectInstance("ISkill") as MovieClip;
					RewardBox.getInstance().jiNengName = skillModel.iSkillVo.describe;
					break;
				
				case 'o':
					_skillIcon = ClassManager.createDisplayObjectInstance("OSkill") as MovieClip;
					RewardBox.getInstance().jiNengName = skillModel.oSkillVo.describe;
					break;
				
				case 'h':
					_skillIcon = ClassManager.createDisplayObjectInstance("HSkill") as MovieClip;
					RewardBox.getInstance().jiNengName = skillModel.hSkillVo.describe;
					break;
				
				case 'l':
					_skillIcon = ClassManager.createDisplayObjectInstance("LSkill") as MovieClip;
					RewardBox.getInstance().jiNengName = skillModel.lSkillVo.describe;
					break;
			}
			
			RewardBox.getInstance().show(222,_skillIcon);
			
			
			var point :Point = new Point(_hero.x,_hero.y);
			LayerCollection.playerLayer.removeChild(_hero);
			point = LayerCollection.playerLayer.localToGlobal(point);
			
			Cool.getInstance().show(point);
			LayerCollection.uiLayer.addChild(_hero);
			_hero.x = point.x; _hero.y = point.y;
			_hero.blendMode = BlendMode.INVERT;
			TimerManager.getInstance().add(6000,showBattleResult);
			function showBattleResult():void
			{
				
				TimerManager.getInstance().remove(showBattleResult);
				_hero.blendMode = BlendMode.NORMAL;
				Cool.getInstance().hide();
				BattleResultPanel.getInstance().addEventListener(MouseEvent.CLICK, onShowLevelUpBowl);
				var jiqiao :int = Math.random() *1500 + 500;
				var time :int = Math.random() *1000 + 1000;
				var lianji :int = Math.random() *1000 + 1000;
				var shadi :int = Math.random() *500 + 1500;
				BattleResultPanel.getInstance().show(level,zhangong,yuanbao,jiqiao,time,lianji,shadi);
				function onShowLevelUpBowl(event:MouseEvent):void
				{
					BattleResultPanel.getInstance().removeEventListener(MouseEvent.CLICK, onShowLevelUpBowl);
					
					if(level > 0)
					{
						SoundManager.getInstance().playEffectSound("levelUp",1);
						successMc = ClassManager.createDisplayObjectInstance("HintSuccess") as MovieClip;
						addChild(successMc);
						successMc.x =_hero.x;successMc.y= _hero.y-80;
						successMc.gotoAndPlay(29);
						TimerManager.getInstance().add(1200,fadeSuccess);
					}
					
					
				}
				
				
			}
			
		}
		
		
		protected function updateSkill(event:Event = null):void
		{
			
			if(event)
			{
				RewardBox.getInstance().removeEventListener(Event.COMPLETE, updateSkill);
				TimerManager.getInstance().add(2000,goBackWorld);
				
			}
			
			switch(_skillId)
			{
				case 'u':
					RoleBan.getInstance().updateSkillIcon('U');
					break;
				
				case 'i':
					RoleBan.getInstance().updateSkillIcon('I');
					break;
				
				case 'o':
					RoleBan.getInstance().updateSkillIcon('O');
					break;
				
				case 'h':
					RoleBan.getInstance().updateSkillIcon('H');
					break;
				
				case 'l':
					RoleBan.getInstance().updateSkillIcon('L');
					break;
			}
		}	
		
		private function goBackWorld():void
		{
			TimerManager.getInstance().remove(goBackWorld);
			dispatchEvent(new MissionEvent(MissionEvent.GOTO_MAP_SCENE));
		}		
		
		private function fadeSuccess():void
		{
			TimerManager.getInstance().remove(fadeSuccess);
			successMc.stop();
			removeChild(successMc);
		}
		
		
		
		/**
		 * 战斗失败,展示失败ui
		 * 
		 */		
		public function addFail():void
		{
			BattleSceneBoard.getInstance().show("勇士们","我挂了~~呜呜");
			StageProxy.stage.addEventListener(MouseEvent.MOUSE_DOWN, onBattleFailToWorld);
			
		}
		
		protected function onBattleFailToWorld(event:MouseEvent):void
		{
			sureFun();
			StageProxy.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onBattleFailToWorld);
		}		
		
		
		
		/**
		 * 击打特效
		 * @param point
		 * 
		 */		
		public function hitEffet(point :Point):void
		{
			
			var hitEffct :HitEffect = _hitEffectPool.getObject() as HitEffect;
			LayerCollection.effectLayer.addChild(hitEffct);
			var transformPoint :Point = hitEffct.globalToLocal(LayerCollection.playerLayer.localToGlobal(point));
			hitEffct.x = transformPoint.x; hitEffct.y = transformPoint.y;
			hitEffct.play();
		}
		
		
		/**
		 *自动暂停游戏 
		 * 
		 */		
		public function autoPause(e:Event):void
		{
			if(!_isPause)
			{
				_pauseModal = ClassManager.createInstance("LostFocus") as MovieClip;
				LayerCollection.uiLayer.addChild(_pauseModal);
				_pauseModal.x = StageProxy.stageWidth()/2;
				_pauseModal.y = StageProxy.stageHeight()/2;
				_isPause = true;
			}else{
				LayerCollection.uiLayer.removeChild(_pauseModal);
				_isPause = false;
			}
		}
		
		
		/**
		 *退出场景时，释放资源 
		 * 
		 */		
		public function dispose():void
		{
			
			var len :int = _enemys.length;
			for (var i:int = 0; i < len; i++) 
			{
				var enemyPlayer :BaseEnemy = _enemys.pop();
				(LayerCollection.playerLayer.contains(enemyPlayer) == true) && LayerCollection.playerLayer.removeChild(enemyPlayer);
				enemyPlayer.dispose();
				
				switch(enemyPlayer.id)
				{
					case '1':
					{
						_objPool1.releaseObject(enemyPlayer);
						break;
					}
					case '2':
					{
						_objPool2.releaseObject(enemyPlayer);
						break;
					}
					case '3':
					{
						_objPool3.releaseObject(enemyPlayer);
						break;
					}
					case '4':
					{
						_objPool4.releaseObject(enemyPlayer);
						break;
					}
					case '5':
					{
						_objPool5.releaseObject(enemyPlayer);
						break;
					}
					case '6':
					{
						_objPool6.releaseObject(enemyPlayer);
						break;
					}
					case '7':
					{
						_objPool7.releaseObject(enemyPlayer);
						break;
					}
					case '8':
					{
						_objPool8.releaseObject(enemyPlayer);
						break;
					}
					case '9':
					{
						_objPool9.releaseObject(enemyPlayer);
						break;
					}
					case '10':
					{
						_objPool10.releaseObject(enemyPlayer);
						break;
					}
					case '11':
					{
						_objPool11.releaseObject(enemyPlayer);
						break;
					}
					case '12':
					{
						_objPool12.releaseObject(enemyPlayer);
						break;
					}
					case '13':
					{
						_objPool13.releaseObject(enemyPlayer);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			
			//只是停止播放，移除监听
			_hero.dispose();
			
			battleMap.dispose();
			
			
			LayerCollection.mapOfWalkLayer.removeChild(LayerCollection.playerLayer);
			LayerCollection.mapOfWalkLayer.x = 0;
			LayerCollection.mapOfBgLayer.x = 0;
			
			LayerCollection.uiLayer.removeChild(flWorldMapBtn);
			flWorldMapBtn.removeEventListener(MouseEvent.CLICK,onWorldMapBtnClick);
			
			LayerCollection.uiLayer.contains(_soundOff) && 
			LayerCollection.uiLayer.removeChild(_soundOff);
			
			LayerCollection.uiLayer.contains(_soundOn) && 
			LayerCollection.uiLayer.removeChild(_soundOn);
			
			
			HintGo.getInstance().hide();
			RewardBox.getInstance().hide();
			BattleResultPanel.getInstance().hide();
			
			removeEventListener(Event.DEACTIVATE, autoPause);
			removeEventListener(Event.ACTIVATE, autoPause);
			
			EnemyBan.getInstance().updateBlood(0);
			if(_pauseModal && LayerCollection.uiLayer.contains(_pauseModal))
				LayerCollection.uiLayer.removeChild(_pauseModal);
			_isPause = false;
			_isAlertOpen = false;
			_skillId = "";
		}
		
		
		
	}
}