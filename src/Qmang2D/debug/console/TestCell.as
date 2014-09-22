package Qmang2D.debug.console
{
	/** 
	 * 测试单元
	 * 
	 * @author pengbinke
	 * @date 2013-2-9 下午5:19:52
	 */
	public class TestCell
	{
		/**下一个测试单元节点*/
		public var next :TestCell;
		
		/**密钥*/
		public var key :*;
		
		/**锁，关闭的话将不会测试输出*/
		public var lock :Boolean = true;
		
		public function TestCell(key:*)
		{
			this.key = key;
		}
	}
}