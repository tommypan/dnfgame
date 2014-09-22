package game.event
{
	/** 
	 * 初始化游戏事件
	 * 
	 * @author pengbinke
	 * <p> 2013-4-5 下午3:35:02
	 */
	public class GameInitializeEvent
	{
		/**internal:（资源）准备就绪*/
		public static const READY :String = "ready";
		
		/**接受账户验证结果*/
		public static const RECEIVE_ACCOUNT_VALIDATION :String = "RECEIVE_ACCOUNT_VALIDATION";
		
		/**接受玩家基本信息*/
		public static const RECEIVE_BASIC_INFO :String = "RECEIVE_BASIC_INFO";
		
		/**接受账户验证结果*/
		public static const RECEIVE_REGISTER_RESULT :String = "RECEIVE_REGISTER_RESULT";
		
		/**套接字断开*/
		public static const DISCONNECT :String = "DISCONNECT";
		
		/**套接字开始连接*/
		public static const CONNECT_BEGIN :String = "CONNECT_BEGIN";
		
		/**套接字连接完成*/
		public static const CONNECT_COMPLETE :String = "CONNECT_COMPLETE";
		
		/**套接字登陆错误*/
		public static const LOGIN_ERROR :String = "LOGIN_ERROR";
		
		/**套接字登陆清理*/
		public static const LOGIN_CLEAR :String = "LOGIN_CLEAR";
		
		/**套接字登陆成功*/
		public static const LOGIN_SUCESS :String = "LOGIN_SUCESS";
		
		
		public function GameInitializeEvent()
		{
		}
	}
}