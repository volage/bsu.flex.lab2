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

	/**
	 * Controller for first application
	 */
	public class FirstController
	{
		
		public var model:FirstModel = FirstModel.getInstance();		
		
		public static const XML_URL:String = "data.xml";			
		private var sender:LocalConnection;
		private var resievier:LocalConnection;		
		
		/**
		 * Initialize sender, resiever and xml data
		 */
		public function FirstController()
		{
			sender = new LocalConnection();
			
			resievier = new LocalConnection();
			resievier.allowDomain("*");
			resievier.client = this;
			try {
				resievier.connect("FirstApplication");
			} catch(error:ArgumentError) {
				trace("Unable to connect");
			}
			
			var loader:URLLoader = new URLLoader(new URLRequest(XML_URL));
			loader.addEventListener(Event.COMPLETE, onXMLLoad);				
		}
		
		/**
		 * Load types after xml will be loaded
		 */
		private function onXMLLoad(event:Event):void
		{
			model.xml = new XML(event.target.data);
			var typeStr:String;
			for each (var type in model.xml..@type)
			{		
				typeStr = type.toString();
				if (!model.types.contains(typeStr))
				{
					model.types.addItem(typeStr);
				}
			}
		}						
		
		/**
		 * Select by select operation and square input
		 */
		public function selectBySquare(event:MouseEvent):void
		{							
			var selection:XML = <selection></selection>;
			var square:int = parseInt(model.squareInput);			
			for each (var pod:XML in model.xml..pod.(isValidSquare(square, @height, @width)))
			{								
				selection.appendChild(pod);
			}
			model.selection = selection.toString();
						
		}
		
		/**
		 * Select pods with valid by selected condition squere
		 */
		public function selectByType(event:MouseEvent):void
		{
			var selection:XML = <selection></selection>;
			for each (var pod:XML in model.xml..pod.(@type == appModel.selectedType))
			{				
				selection.appendChild(pod);
			}
			model.selection = selection.toString();
		}
		
		/**
		 * Send selection to second application
		 */
		public function sendSelection(event:MouseEvent):void
		{
			sender.send("SecondApplication", "updateExternalData", this.model.selection);			
		}
		
		/**
		 * Check square by selected operation
		 */
		private function isValidSquare(square:int, height:int, width:int):Boolean
		{
			if (model.selectedComparison.data in this) {
				return this[model.selectedComparison.data](square, height, width);
			} else return false;
		}
		
		private function greater(square:int, height:int, width:int):Boolean {
			return height * width > square;
		}
		private function greaterOrEquals(square:int, height:int, width:int):Boolean {
			return height * width >= square;
		}
		private function equals(square:int, height:int, width:int):Boolean {
			return height * width == square;
		}
		private function lower(square:int, height:int, width:int):Boolean {
			return height * width < square;
		}
		private function lowerOrEquals(square:int, height:int, width:int):Boolean {
			return height * width <= square;
		}		
		
		public function receiveData(message:String):void
		{
			this.model.recievedData = message;
		}
		
	}
}