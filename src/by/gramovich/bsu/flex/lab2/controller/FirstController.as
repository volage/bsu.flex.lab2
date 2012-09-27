package by.gramovich.bsu.flex.lab2.controller
{
	import by.gramovich.bsu.flex.lab2.model.FirstModel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.controls.Alert;

	public class FirstController
	{
		
		public static const XML_URL:String = "data.xml";					
		private var appModel:FirstModel = new FirstModel();				
		private var connSender:LocalConnection;
		private var connReceiver:LocalConnection;		
		
		public function FirstController()
		{
			connSender = new LocalConnection();
			connSender.addEventListener(StatusEvent.STATUS, onStatus);
			
			connReceiver = new LocalConnection();
			connReceiver.allowDomain("*");
			connReceiver.client = this;
			try {
				connReceiver.connect("app1conn");
			} catch(error:ArgumentError) {
				Alert.show("Unable to connect");
			}
			
			loadXML();		
		}
		
		private function loadXML():void
		{			
			var request:URLRequest = new URLRequest(XML_URL);
			var loader:URLLoader = new URLLoader(request);
			loader.addEventListener(Event.COMPLETE, onXMLLoadComplete);			
		}
		
		public function updateExternalData(message:String):void
		{
			this.appModel.externalData = message;
		}
		
		private function onXMLLoadComplete(event:Event):void
		{
			appModel.xmlBase = new XML(event.target.data);
			var typeStr:String;
			for each (var type in appModel.xmlBase..@type)
			{				
				typeStr = type.toString();
				if (!appModel.types.contains(typeStr))
				{
					appModel.types.addItem(typeStr);
				}
			}
		}						
		
		public function selectSquare_clickHandler(event:MouseEvent):void
		{							
			var selection:XML = <selection></selection>;
			var square:int = parseInt(appModel.selectedSquare);			
			for each (var pod:XML in appModel.xmlBase..pod.(isValidSquare(square, @height, @width)))
			{								
				selection.appendChild(pod);
			}
			appModel.messageToSend = selection.toString();
						
		}
		
		public function selectType_clickHandler(event:MouseEvent):void
		{
			var selection:XML = <selection></selection>;
			for each (var pod:XML in appModel.xmlBase..pod.(@type == appModel.selectedType))
			{				
				selection.appendChild(pod);
			}
			appModel.messageToSend = selection.toString();
		}
		
		public function sendSelection_clickHandler(event:MouseEvent):void
		{
			connSender.send("app2conn", "updateExternalData", this.appModel.messageToSend);			
		}
		
		private function isValidSquare(square:int, height:int, width:int):Boolean
		{
			
			switch(appModel.selectedOperation) 
			{
				case "<":
					return height * width < square;					
				case "<=":
					return height * width <= square;					
				case "=":
					return height * width == square;					
				case ">=":
					return height * width >= square;					
				case ">":
					return height * width > square;					
			}
			return false;
		}
		
		public function get model():FirstModel
		{
			return this.appModel;		
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {				
				case "error":
					Alert.show("Unable to send message to App 2");
					break;
			}
		}
	}
}