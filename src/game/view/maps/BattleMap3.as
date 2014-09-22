package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap3 extends BaseMap
	{
		public function BattleMap3()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap3") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap3") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}