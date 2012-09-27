package by.gramovich.bsu.flex.lab2.controller
{
	import by.gramovich.bsu.flex.lab2.model.SecondModel;
	
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.controls.Alert;

	/**
	 * Controller for second application
	 */
	public class SecondController
	{
		
		public var model:SecondModel = SecondModel.getInstance();
		private var sender:LocalConnection;
		private var receiver:LocalConnection;		
		
		public function SecondController()
		{			
			sender = new LocalConnection();
			
			receiver = new LocalConnection();
			receiver.allowDomain("*");
			receiver.client = this;
			try {
				receiver.connect("SecondApplication");
			} catch(error:ArgumentError) {
				trace("Unable to connect");
			}
		}
		
		public function sendMessage(event:MouseEvent):void
		{
			sender.send("FirstApplication", "updateExternalData", this.model.sendInput);	
		}	
		
		public function receiveData(message:String):void
		{
			this.model.recievedlData = message;
		}
		
	}
}