package game.view.scene
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import Qmang2D.display.BitmapMovie;
	import Qmang2D.loader.LoaderManager;
	import Qmang2D.utils.ClassManager;
	
	/** 
	 * 登录场景
	 * @author pengbinke
	 * <p> 2013-4-17 下午8:48:40
	 */
	public class LoginScene extends Sprite
	{
		/**用户名输入框*/
		public var passport :TextField;
		
		/**密码输入框*/
		public var password :TextField;
		
		/**用户名错误提示框*/
		public var passportError :TextField;
		
		/**密码错误提示框*/
		public var passwordError :TextField;
		
		/**登录按钮*/
		public var loginBtn :SimpleButton;
		
		/**登录按钮*/
		public var registerBtn :SimpleButton;
		
		
		//“用户名”文本
		private var _passport :TextField;
		
		//“密码”文本
		private var _password :TextField;
		
		public function LoginScene()
		{
			//“用户名”文本
			_passport = new TextField();
			_passport.textColor = 0xffffff;
			_passport.selectable = false;
			_passport.width = 50;
			_passport.height = 25;
			_passport.y = 100;
			_passport.text = "用户名:";
			addChild(_passport);
			
			//“密码”文本
			_password = new TextField();
			_password.textColor = 0xffffff;
			_password.selectable = false;
			_password.y = 150;
			_password.width = 50;
			_password.height = 25;
			_password.text = "密    码:";
			addChild(_password);
			
			//用户名输入框
			passport = new TextField();
			passport.type = TextFieldType.INPUT;
			//passport.restrict = "0-9a-z";
			passport.textColor = 0xffffff;
			passport.border = true;
			passport.borderColor = 0xffffff;
			passport.x = 60;
			passport.y = 100;
			passport.width = 100;
			passport.height = 25;
			addChild(passport);
			
			//密码输入框
			password = new TextField();
			password.type = TextFieldType.INPUT;
			password.restrict = "0-9a-z";
			password.textColor = 0xffffff;
			password.border = true;
			password.borderColor = 0xffffff;
			password.x = 60;
			password.y = 150;
			password.width = 100;
			password.height = 25;
			addChild(password);
			
			//用户名错误提示框
			passportError = new TextField();
			passportError.textColor = 0xff0000;
			passportError.selectable = false;
			passportError.x = 170;
			passportError.y = 100;
			passportError.width = 300;
			passportError.height = 25;
			addChild(passportError);
			
			//密码错误提示框
			passwordError = new TextField();
			passwordError.textColor = 0xff0000;
			passwordError.selectable = false;
			passwordError.x = 170;
			passwordError.y = 150;
			passwordError.width = 300;
			passwordError.height = 25;
			addChild(passwordError);
			
			//登录按钮
			loginBtn = ClassManager.createInstance("loginBt") as SimpleButton;
			loginBtn.x = 120;
			loginBtn.y = 200;
			loginBtn.width = 45;
			loginBtn.height = 35;
			addChild(loginBtn);
			
			//注册按钮
			registerBtn = ClassManager.createInstance("registerBt") as SimpleButton;
			registerBtn.x = 57;
			registerBtn.y = 200;
			registerBtn.width = 45;
			registerBtn.height = 35;
			addChild(registerBtn);
			
			var mc :MovieClip = ClassManager.createDisplayObjectInstance("login") as MovieClip;
			addChild(mc);
			mc.y = -100;
			mc.x = 100;
			
		}
		
		
		public function clear():void
		{
			removeChild(passport);
			removeChild(password);
			removeChild(passportError);
			removeChild(passwordError);
			removeChild(loginBtn);
			removeChild(_passport);
			removeChild(_password);
		}
	}
}