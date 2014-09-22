package game.controller
{
	import game.view.scene.InitScene;
	
	import Qmang2D.debug.console.Test;
	
	import org.robotlegs.mvcs.Command;

	/** 
	 * 移除初始化场景
	 * 
	 * @author pengbinke
	 * <p> 2013-3-25 下午5:49:14
	 */
	public class RemoveInitSceneCommand extends Command
	{
		public function RemoveInitSceneCommand()
		{
		}
		
		override public function execute():void
		{
			Test.traceByShowText("移除初始化资源加载界面", "mainline");
			contextView.removeChildAt(0);
			mediatorMap.unmapView(InitScene);
		}
	}
}