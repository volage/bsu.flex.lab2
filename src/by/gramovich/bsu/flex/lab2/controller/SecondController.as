package by.gramovich.bsu.flex.lab2.controller
{
	import by.gramovich.bsu.flex.lab2.model.SecondModel;
	
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	import mx.controls.Alert;

	public class SecondController
	{
		
		private var appModel:SecondModel = new SecondModel();
		private var connSender:LocalConnection;
		private var connReceiver:LocalConnection;		
		
		public function SecondController()
		{			
			connSender = new LocalConnection();
			connSender.addEventListener(StatusEvent.STATUS, onStatus);
			
			connReceiver = new LocalConnection();
			connReceiver.allowDomain("*");
			connReceiver.client = this;
			try {
				connReceiver.connect("app2conn");
			} catch(error:ArgumentError) {
				Alert.show("Unable to connect");
			}
		}			
		
		public function updateExternalData(message:String):void
		{
			this.appModel.externalData = message;
		}
		
		public function sendMessage_clickHandler(event:MouseEvent):void
		{
			connSender.send("app1conn", "updateExternalData", this.appModel.dataToSend);	
		}
		
		
		public function get model(): SecondModel
		{
			return this.appModel;
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {				
				case "error":
					Alert.show("Unable to send message to App 1");
					break;
			}
		}
		
	}
}