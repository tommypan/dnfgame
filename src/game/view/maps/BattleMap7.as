package game.view.maps
{
	import flash.display.MovieClip;
	
	import Qmang2D.utils.ClassManager;

	public class BattleMap7 extends BaseMap
	{
		public function BattleMap7()
		{
			bgMap = ClassManager.createDisplayObjectInstance("bgMap7") as MovieClip;
			addChild(bgMap);
			
			walkMap = ClassManager.createDisplayObjectInstance("walkMap7") as MovieClip;
			addChild(walkMap);
			super();
		}
	}
}