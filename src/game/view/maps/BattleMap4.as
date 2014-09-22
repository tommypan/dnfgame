package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap4 extends BaseMap
	{
		public function BattleMap4()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap4") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap4") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}