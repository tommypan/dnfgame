package game.view.mediator
{
	import fl.containers.UILoader;
	
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Video;
	
	import game.event.BattleEvent;
	import game.event.FightEvent;
	import game.event.MissionEvent;
	import game.model.ChapterEnemyModel;
	import game.model.HeroModel;
	import game.model.RewardModel;
	import game.model.SkillModel;
	import game.model.server.Calculate;
	import game.model.vo.EnemyVo;
	import game.model.vo.RewardVo;
	import game.service.SocketService;
	import game.view.enemys.BaseBoss;
	import game.view.enemys.BaseEnemy;
	import game.view.hero.HeroPlayer;
	import game.view.scene.BattleScene;
	import game.view.scene.ui.EnemyBan;
	import game.view.scene.ui.HintGo;
	import game.view.scene.ui.HitCombo;
	import game.view.scene.ui.RewardBox;
	import game.view.scene.ui.RoleBan;
	
	import Qmang2D.utils.Bezier;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.LayerCollection;
	import Qmang2D.protocol.SoundManager;
	
	import org.robotlegs.mvcs.Mediator;
	
	/**发生碰撞时，会出现振动 ||有少许情况
	 * 提示框 || 勉强解决
	 * 连击7下，敌人会后退 || 解决
	 * 自己后退后有段无敌时间,还不能跑动,alpha也会变化 || 还没有加英雄后退
	 * 打击的时候特效问题 || 可以优化,应该有一个层次问题||
	 * 自己播放时，技能完后没有站立||
	 * 敌人从头而降，没有走路播放动画 ||动画播放问题解决
	 * 时刻检查层次关系 ||有点卡，最后发现发行出来不是。是builder问题，顺带解决了死亡后信息马上移除问题，开始忘了vo，蛋疼
	 * 敌人打击英雄后，随机点没有判断边界 ||
	 * 层次之间的运动x，y问题。 ||
	 * 地图跑动问题
	 * 敌人飞翔动画扯淡 ||
	 * 连击 1，2,3没加(是针对英雄连击所有的敌人),在common里面||
	 * 加一些游戏当中的火球，等效果，看起来好炫||一部分加了
	 * 战斗胜利失败没加||
	 * 技能系统没做||缓动没有
	 * 3个go||
	 * 战斗评分没加
	 * 切换场景时，有时候addChild了两个英雄
	 * boss系统以及血条没加,敌将击破
	 * 现在就是合各种表现和流程了
	 * 引擎将movieCLip转换为bitmap渲染
	 * hangMan改版后期进行追踪
	 * 战斗中介
	 * @author aser_ph
	 * 
	 */	
	public class BattleMediator extends Mediator
	{
		[Inject]
		public var battleScene:BattleScene;
		
		[Inject]
		public var chapterEnemyModel :ChapterEnemyModel;
		
		[Inject]
		public var heroModel :HeroModel;
		
		[Inject]
		public var calculate :Calculate;
		
		[Inject]
		public var rewardModel :RewardModel;
		
		[Inject]
		public var skillModel :SkillModel;
		
		[Inject]
		public var socket :SocketService;
		
		private var _scene :int;
		
		/**
		 *当前关卡数 
		 */		
		private var missionNum :int;
		
		//------------------------------------------指向battleScene相关
		private var _hero :HeroPlayer;
		
		private var _enemyPlayers :Vector.<BaseEnemy>;
		
		private var leftRestriantX :int;
		
		private var rightRestriantX :int;
		
		//---------------------------------------------fly相关
		
		private var _flyPlayers :Vector.<BaseEnemy> = new Vector.<BaseEnemy>();
		
		private var _heroTotalHp :int;
		
		override public function onRegister():void
		{
			addContextListener(FightEvent.GOTO_NUM_FIGHT_SCENE_FOR_MEDIATOR,initBatlleScene);
			addContextListener(BattleEvent.ADD_HERO_SKILL, onAddHeroSill);
			eventMap.mapListener(battleScene,MissionEvent.GOTO_MAP_SCENE,gotoMapScene,MissionEvent);
			
			HitCombo.getInstance().addEventListener(BattleEvent.CLEAR_HEROMODEL_HITCONTER,onResetHeroHitCounter);
		}
		
		protected function onResetHeroHitCounter(event:Event):void
		{
			heroModel.hitCounter = 0;
		}		
		
		private function onAddHeroSill(e:BattleEvent):void
		{
			e.DATA is String && _hero.addSkill(e.DATA as String);
		}		
		
		/**
		 * when you click the sure button of world panel,this function would be excuted
		 * @param e
		 * 
		 */		
		private function gotoMapScene(e:MissionEvent):void
		{
			dispose();
			
			var evt:MissionEvent = new MissionEvent(MissionEvent.GOTO_MAP_SCENE_FOR_COMMAND);
			dispatch(evt);
		}
		
		
		//todo 血量没有重置	
		private function dispose():void
		{
			if(LayerCollection.uiLayer.contains(battleScene._soundOff) == true) 
				heroModel.soundOpen = false;
			else heroModel.soundOpen = true;
			
			var obj :Object = {};
			obj.id = heroModel.userName;
			obj.level = heroModel.level;
			obj.zhangong = heroModel.zhangong;
			obj.money = heroModel.money;
			obj.yuanbao = heroModel.yuanbao;
			
			if(heroModel.soundOpen)
				obj.soundOpen = 0;
			else obj.soundOpen = 1;
			
	//		socket.sendJSON(obj,2,2);
				
			_scene = 0;
			
			TimerManager.getInstance().remove(aiTest);
			battleScene.visible = false;
			battleScene.dispose();
			
			battleScene.removeEventListener(Event.ENTER_FRAME,onHandleFly);
			_hero.removeEventListener(BattleEvent.CHECK_HIT, checkHit);
			_hero.removeEventListener(BattleEvent.HIDE_SKILL_CD, hideSkillCD);
			_hero.removeEventListener(BattleEvent.RESET_SKILL_CD, resetSkillCD);
		}
		
		/**
		 *start battle and init the battle map and player 
		 * @param e
		 * 
		 */		
		private function initBatlleScene(e:FightEvent):void
		{
			
			
			battleScene.visible = true;
			
			
			battleScene.initBattleMap(e.currentMission);
			
			if(heroModel.soundOpen == false)
			{
				SoundManager.getInstance().MusicPuase();
				LayerCollection.uiLayer.addChild(battleScene._soundOff)
			}else{
				SoundManager.getInstance().playBgSound("battleBG",1);
				LayerCollection.uiLayer.addChild(battleScene._soundOn)
			}
			
			
			battleScene.initPlayer(chapterEnemyModel.enemyChapterVos,1);
			
			battleScene.updateRoleBan(heroModel.level,heroModel.money,heroModel.yuanbao,heroModel.zhangong);
			
			StageProxy.stage.addEventListener(MouseEvent.MOUSE_DOWN, onstartBattle);
			
			
		}
		
		
		
		/**
		 *start batlle now 
		 * @param e
		 * 
		 */		
		private function onstartBattle(e:MouseEvent):void
		{
			StageProxy.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onstartBattle);
			
			
			
			//已经匹配好的数据，绘制人物，玩家
			
			leftRestriantX = BattleScene.leftRestriantX;
			rightRestriantX = BattleScene.rightRestriantX;
			missionNum = battleScene._missionNum;
			
			_hero = battleScene._hero;
			_heroTotalHp = heroModel.hp;
			RoleBan.getInstance().addRedProgressBar(_heroTotalHp);
			
			addSkillBan();
			
			_hero.stop();
			_hero.playIdle();
			
			
			var data :Object = {speedX :heroModel.speedX,speedY :heroModel.speedY};
			_hero.dispatchEvent( new BattleEvent(BattleEvent.SEND_HERO_VO,data));
			_hero.addEventListener(BattleEvent.CHECK_HIT, checkHit);
			_hero.addEventListener(BattleEvent.HIDE_SKILL_CD, hideSkillCD);
			_hero.addEventListener(BattleEvent.RESET_SKILL_CD, resetSkillCD);
			
			_enemyPlayers = battleScene._enemys;
			
			HintGo.getInstance().addEventListener(Event.COMPLETE, startRender);
			battleScene.addEventListener(Event.ENTER_FRAME,onHandleFly);
			
		}
		
		private function resetSkillCD(event:BattleEvent):void
		{
			switch(event.DATA)
			{
				case 'h':
					RoleBan.getInstance().hSkillBan.visible = true;
					break;
				
				case 'l':
					RoleBan.getInstance().lSkillBan.visible = true;
					break;
				
				case 'u':
					RoleBan.getInstance().uSkillBan.visible = true;
					break;
				
				case 'i':
					RoleBan.getInstance().iSkillBan.visible = true;
					break;
				
				case 'o':
					RoleBan.getInstance().oSkillBan.visible = true;
					break;
			}
			
		}
		
		private function hideSkillCD(event:BattleEvent):void
		{
			switch(event.DATA)
			{
				case 'h':
					RoleBan.getInstance().hSkillBan.visible = false;
					break;
				
				case 'l':
					RoleBan.getInstance().lSkillBan.visible = false;
					break;
				
				case 'u':
					RoleBan.getInstance().uSkillBan.visible = false;
					break;
				
				case 'i':
					RoleBan.getInstance().iSkillBan.visible = false;
					break;
				
				case 'o':
					RoleBan.getInstance().oSkillBan.visible = false;
					break;
			}
		}
		
		private function addSkillBan():void
		{
			if(heroModel.isHEnable)
			{
				RoleBan.getInstance().updateSkillIcon('H');
				_hero.addSkill('h');
			}
			
			
			if(heroModel.isUEnable)
			{
				RoleBan.getInstance().updateSkillIcon('U');
				_hero.addSkill('u');
			}
			
			
			if(heroModel.isIEnable)
			{
				RoleBan.getInstance().updateSkillIcon('I');
				_hero.addSkill('i');
			}
			
			
			if(heroModel.isOEnable)
			{
				RoleBan.getInstance().updateSkillIcon('O');
				_hero.addSkill('o');
			}
			
			
			if(heroModel.isLEnable)
			{
				RoleBan.getInstance().updateSkillIcon('L');
				_hero.addSkill('l');
			}
			
		}		
		
		/**
		 *  start render the hero and enemy
		 * @param event
		 * 
		 */		
		private function startRender(event:Event):void
		{
			_hero.blendMode = BlendMode.NORMAL;
			TimerManager.getInstance().add(80, aiTest);//60
			_hero.play();
		}		
		
		private function aiTest():void
		{	
			var len :int = _enemyPlayers.length;
			for (var i:int = 0; i < _enemyPlayers.length; i++) //敌人与英雄之间间距检测
			{
				
				var enemy :BaseEnemy = _enemyPlayers[i];
				var enemyVo :EnemyVo = chapterEnemyModel.enemyChapterVos[i];
				
				//LayerCollection.mapOfWalkLayer.width   这个是以后的每个场景的width  每个战斗地图都分为4个左右的场景
				//不能超过340~590的范围
				
				if(enemyVo.hp <=0)	
				{
					
					if(LayerCollection.playerLayer.contains(enemy) == true && enemy.isFly == false)
					{
						LayerCollection.playerLayer.removeChild(enemy);
						enemy.dispose();
						_enemyPlayers.splice(i,1);
						chapterEnemyModel.enemyChapterVos.splice(i,1);
					}
					
				}else if(heroModel.hp<=0){
					
					battleScene._hero.playDead();
					
					//将派发一个战斗失败的事件
					
				}else if(enemy.isFly == true){	//接下来将loopHandle放在这里
					
					//trace("飞翔状态");
					
				}else if(enemy.isHit == true){
					
					//trace("敌人处于被打击状态");
				}else if(enemy.isCruise == true){	//敌人击打英雄后，应该游走
					
					enemy.walk();
					this.enemyCruise(enemy,enemyVo);
					
				}else if(enemy.isBeHit == true){
					
					//trace("敌人处于被打击状态");
					
				}else{	//正常追赶行走
					
					// 鲁棒检查
					(enemy.x<leftRestriantX) && (enemy.x = leftRestriantX);
					(enemy.x>rightRestriantX) && (enemy.x = rightRestriantX);
					(enemy.y<340) && (enemy.y = 340);
					(enemy.y>590) && (enemy.y = 590);
					
					
					var distanceX :int = enemy.x - _hero.x;
					var distanceY :int = enemy.y - _hero.y;
					var absX :int = Math.abs(distanceX);
					var absY :int = Math.abs(distanceY);
					var absDistance :int = Math.sqrt(absX * absX + absY * absY);
					
					if(absDistance > 800)	//站立
					{
						enemy.idel();
					}else if(absDistance <= 800 && absDistance >= 300 && absX > 6){	//简单走过去
						
						enemy.walk();
						
						if(distanceX >= 0)	//右
						{
							enemy.scaleX = 1;
							if(enemy is BaseBoss == false)
								enemy.redBloodProgress.scaleX = 1;
							enemy.x -= enemyVo.speedX;
							
						}else{	//左
							
							enemy.scaleX = -1;
							if(enemy is BaseBoss == false)
								enemy.redBloodProgress.scaleX = -1;
							enemy.x += enemyVo.speedX;
							
						}
						
						
					}else{	//准备好就开始攻击
						
						enemy.walk();
						enemySeekAndAttack(enemy,enemyVo);
						
					}//小于200判断结束
					
				}//(追赶行走)一个敌人判断结束
				
			}//for循环退出
			
			len = _enemyPlayers.length;
			checkDeep(len);
			
			
			checkBattleIsOver();
		}
		
		/**
		 *检查战斗是否应该进入下一个场景或者战斗结束 
		 * 
		 */		
		private function checkBattleIsOver():void
		{
			
			if(_enemyPlayers.length == 0)
			{
				_scene++;
				if(_scene == 1)
				{
					battleScene.initPlayer(chapterEnemyModel.enemyChapterVos,2);
					leftRestriantX = BattleScene.leftRestriantX;
					rightRestriantX = BattleScene.rightRestriantX;
				}else if(_scene == 2){
					battleScene.initPlayer(chapterEnemyModel.enemyChapterVos,3);
					leftRestriantX = BattleScene.leftRestriantX;
					rightRestriantX = BattleScene.rightRestriantX;
				}else{
					
					var rewardVo :RewardVo;
					switch(missionNum)
					{
						case 1:
						{
							rewardVo = rewardModel.reward1;
							break;
						}
							
						case 2:
						{
							rewardVo = rewardModel.reward2;
							break;
						}
							
						case 3:
						{
							rewardVo = rewardModel.reward3;
							break;
						}
							
						case 4:
						{
							rewardVo = rewardModel.reward4;
							break;
						}
							
						case 5:
						{
							rewardVo = rewardModel.reward5;
							break;
						}
							
							
						case 6:
						{
							rewardVo = rewardModel.reward6;
							break;
						}
							
						case 7:
						{
							rewardVo = rewardModel.reward7;
							break;
						}
							
						case 8:
						{
							rewardVo = rewardModel.reward8;
							break;
						}
					}
					
					heroModel.addSkill(rewardVo.skillId);
					heroModel.level = heroModel.level + rewardVo.levelUp;
					heroModel.money = heroModel.money + rewardVo.money;
					heroModel.yuanbao += 1000;
					heroModel.zhangong += 1000;
					battleScene.addReward(rewardVo.skillId,skillModel,rewardVo.levelUp,rewardVo.money,1000,1000);
					battleScene.updateRoleBan(heroModel.level,heroModel.money,heroModel.yuanbao,heroModel.zhangong);
					
					TimerManager.getInstance().remove( aiTest);
					battleScene.removeEventListener(Event.ENTER_FRAME,onHandleFly);
					
				}
			}
			
			if(heroModel.hp <= 0)
			{
				battleScene.addFail();
				TimerManager.getInstance().remove( aiTest);
				battleScene.removeEventListener(Event.ENTER_FRAME,onHandleFly);
				_scene = 0;
			}
			
			
		}		
		
		/**
		 * 深度检查
		 * @param len需要检查深度的敌人数量
		 * 
		 */		
		private function checkDeep(len:int):void
		{
			//LayerCollection.playerLayer.swapChildrenAt	效率如何，有待测试
			
			var deepArray:Array = new Array();
			for (var i2:int = 0; i2 < len; i2++) 
			{
				deepArray.push({index: i2, y:_enemyPlayers[i2].y});
				LayerCollection.playerLayer.removeChild(_enemyPlayers[i2]);
			}
			
			deepArray.push({index: len, y:_hero.y});
			LayerCollection.playerLayer.removeChild(_hero);
			
			deepArray.sortOn("y", Array.NUMERIC);
			var index :int;
			for (var j:int = 0; j <  len + 1; j++) 
			{
				index = deepArray[j].index;
				if(index ==  _enemyPlayers.length)	LayerCollection.playerLayer.addChild(_hero);
				else LayerCollection.playerLayer.addChild(_enemyPlayers[index]);
			}
			
			
		}
		
		/**
		 *敌人找寻英雄运动 ，寻找敌人，伺机攻击
		 * @param enemy
		 * @param enemyVo
		 * 
		 */			
		private function enemySeekAndAttack(enemy:BaseEnemy, enemyVo:EnemyVo): void
		{
			//应该随机走到竖直方向，然后斜向攻击
			
			var distanceX :int = enemy.x - _hero.x;
			var distanceY :int = enemy.y - _hero.y;
			var absX :int = Math.abs(distanceX);
			
			
			if(enemy.isWalkStraight == true)//向上向下走
			{
				if(enemy.y < 440)
				{
					enemy.y -= enemyVo.speedY;
				}else if(enemy.y >= 440){
					enemy.y += enemyVo.speedY;
				}
				
				if(enemy.y <= 355 || enemy.y >= 580) 
					enemy.isWalkStraight = false;
				
			}else{	//斜向
				
				if(distanceX >= 0 && distanceY <= 0)//右上
				{
					enemy.scaleX = 1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = 1;
					enemy.x -= enemyVo.speedX;
					(distanceY < -5) && (enemy.y += enemyVo.speedY);
					
				}else if(distanceX > 0 && distanceY > 0){//右下
					
					enemy.scaleX = 1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = 1;
					enemy.x -= enemyVo.speedX;
					enemy.y -= enemyVo.speedY;
					
				}else if(distanceX < 0 && distanceY < 0){//左上
					
					enemy.scaleX = -1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = -1;
					enemy.x += enemyVo.speedX;
					(distanceY < -5) && (enemy.y += enemyVo.speedY);
					
				}else if(distanceX < 0 && distanceY > 0){//左下
					
					enemy.scaleX = -1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = -1;
					enemy.x += enemyVo.speedX;
					enemy.y -= enemyVo.speedY;
					
				}
				
				if(absX < 50)
				{
					enemy.attack();
					checkHit();
					enemy.isWalkStraight = true;
					enemy.isCruise = true;
					
					
					var point :Point = new Point();
					point.y = int(Math.random()*250 + 340);
					var temp :Number = Math.random();
					if(temp>=0.5)
						point.x = int(_hero.x+Math.random()*500);
					else
						point.x = int(_hero.x-Math.random()*500);
					
					
					(point.x < leftRestriantX) && (point.x = leftRestriantX);
					(point.x > rightRestriantX) && (point.x = rightRestriantX);
					
					enemy.destPoint = point;
					
					
				}//斜向攻击状态结束
				
			}//直走和攻击状态结束
		}
		
		
		/**
		 *游弋运动，敌人打击英雄后，有一段的游弋时间 
		 * @param enemy
		 * @param enemyVo
		 * 
		 */		
		private function enemyCruise(enemy:BaseEnemy, enemyVo:EnemyVo):void
		{
			var point :Point = enemy.destPoint;
			
			
			if(Math.abs(point.x - enemy.x) >5 )
			{
				if(point.x - enemy.x >= 0)	//目的点在敌人右边
				{
					enemy.scaleX = -1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = -1;
					enemy.x += enemyVo.speedX;
					if(point.y - enemy.y > 5)	//防止出现抖动
					{
						if(point.y - enemy.y >= 0)	//下边 出现抖动原因
						{
							enemy.y += enemyVo.speedY;
						}else{
							enemy.y -= enemyVo.speedY;
						}
					}
				}else{	//目的点在敌人左边
					
					enemy.scaleX = 1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = 1;
					enemy.x -= enemyVo.speedX;
					if(point.y - enemy.y > 5)
					{
						if(point.y - enemy.y >= 0)
						{
							enemy.y += enemyVo.speedY;
						}else{
							enemy.y -= enemyVo.speedY;
						}
					}
				}
			}else{
				enemy.isCruise = false;
			}
			
		}		
		
		/**
		 *时刻检查飞翔 
		 * @param event
		 * 
		 */
		private function onHandleFly(event:Event):void
		{
			var flyEnemy :BaseEnemy;
			
			for (var i:int = 0; i < _flyPlayers.length; i++) 
			{
				flyEnemy = _flyPlayers[i];
				if(flyEnemy.isFly == true)
				{
					var tmpArr:Array = flyEnemy.bezier.getAnchorPoint(flyEnemy.curStp);
					
					if(flyEnemy.x >= rightRestriantX) flyEnemy.x =  rightRestriantX;
					else if(flyEnemy.x <= leftRestriantX) flyEnemy.x =  leftRestriantX;
					else flyEnemy.x =  tmpArr[0];
					
					flyEnemy.y =  tmpArr[1];
					
					flyEnemy.curStp++;
					if(flyEnemy.curStp>flyEnemy.steps)
					{
						flyEnemy.curStp = 0;		//当前步
						flyEnemy.bezier = null;
						_flyPlayers.splice(i,1);
					}
				}
			}
			
		}
		
		/**
		 *碰撞检查 
		 * @param event
		 * 
		 */		
		private function checkHit(event:BattleEvent = null):void
		{
			
			var len :uint = _enemyPlayers.length;
			var enemy :BaseEnemy;
			var enemyVo :EnemyVo;
			var loseHp :int;
			for (var i:int = 0; i < len; i++) 
			{
				
				enemy   = _enemyPlayers[i];
				enemyVo =  chapterEnemyModel.enemyChapterVos[i];
				
				
				
				if(!event)
				{
					
					if(Math.abs(enemy.y - _hero.y) < enemyVo.attackHeight
						&& enemy.hitTestObject(_hero) && !_hero.isHit)
					{
						loseHp = calculate.calculateHit(5,Math.random()*10,heroModel.defenceNum);
						trace("英雄减少的血量是：",loseHp);
						
						(loseHp > 70)  ? _hero.playBeAttack(true) : _hero.playBeAttack(false);
						
						if(enemy is BaseBoss)
						{
							BaseBoss(enemy).attack2();
						}else{
							enemy.attack();
						}
						heroModel.hp -= loseHp;
						RoleBan.getInstance().upDateRedBlood(heroModel.hp,_heroTotalHp);
						
						if(heroModel.hp <= 0)
							_hero.playDead();
					}
					
				}else{
					
					SoundManager.getInstance().playEffectSound("sdAttack1",1);
					if(Math.abs(enemy.y - _hero.y) < heroModel.attackHeight
						&& enemy.hitTestObject(_hero) && enemyVo.hp >= 0 && !enemy.isFly)
					{
						
						loseHp = calculate.calculateHit(event.DATA,Math.random()*10,enemyVo.defenceNum);
						trace("敌人减少的血量是：",loseHp);
						SoundManager.getInstance().playEffectSound("sdAttack3",1);
						heroModel.hitCounter++;
						HitCombo.getInstance().addHitCombo(heroModel.hitCounter);
						enemyVo.hp -= loseHp;
						if(enemy is BaseBoss)
						{
							EnemyBan.getInstance().updateBlood(enemyVo.hp);
						}else{
							enemy.updateBlood(enemyVo.hp);
						}
						
						enemyBeHit(enemy,enemyVo);
						
					}
					
				} //碰撞检查
			} //循环结束
			
		}//方法结束
		
		
		/**
		 *敌人被打击后 
		 * @param enemy
		 * @param enemyVo
		 * 
		 */		
		private function enemyBeHit(enemy:BaseEnemy, enemyVo:EnemyVo):void
		{
			
			enemy.beAttack();
			battleScene.hitEffet( new Point(enemy.x, enemy.y - 100) );
			
			enemyVo.hitCounter++;
			if(enemyVo.hitCounter/7 is int || enemyVo.hp <= 0)
			{
				enemy.fly();
				
				var instanceX :int = enemy.x - _hero.x;
				
				if(instanceX>=0)
				{
					enemy.scaleX = 1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = 1;
					controlPoint = new Point(enemy.x+150,enemy.y-200); 
					endPoint = new Point(enemy.x +300,enemy.y); 
				}else{
					enemy.scaleX = -1;
					if(enemy is BaseBoss == false)
						enemy.redBloodProgress.scaleX = -1;
					controlPoint = new Point(enemy.x - 150,enemy.y-200); 
					endPoint = new Point(enemy.x - 300,enemy.y); 
				}
				
				
				var controlPoint:Point;
				var endPoint:Point;
				var startPoint :Point = new Point(enemy.x,enemy.y); 
				
				var bezier :Bezier = new Bezier();
				enemy.steps = bezier.init(startPoint,controlPoint,endPoint,10);
				enemy.bezier = bezier;
				
				for (var j:int = 0; j < _flyPlayers.length; j++) 
				{
					if(enemy.name == _flyPlayers[j].name)
						return;
				}
				_flyPlayers.push(enemy);
			}
			
		}
		
		
		
		
	}
}