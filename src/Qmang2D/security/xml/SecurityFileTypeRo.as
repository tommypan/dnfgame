package Qmang2D.security.xml
{
	/**
	 *此类为Ro(read only只读)，因为考虑到密钥被不小心修改，加密类我是已经打包成swc文件，类名为SecurityTool，这个类仅供大家学习 
	 *  @author ph
	 * 
	 */	
	public class SecurityFileTypeRo
	{
		public function SecurityFileTypeRo()
		{
		}
		
		public static const ZIP:String="zip";
		public static const SWF:String="swf";
	}
}