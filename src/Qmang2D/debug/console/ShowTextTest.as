package Qmang2D.debug.console
{
	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	/** 
	 * 显示文本测试
	 * 
	 * @author pengbinke
	 * @date 2013-2-9
	 */
	public class ShowTextTest
	{
		//父容器
		private var _parent :DisplayObjectContainer;
		
		//显示文本
		private var _showText :TextField;
		
		/**
		 * 构造函数
		 * @param parent 父容器对象
		 */		
		public function ShowTextTest(parent:DisplayObjectContainer)
		{
			_parent = parent;
			
			//设置舞台上显示文本外观
			_showText = new TextField();
			_showText.wordWrap = true;
			_showText.background = true;
			_showText.backgroundColor = 0xFFEC8B;
			_showText.alpha = 0.6;
			_showText.width = 300;
			_showText.height = 300;
		}
		
		/**
		 * 输出日志
		 * @param log
		 * @param isShow
		 */		
		public function traceLog(log:String, isShow:Boolean=false):void
		{
			trace(log);
			
			_showText.appendText(log+"\n");
			_showText.scrollV = _showText.numLines;
			
			isShow && 
				(_parent.contains(_showText) || _parent.addChild(_showText));
		}
		
		//按Shift+T控制输出日志显示和消失
		private function onKeyDown(e:KeyboardEvent):void
		{
			if(e.shiftKey && e.keyCode == Keyboard.T)
			{
				_parent.contains(_showText) ?
					_parent.removeChild(_showText) :
					_parent.addChild(_showText);
			}
		}
		
		/**
		 * 设置显示文本x坐标
		 * @param value
		 */		
		public function set x(value:int):void
		{
			_showText.x = value;
		}
		
		/**
		 * 设置显示文本y坐标
		 * @param value
		 */
		public function set y(value:int):void
		{
			_showText.y = value;
		}
	}
}