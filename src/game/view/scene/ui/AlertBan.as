package game.view.scene.ui
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import Qmang2D.loader.LoaderManager;

	public class AlertBan extends Sprite
	{
		private var sureBtn:Sprite = new Sprite();
		private var cancelBtn:Sprite = new Sprite();
		private var _sureFun:Function;
		private var _cancelFun:Function;

		private var alertBmp:Bitmap;
		public function AlertBan(sureFun:Function,cancelFun:Function)
		{
			_sureFun = sureFun;
			_cancelFun = cancelFun;
			
			alertBmp = new Bitmap();
			LoaderManager.getInstance().getBitmap("assets/map/alert.png",alertBmp);
			addChild(alertBmp);
			
			sureBtn.graphics.beginFill(0xff0000,0);
			sureBtn.graphics.drawRoundRect(60,90,80,30,5,5);
			sureBtn.graphics.endFill();
			addChild(sureBtn);
			sureBtn.addEventListener(MouseEvent.CLICK,onSure);
			
			cancelBtn.graphics.beginFill(0xff0000,0);
			cancelBtn.graphics.drawRoundRect(150,90,80,30,5,5);
			cancelBtn.graphics.endFill();
			addChild(cancelBtn);
			cancelBtn.addEventListener(MouseEvent.CLICK,onCancel);
		}
		
		private function onCancel(event:MouseEvent):void
		{
			_cancelFun();
		}
		
		private function onSure(event:MouseEvent):void
		{
			_sureFun();
		}
		
		public function dispose():void
		{
			this.removeChild(alertBmp);
			sureBtn.removeEventListener(MouseEvent.CLICK,onSure);
			cancelBtn.removeEventListener(MouseEvent.CLICK,onCancel);
		}
		
	}
}