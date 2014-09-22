package Qmang2D.security.xml
{
	import flash.utils.ByteArray;

	/**
	 * 通过此类做一个加密工具
	 * 此类为Ro(read only只读)，因为考虑到密钥被不小心修改，加密类我是已经打包成swc文件，类名为SecurityTool，这个类仅供大家学习
	 * @author ph
	 * 
	 */	
	public class SecurityToolRo
	{
		public function SecurityToolRo()
		{
		}
		
		//密钥
		private static const swfKey:String="daj7r4$3{:38";
		private static const zipKey:String="543u8y&^&^$/";
		
		//源文件读出的short值
		private static const swfHead:uint=0x4357;
		private static const zipHead:uint=0x504B;
		
		
		public static function encode(data:ByteArray,type:String):ByteArray
		{
			var head:uint=data.readShort();
			var key:String;
			if(type==SecurityFileTypeRo.SWF)
			{
				if(head!=swfHead)
				{
					trace("该文件不是swf文件");
					return data;
				}
				else
				{
					key=swfKey;
				}
			}
			else if(type==SecurityFileTypeRo.ZIP)
			{
				if(head!=zipHead)
				{
					trace("该文件不是zip文件");
					return data;
				}
				else
				{
					key=zipKey;
				}
			}
			var byteArray:ByteArray=new ByteArray();
			data.position=0;
			var flag:int=0;
			for(var i:int = 0; i<data.length ; i++ ,flag++){
				if(flag >= key.length){
					flag = 0;
				}
				byteArray.writeByte(data[i] + key.charCodeAt(flag));
			}
			return byteArray;
		}
		
		/**
		 *通过urlLoader将其load，然后解密其二进制流，返回一个二进制流。在重新load一次即可。
		 * @param data
		 * @param type
		 * @return 
		 * 
		 */		
		public static function decode(data:ByteArray,type:String):ByteArray
		{
			var head:uint=data.readShort();
			var key:String;
			if(type==SecurityFileTypeRo.SWF)
			{
				if(head==swfHead)
				{
					trace("swf未加密");
					return data;
				}
				else
				{
					trace("swf已加密");
					key=swfKey;
				}
			}
			else if(type==SecurityFileTypeRo.ZIP)
			{
				if(head==zipHead)
				{
					trace("zip未加密");
					return data;
				}
				else
				{
					trace("zip已加密");
					key=zipKey;
				}
			}
			var byteArray:ByteArray=new ByteArray();
			data.position=0;
			var flag:int=0;
			for(var i:int = 0; i<data.length ; i++ ,flag++){
				if(flag >= key.length){
					flag = 0;
				}
				byteArray.writeByte(data[i] - key.charCodeAt(flag));
			}
			trace("解密完成");
			return byteArray;	
		}
	}
}