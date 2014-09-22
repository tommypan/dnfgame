package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap6 extends BaseMap
	{
		public function BattleMap6()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap6") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap6") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}