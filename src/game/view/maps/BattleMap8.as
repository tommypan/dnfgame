package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap8 extends BaseMap
	{
		public function BattleMap8()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap8") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap8") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}