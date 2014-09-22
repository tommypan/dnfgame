package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap2 extends BaseMap
	{
		public function BattleMap2()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap2") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap2") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}