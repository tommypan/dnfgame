package game.service
{
	import com.adobe.json.JSON;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.ByteArray;
	
	import game.event.ReceiveEvent;
	import game.event.GameInitializeEvent;
	
	import Qmang2D.debug.console.Test;
	
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * 单例，客户端socket通信，业务对象用json打包
	 * 
	 * 暂不考虑断线重连
	 * 
	 * @author pengbinke
	 * <p> 2013-3-5 上午10:33:59
	 */
	public class SocketService extends Actor
	{
		//Socket建立传输控制协议 (TCP) 套接字连接
		private var _socket :Socket;
		
		//json解析方法
		private var _decode :Function;
		
		//json打包方法
		private var _encode :Function;
		
		//接受（发送）数据
		private var _data :ByteArray;
		
		//接受包的包长
		private var _dataLength :uint;
		
		//判断一个包是否读取完整，ture完整，false不完整
		private var _needReadHead:Boolean = true;
		
		//频率锁，申请后只有响应才能再次申请
		//private var _rateLock :Object;
		
		//接收事件集
		private var _receiveEvents :Object;
		
		//临时接收事件类型一
		private var _tFirstType :int;
		
		//临时接收事件类型二
		private var _tSecondType :int;
		
		//构造函数
		public function SocketService()
		{
			Test.traceByShowText("初始化 socket", "SocketService");
			
			//JSON打包（解析）方法
			_decode = com.adobe.json.JSON.decode;
			_encode = com.adobe.json.JSON.encode;
			
			//发送（接收）数据临时容器
			_data = new ByteArray();
			_data.length = 255;
			
			_socket = new Socket();
			
			_socket.addEventListener(Event.CONNECT, onConnectComplete);
			_socket.addEventListener(Event.CLOSE,onClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.addEventListener(IOErrorEvent.IO_ERROR,onIoError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
			
			//设置策略文件
			Security.loadPolicyFile("assets/core/crossdomain.xml");
			
			initEventRelated();
		}
		
		/**
		 * 连接服务器
		 * @param ip
		 * @param port
		 */		
		public function connect(ip:String, port:int):void
		{
			Test.traceByShowText("开始连接socket\n" +
				"IP：" + ip + " port：" + port, "SocketService");
			
			_socket.connect(ip, port);
		}
		
		//在建立网络连接后调度
		private function onConnectComplete(e:Event):void
		{
			Test.traceByShowText("Socket 连接成功", "SocketService");
			
			dispatch(new Event(GameInitializeEvent.CONNECT_COMPLETE));
		}
		
		//在服务器关闭套接字连接时调度
		private function onClose(e:Event):void
		{
			Test.traceByShowText("服务器关闭套接字", "SocketService");
			
			_socket.removeEventListener(Event.CONNECT,onConnectComplete);
			_socket.removeEventListener(Event.CLOSE,onClose);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR,onIoError);
			_socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
		}
		
		//在出现输入/输出错误并导致发送或加载操作失败时调度
		private function onIoError(e:IOErrorEvent):void
		{
			Test.traceByShowText("IP / Port 出现错误信息", "SocketService");
			
			dispatch(new Event(GameInitializeEvent.DISCONNECT));
		}
		
		/*若对 Socket.connect() 的调用尝试连接到调用方安全沙箱外部的服务器
		或端口号低于 1024 的端口，则进行调度*/
		private function onSecurityError(e:SecurityErrorEvent):void
		{
			Test.traceByShowText("调用尝试连接到调用方安全沙箱外部的服务器或端口号低于 1024 的端口", "SocketService");
			
			dispatch(new Event(GameInitializeEvent.DISCONNECT));
		}
		
		//在套接字接收到数据后调度
		private function onSocketData(e:ProgressEvent):void
		{
			while(_socket.bytesAvailable)
			{
				if(_needReadHead)
				{
					_dataLength = _socket.readShort();
					_needReadHead = false;
				}
				
				if(!_needReadHead)
				{
					if(_socket.bytesAvailable >= _dataLength){//通过包长判断，保证数据交互正确
						_data.position = 0;
						_socket.readBytes(_data, 0, _dataLength);
						_data.position = 0;
						
						parseData();
						_needReadHead = true;
					}else{
						Test.traceByShowText("未知包长:" + _socket.bytesAvailable,
							"SocketService", true);
						break;
					}
				}
			}
		}
		
		//解析数据
		private function parseData():void
		{
			//_rateLock[(_tFirstType = _data.readByte())][(_tSecondType = _data.readByte())] != null 
			//&& (_rateLock[_tFirstType][_tSecondType] = false);
			_tFirstType = _data.readByte();
			_tSecondType = _data.readByte();
			trace("收到包",_tFirstType,_tSecondType);
			dispatch(new ReceiveEvent(
				_receiveEvents[_tFirstType][_tSecondType], 
				_decode(_data.readUTFBytes(_dataLength-2))));
		}
		
		/**
		 * 数据发送
		 * @param object 业务对象
		 * @param firstType 业务类型一
		 * @param secondType 业务类型二
		 */		
		public function sendJSON(object:Object, firstType:int, secondType:int):void
		{
			//			if(_rateLock[firstType][secondType] != null)
			//			{
			//				if(_rateLock[firstType][secondType]){
			//					return;
			//				}else{
			//					_rateLock[firstType][secondType] = true;
			//				}
			//			}
			
			//写入数据
			_data.position = 0;
			_data.writeByte(firstType);
			_data.writeByte(secondType);
			object && _data.writeUTFBytes(_encode(object));//只是对发送的信息json编码，type和长度没有
			
			//写入socket，并发送
			_socket.writeShort(_data.position);//length
			_socket.writeBytes(_data, 0, _data.position);//byte(byte) byte(byte) utfbyte(reader.readline)
			_socket.flush();
			
			trace("发送包：",firstType, secondType);
		}
		
		//初始化事件相关
		private function initEventRelated():void
		{
			//频率锁事件 type:false,害人不浅
			//			_rateLock = 
			//				{
			//					1:{1:true},
			//					2:{1:false,2:true}
			//				};
			
			//接收事件 type:event
			_receiveEvents =
				{
					1:{
						1:GameInitializeEvent.RECEIVE_ACCOUNT_VALIDATION,
						2:GameInitializeEvent.RECEIVE_REGISTER_RESULT},//接收玩家帐号验证结果信息
					2:{
						1:GameInitializeEvent.RECEIVE_BASIC_INFO}}//接收玩家基础信息
		}
		
	}
}