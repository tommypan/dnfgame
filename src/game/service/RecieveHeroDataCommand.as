package game.service
{
	import game.event.ReceiveEvent;
	import game.model.HeroModel;
	
	import org.robotlegs.mvcs.Command;
	
	public class RecieveHeroDataCommand extends Command
	{
		[Inject]
		public var event :ReceiveEvent;
		
		[Inject]
		public var heroModel :HeroModel;
		
		
		public function RecieveHeroDataCommand()
		{
		}
		
		override public function execute():void
		{
			heroModel.init();
			
			heroModel.level = event.data.level;
			heroModel.zhangong = event.data.zhangong;
			heroModel.yuanbao = event.data.yuanbao;
			heroModel.money = event.data.money;
			
			if( event.data.soundOpen == 1)
				heroModel.soundOpen = false;
		}
		
		
	}
}