package game.model.vo
{
	/**
	 *@author aser_ph
	 *@date 2013-5-5
	 */
	public class ChapterVo
	{
		public var id :String;
		
		public var level :int;
		
		public var x :Number;
		
		public var y :Number;
		
		public var scene :int;
		
		public function ChapterVo($object:Object)
		{
			id = $object.id;
			level = $object.level;
			x = $object.x;
			y = $object.y;
			scene = $object.scene;
		}
		
	}
}