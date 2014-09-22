package Qmang2D.debug.console
{
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;

	/** 
	 * 测试工具，拥有各种测试功能，请使用静态方法，不能通过构造函数实例化
	 * 
	 * @author pengbinke
	 * @date 2013-2-9 
	 */
	public class Test
	{
		//显示文本测试
		private static var _showTextTest :ShowTextTest;
		
		//测试单元头节点，_head的key值用于输出时是否显示key值
		private static var _head :TestCell = new TestCell(false);
		
		/**构造函数，禁用*/
		public function Test(lock :SingletonEnforcer){}
		
		//测试单元相关---------------------------------------------------------
		/**
		 * 开启测试
		 */		
		public static function open():void
		{
			_head.lock = true;
		}
		
		/**
		 * 关闭测试
		 */		
		public static function close():void
		{
			_head.lock = false;
		}
		
		/**
		 * 关闭单个注册单元
		 * @param key
		 */			
		public static function closeKey(key:*):Boolean
		{
			var cell :TestCell = _head;
			
			while(cell.next)
			{
				cell = cell.next;
				if(cell.key == key)
				{
					cell.lock = false;
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * 移除单个注册单元
		 * @param key
		 */		
		public static function deleteKey(key:*):Boolean
		{
			var cell :TestCell = _head;
			
			while(cell.next)
			{
				if(cell.next.key == key)
				{
					cell.next = cell.next.next;
					return true;
				}
				cell = cell.next;
			}
			
			return false;
		}
		
		/**
		 * 输出时是否显示Key值
		 * @param isShow
		 */		
		public static function set showKey(isShow:Boolean):void
		{
			_head.key = isShow;
		}
		
		//检查注册key
		private static function checkKey(key:*):Boolean
		{
			//检测全局锁是否开启
			if(_head.lock){
				var cell :TestCell = _head;
				
				while(cell.next)
				{
					cell = cell.next;
					if(cell.key == key)
					{
						return cell.lock;
					}
				}
				
				//新建测试单元
				cell.next = new TestCell(key);
				return true;
			}else return false;
		}
		
		//组合Log和Key显示
		private static function combination(log:*, key:*):String
		{
			return _head.key ?	
				String(log) + "     —— " + String(key):
				String(log);
		}
		
		//显示文本相关--------------------------------------------------------
		/**
		 * 注册显示文本测试
		 * @param parent 父容器
		 */			
		public static function registerShowText(parent:DisplayObjectContainer):void
		{
			_showTextTest = new ShowTextTest(parent);
		}
		
		/**
		 * 通过显示文本输出
		 * @param log 输出日志
		 * @param key 测试单元key
		 * @param isShow 是否显示舞台上的显示文本
		 */		
		public static function traceByShowText(log:*, key:*, isShow:Boolean=false):void
		{
			if(checkKey(key))
			{
				try{
					_showTextTest.traceLog(combination(log, key) ,isShow);
				}catch(e:Error){
					throw new Error("请在使用显示文本输出前，使用registerShowText进行注册！");
				}
			}
		}
		
		/**
		 * 设置显示文本位置
		 * @param x
		 * @param y
		 */		
		public static function setShowTextPosition(x:int, y:int):void
		{
			_showTextTest.x = x;
			_showTextTest.y = y;
		}
	}
}
class SingletonEnforcer {}