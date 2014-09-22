package game.view.mediator
{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import game.event.GameInitializeEvent;
	import game.event.ReceiveEvent;
	import game.model.HeroModel;
	import game.service.SocketService;
	import game.view.scene.LoginScene;
	
	import org.robotlegs.mvcs.Mediator;
	
	/** 
	 * 登录场景中介
	 * @author pengbinke
	 * <p> 2013-4-17 下午8:59:02
	 */
	public class LoginSceneMediator extends Mediator
	{
		
		[Inject]
		public var heroModel :HeroModel;
		
		[Inject]
		public var loginScene :LoginScene;
		
		[Inject]
		public var socketService :SocketService;
		
		public function LoginSceneMediator()
		{
		}
		
		override public function onRegister():void
		{
			//接收登录错误信息
			addContextListener(GameInitializeEvent.LOGIN_ERROR, onError, ReceiveEvent);
			
			//清理场景
			addContextListener(GameInitializeEvent.LOGIN_CLEAR, onClear);
			
			//点击确认键
			loginScene.loginBtn.addEventListener(MouseEvent.CLICK, onClick);
			
			loginScene.registerBtn.addEventListener(MouseEvent.CLICK, onZhuCe);
		}
		
		
		//显示错误信息
		private function onError(e:ReceiveEvent):void
		{
			loginScene.passportError.text = String(e.data);
		}
		
		//移除场景
		private function onClear(e:Event):void
		{
			removeContextListener(GameInitializeEvent.LOGIN_ERROR, onError, ReceiveEvent);
			removeContextListener(GameInitializeEvent.LOGIN_CLEAR, onClear);
			loginScene.loginBtn.removeEventListener(MouseEvent.CLICK, onClick);
			
			contextView.removeChild(loginScene);
			loginScene.clear();
		}
		
		//点击注册键
		protected function onZhuCe(event:MouseEvent):void
		{
			if(loginScene.passport.text.length >= 12){
				loginScene.passportError.text = "用户名不能超过12个字符";
				return;
			}
			
			if(loginScene.password.text.length < 6 || loginScene.password.text.length> 12){
				loginScene.passportError.text = "密码应该为6到12个字符";
				return;
			}
			
			heroModel.userName = loginScene.passport.text;
			
			//发送用户帐号和密码到服务器验证
			socketService.sendJSON(
				{id:loginScene.passport.text,
					pwd:loginScene.password.text},
				1, 2);
		}
		
		
		//点击确认键
		private function onClick(e:MouseEvent):void
		{
//			if(loginScene.passport.text == ""){
//				loginScene.passportError.text = "用户名不能为空";
//				return;
//			}
//			
//			if(loginScene.password.text == ""){
//				loginScene.passwordError.text = "密码不能为空";
//				return;
//			}
//			
			
			heroModel.userName = loginScene.passport.text;
			
			var event :ReceiveEvent;
			event = new ReceiveEvent(GameInitializeEvent.LOGIN_SUCESS,null);
			dispatch(event);
			
			event = new ReceiveEvent(GameInitializeEvent.LOGIN_CLEAR,null);
			dispatch(event);
			
//			//发送用户帐号和密码到服务器验证
//			socketService.sendJSON(
//				{id:loginScene.passport.text,
//					pwd:loginScene.password.text},
//				1, 1);
		}
		
		override public function onRemove():void
		{
			mediatorMap.unmapView(LoginScene);
			
		}
	}
}