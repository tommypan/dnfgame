package game.view.scene.ui
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.sensors.Accelerometer;
	import flash.text.TextField;
	
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	
	public class RoleBan extends Sprite
	{
		private static var _instance :RoleBan;
		
		public var redBloodProgress:BloodProgressBar;
		
		public var blueBloodProgress:BloodProgressBar;
		
		/**
		 *英雄战斗力文本 
		 */		
		public var battlePowerText :TextField;
		
		/**
		 *英雄等级文本 
		 */		
		public var lvText :TextField;
		
		/**
		 *元宝文本 
		 */		
		public var yuanBaoText :TextField;
		
		/**
		 *金钱文本 
		 */		
		public var moneyText :TextField;
		
		
		public var skillBan:MovieClip;
		
		public var hSkillBan :MovieClip;
		
		public var uSkillBan :MovieClip;
		
		public var iSkillBan :MovieClip;
		
		public var oSkillBan :MovieClip;
		
		public var lSkillBan :MovieClip;
		
		private var _root :String = "assets/map/";
		
		public function RoleBan(singltonEnforcer :SingltonEnforcer)
		{
			if(singltonEnforcer == null) throw new IllegalOperationError("真各应，要用getInstance方法获取单例");
			else
			{
				var bitmap :Bitmap = new Bitmap();
				LoaderManager.getInstance().getBitmap(_root+"role.png",bitmap);
				addChild(bitmap);
				bitmap.y=20;
				
				battlePowerText = new TextField();
				battlePowerText.autoSize = "left";
				lvText = new TextField();
				lvText.autoSize = "left";
				
				
				LoaderManager.getInstance().getModualSwf(_root+"skillIcon.swf",initRoleBan);
			}
			
		}
		
		/**
		 * 
		 * @return 单例
		 * 
		 */		
		public static function getInstance():RoleBan
		{
			_instance ||= new RoleBan( new SingltonEnforcer());
			return _instance;
		}
		
		private function initRoleBan():void
		{
			var heroTreasure :MovieClip = ClassManager.createDisplayObjectInstance("heroTreasure") as MovieClip;
			addChild(heroTreasure);
			heroTreasure.x = 90;
			heroTreasure.y = 10;
			
			
			lvText = heroTreasure.levelText;
			yuanBaoText = heroTreasure.yuanBao;
			moneyText = heroTreasure.money;
			
			
			var battlePower :MovieClip = ClassManager.createDisplayObjectInstance("battlePower") as MovieClip;
			addChild(battlePower);
			battlePower.x = 0;
			battlePower.y = 120;
			battlePowerText = battlePower.battlePowerText;
			
			
			hSkillBan = ClassManager.createInstance("HSkill") as MovieClip;
			addChild(hSkillBan);
			hSkillBan.x = 110;
			hSkillBan.y = 110;
			
			skillBan = ClassManager.createDisplayObjectInstance("skillBan") as MovieClip;
			
			uSkillBan = ClassManager.createInstance("USkill") as MovieClip;
			addChild(uSkillBan);
			uSkillBan.x = 145;
			uSkillBan.y = 108;
			
			iSkillBan = ClassManager.createInstance("ISkill") as MovieClip;
			addChild(iSkillBan);
			iSkillBan.x = 183;
			iSkillBan.y = 110;
			
			oSkillBan = ClassManager.createInstance("OSkill") as MovieClip;
			addChild(oSkillBan);
			oSkillBan.x = 220;
			oSkillBan.y = 109;
			
			lSkillBan = ClassManager.createInstance("LSkill") as MovieClip;
			addChild(lSkillBan);
			lSkillBan.x = 258;
			lSkillBan.y = 110;
			//skillBan.gotoAndStop(5);//skillBan.gotoAndStop(1);
			//skillBan.visible = false;
			//UIOHL共5帧，可以通过HSkill，USkill等来获取单个
			
			//			skillBan = ClassManager.createInstance("HSkill") as MovieClip;
			//			addChild(skillBan);
			//			skillBan.x = 100;
			//			skillBan.y = 110;
			
			blueBloodProgress = new BloodProgressBar();
			blueBloodProgress.drawProgressBar(200,20,200);
			addChild(blueBloodProgress);
			blueBloodProgress.x = 100;
			blueBloodProgress.y = 60;
			
		}
		
		public function addRedProgressBar(totalHp:int):void
		{
			redBloodProgress = new BloodProgressBar();
			redBloodProgress.drawProgressBar(200,20,totalHp,new Array(0xc21f03, 0xff0000, 0xb53413));
			addChild(redBloodProgress);
			redBloodProgress.x = 100;
			redBloodProgress.y = 15;
		}
		
		
		/**
		 * 
		 * @param id技能的索引，如：U，I,O,H,L...
		 * 
		 */		
		public function updateSkillIcon(id:String):void
		{
			switch(id)
			{
				case 'U':
					skillBan.gotoAndStop(5);//1
					break;
				
				case 'I':
					skillBan.gotoAndStop(5);//2
					break;
				
				case 'O':
					skillBan.gotoAndStop(5);//3
					break;
				
				case 'H':
					skillBan.gotoAndStop(5);//4
					break;
				
				case 'L':
					skillBan.gotoAndStop(5);//5
					break;
				
			}
			skillBan.visible = true;
		}
		
		
		public function upDateRedBlood(curBlood:Number,totalBlood:Number):void
		{
			redBloodProgress.update(curBlood,totalBlood);
		}
		
		public function upDateBlueBlood(curBlood:Number,totalBlood:Number):void
		{
			blueBloodProgress.update(curBlood,totalBlood);
		}
	}
}
internal class SingltonEnforcer{}