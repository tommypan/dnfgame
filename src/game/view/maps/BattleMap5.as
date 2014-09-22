package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap5 extends BaseMap
	{
		public function BattleMap5()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap5") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap5") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}