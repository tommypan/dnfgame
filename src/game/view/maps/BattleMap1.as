package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;
	import Qmang2D.protocol.LayerCollection;

	public class BattleMap1 extends BaseMap
	{
		public function BattleMap1()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap1") as MovieClip;
			walkMap = ClassManager.createDisplayObjectInstance("walkMap1") as MovieClip;
			super();
		}
	}
}