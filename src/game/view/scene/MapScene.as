package game.view.scene
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.MouseEvent;
	
	import flashx.textLayout.operations.MoveChildrenOperation;
	
	import game.event.MissionEvent;
	import game.view.hero.IDLE;
	import game.view.hero.WALK;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	import Qmang2D.utils.StageProxy;
	import Qmang2D.utils.TimerManager;
	import Qmang2D.protocol.SoundManager;
	
	/** 
	 * 地图关数
	 * 
	 */
	public class MapScene  extends Sprite
	{
		private var _root :String = "assets/map/";
		
		/**主角*/
		public var map :MovieClip;
		
		/**桃园结义  Button     2*/
		public var taoYuan :SimpleButton;
		/**桃园结义 Point*/
		public var taoYuanPoint :MovieClip;
		
		/**联军大营 Button     3*/
		public var lianJun :SimpleButton;
		/**联军大营 Point*/
		public var lianJunPoint :MovieClip;
		
		/**官渡之战 Button     4*/
		public var guanDu :SimpleButton;
		/**官渡之战  Point*/
		public var guanDuPoint :MovieClip;
		
		/**长坂之战 Button      5*/
		public var changBan :SimpleButton;
		/**长坂之战 Point*/
		public var changBanPoint :MovieClip;
		
		/**赤壁之战 Button      6*/
		public var chiBi :SimpleButton;
		/**赤壁之战 Point*/
		public var chiBiPoint :MovieClip;
		
		/**南征北战 Button      7*/
		public var nanZheng :SimpleButton;
		/**南征北战 Point*/
		public var nanZhengPoint :MovieClip;
		
		/**江夏水城 Button       8*/
		public var jiangXia :SimpleButton;
		/**江夏水城 Point*/
		public var jiangXiaPoint :MovieClip;
		
		/**灭吴之战 Button       9*/
		public var mieWu :SimpleButton;
		/**灭吴之战  Point*/
		public var mieWuPoint :MovieClip;
		
		private const MAPWIDTH:int = 1600;
		private const MAPHEIGHT:int = 784;
		//地图的大小 width=1600   和    height=784
		
		private var _missionNum:int;
		
		private var idle:IDLE;
		private var walk:WALK;
		private var clickTip :MovieClip;
		private var missionPointArray:Vector.<MovieClip> = new Vector.<MovieClip>();
		
		private var goToMission:int = 1;
		private var preGoToMission:int = 1;
		private const speed:Number = 4;
		private var speedX:Number;
		private var speedY:Number;
		
		
		private var destX :Number;
		private var destY :Number;
		
		private var fire6:MovieClip;
		
		private var fire1:MovieClip;
		
		private var fire2:MovieClip;
		
		private var fire4:MovieClip;
		
		private var fire5:MovieClip;
		
		private var fire7:MovieClip;
		
		private var battleBoardDown:MovieClip;

		private var index:int;
		
		public function MapScene(missionNum:int)
		{
			_missionNum = missionNum;
			loadRes(_root+"Map.swf","地图");
			
			
		}
		
		
		private function loadRes(url_:String,describtion_:String =""):void
		{
			LoaderManager.getInstance().getModualSwf(url_,initPanel);
			
		}
		
		private function initPanel():void
		{
			
			map = ClassManager.createInstance("map") as MovieClip;
			//			map.gotoAndStop(_missionNum);
			map.gotoAndStop(9);
			addChild(map);
			register();
			
			clickTip = ClassManager.createDisplayObjectInstance("ClickTip") as MovieClip;
			addChild(clickTip);
			clickTip.x = -100;
			
			
		}
		
		private function register():void
		{
			//lianJun lianJunPoint guanDu guanDuPoint changBan changBanPoint chiBi chiBiPoint nanZheng nanZhengPoint jiangXia jiangXiaPoint mieWu mieWuPoint
			taoYuan = map.taoYuan;
			taoYuanPoint = map.taoYuanPoint;
			missionPointArray.push(taoYuanPoint);
			
			lianJun = map.lianJun;
			lianJunPoint = map.lianJunPoint;
			missionPointArray.push(lianJunPoint);
			
			guanDu = map.guanDu;
			guanDuPoint = map.guanDuPoint;
			missionPointArray.push(guanDuPoint);
			
			changBan = map.changBan;
			changBanPoint = map.changBanPoint;
			missionPointArray.push(changBanPoint);
			
			chiBi = map.chiBi;
			chiBiPoint = map.chiBiPoint;
			missionPointArray.push(chiBiPoint);
			
			nanZheng = map.nanZheng;
			nanZhengPoint = map.nanZhengPoint;
			missionPointArray.push(nanZhengPoint);
			
			jiangXia = map.jiangXia;
			jiangXiaPoint = map.jiangXiaPoint;
			missionPointArray.push(jiangXiaPoint);
			
			mieWu = map.mieWu;
			mieWuPoint = map.mieWuPoint;
			missionPointArray.push(mieWuPoint);
			
			idle = new IDLE();
			addChild(idle);
			idle.scaleX = 0.4;
			idle.scaleY = 0.4;
			idle.x = taoYuanPoint.x;
			idle.y = taoYuanPoint.y;
			idle.mc.play();
			
			
			//a1,a4,a5,a6从天上落下啦(越来越小)
			//			a2,a3地下的火
			
			addFire();
			SoundManager.getInstance().playBgSound("worldBG",1);
			
			makeDrama();
		}
		
		private function makeDrama():void
		{
			var bitmap :Bitmap = new Bitmap();
			LoaderManager.getInstance().getBitmap(_root+"role.png",bitmap);
			
			battleBoardDown = ClassManager.createDisplayObjectInstance("changjing") as MovieClip;
			battleBoardDown.heroName.text = "重邮的勇士们:";
			battleBoardDown.speak.text = "时光穿梭,至此三国乱世";
			MovieClip(battleBoardDown.characters).addChild(bitmap);
			
			
			addChild(battleBoardDown);
			battleBoardDown.x = 0;battleBoardDown.y = StageProxy.stageHeight()-50;
			addEventListener(MouseEvent.CLICK,onSay);
		}
		
		protected function onSay(event:MouseEvent):void
		{
			
			index++;
			if(index == 1)battleBoardDown.speak.text = "正是我辈施展才能的好时机";
			else if(index == 2)
			{
				
				battleBoardDown.speak.text = "用智慧与勇敢一起改写历史吧";
			}else if(index == 3){
				TimerManager.getInstance().add(30,fade);
			}else onMouseClick(event);
			
		}
		
		private function fade():void
		{
			battleBoardDown.y += 3;
			if(battleBoardDown.y >= StageProxy.stageHeight()+50)
			{
				removeChild(battleBoardDown);
				TimerManager.getInstance().remove(fade);
			}
		}
		
		public function addFire():void
		{
			if(fire1)
			{
				SoundManager.getInstance().playBgSound("worldBG",1);
				fire1.play();
				fire2.play();
				fire4.play();
				fire5.play();
				fire6.play();
				fire7.play();
			}else{
				fire6 = ClassManager.createDisplayObjectInstance("A6") as MovieClip;
				addChild(fire6);
				fire6.x =500;fire6.y= 500;
				
				fire1 = ClassManager.createDisplayObjectInstance("A1") as MovieClip;
				addChild(fire1);
				fire1.x =1100;fire1.y= 500;
				
				
				fire2 = ClassManager.createDisplayObjectInstance("A2") as MovieClip;
				addChild(fire2);
				fire2.x =650;fire2.y= 500;
				
				fire4 = ClassManager.createDisplayObjectInstance("A4") as MovieClip;
				addChild(fire4);
				fire4.x =200;fire4.y= 500;
				
				fire5 = ClassManager.createDisplayObjectInstance("A5") as MovieClip;
				addChild(fire5);
				fire5.x =700;fire5.y= 200;
				
				fire7 = ClassManager.createDisplayObjectInstance("A4") as MovieClip;
				addChild(fire7);
				fire7.x =950;fire7.y= 200;
			}
		}		
		
		private function onMouseClick(e:MouseEvent):void
		{
			//this.removeEventListener(MouseEvent.CLICK,onMouseClick);
			SoundManager.getInstance().playEffectSound("click",1);
			TimerManager.getInstance().remove(walkTo);
			TimerManager.getInstance().remove(walkTo2);
			
			clickTip.x = e.localX;
			clickTip.y = e.localY;
			
			if(e.target is SimpleButton)
			{
				preGoToMission = goToMission;
				if(e.target == taoYuan){
					goToMission = 1;
				}
				if(e.target == lianJun){
					goToMission = 2;
				}
				if(e.target == guanDu){
					goToMission = 3;
				}
				if(e.target == changBan){
					goToMission = 4;
				}
				if(e.target == chiBi){
					goToMission = 5;
				}
				if(e.target == nanZheng){
					goToMission = 6;
				}
				if(e.target == jiangXia){
					goToMission = 7;
				}
				if(e.target == mieWu){
					goToMission = 8;
				}
				if(idle && this.contains(idle)){
					idle.mc.stop();
					this.removeChild(idle);
					
				}
				
				if(preGoToMission == goToMission)
				{
					dispose();
					trace(goToMission,"goToMission at MapScene dispatch goto num mission");
					var evt:MissionEvent = new MissionEvent(MissionEvent.GOTO_NUM_MISSION);
					evt.currentMissionNum = goToMission;
					dispatchEvent(evt);
					//todo 没有做清理，会导致报错
					return;
				}
				if(!walk)
				{
					walk = new WALK()
					addChild(walk);
					walk.mc.play();
					walk.scaleX = 0.4;
					walk.scaleY = 0.4;
					walk.x = idle.x;
					walk.y = idle.y;
					idle = null;
				}
				
				//				walk.x = missionPointArray[preGoToMission-1].x;
				//				walk.y = missionPointArray[preGoToMission-1].y;
				
				var time:Number = Math.sqrt(Math.pow((walk.x -  missionPointArray[goToMission-1].x),2)+
					Math.pow((walk.y -  missionPointArray[goToMission-1].y),2))/speed;
				speedX = (walk.x -  missionPointArray[goToMission-1].x)/time;
				speedY = (walk.y -  missionPointArray[goToMission-1].y)/time;
				TimerManager.getInstance().add(100, walkTo);
				preGoToMission = goToMission;
			}else{
				
				
				
				if(idle)
				{
					idle.mc.stop();
					this.removeChild(idle);
					
				}
				
				if(!walk)
				{
					walk = new WALK()
					addChild(walk);
					walk.mc.play();
					walk.scaleX = 0.4;
					walk.scaleY = 0.4;
					walk.x = idle.x;
					walk.y = idle.y;
					idle = null;
				}
				
				destX = e.localX;
				destY = e.localY;
				
				var time2:Number = Math.sqrt(Math.pow((walk.x -  e.localX),2)+
					Math.pow((walk.y -  e.localY),2))/speed;
				speedX = (walk.x -  e.localX)/time2;
				speedY = (walk.y - e.localY)/time2;
				TimerManager.getInstance().add(100, walkTo2);
			}
			
		}
		
		private function walkTo2():void
		{
			if(speedX>0){
				walk.scaleX = -0.4;
			}else{
				walk.scaleX = 0.4;
			}
			walk.x -= speedX;
			walk.y -= speedY;
			if( Math.abs((walk.x -  destX))<= 5 &&
				Math.abs((walk.y -  destY))<= 5)
			{
				TimerManager.getInstance().remove(walkTo2);
				walk.mc.stop();
				this.removeChild(walk);
				
				
				idle = new IDLE();
				addChild(idle);
				idle.x = walk.x;
				idle.y = walk.y;
				idle.scaleX = walk.scaleX;
				idle.scaleY = walk.scaleY;
				
				walk = null;
			}
		}
		
		private function walkTo():void
		{
			if(speedX>0){
				walk.scaleX = -0.4;
			}else{
				walk.scaleX = 0.4;
			}
			walk.x -= speedX;
			walk.y -= speedY;
			if((walk.x -  missionPointArray[goToMission-1].x)<= 5&&(walk.x -  missionPointArray[goToMission-1].x)>=0){
				TimerManager.getInstance().remove(walkTo);
				walk.mc.stop();
				this.removeChild(walk);
				walk = null;
				trace(goToMission,"goToMission at MapScene dispatch goto num mission");
				var evt:MissionEvent = new MissionEvent(MissionEvent.GOTO_NUM_MISSION);
				evt.currentMissionNum = goToMission;
				dispatchEvent(evt);
			}
		}
		
		public function addListener():void
		{
			
		}
		
		/**
		 * 更新面板上面的 关卡数
		 * @param missionNum
		 * 
		 */
		public function updateMission(missionNum:int):void{
			//addEventListener(MouseEvent.CLICK,onMouseClick);
			//			map.gotoAndStop(missionNum+1);
			map.gotoAndStop(9);
			addIdel();
		}
		
		private function addIdel():void{
			idle = new IDLE();
			addChild(idle);
			idle.scaleX = 0.4;
			idle.scaleY = 0.4;
			idle.x = missionPointArray[preGoToMission-1].x;
			idle.y = missionPointArray[preGoToMission-1].y;
			idle.mc.play();
		}
		
		private function dispose():void
		{
			TimerManager.getInstance().remove(walkTo);
			if(walk)
			{
				walk.mc.stop();
				this.removeChild(walk);
				walk = null;
			}
			
			fire1.stop();
			fire2.stop();
			fire4.stop();
			fire5.stop();
			fire6.stop();
			fire7.stop();
		}
		
		
		
	}
}