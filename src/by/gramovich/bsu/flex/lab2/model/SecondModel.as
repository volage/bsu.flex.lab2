package by.gramovich.bsu.flex.lab2.model
{
	/**
	 * Model for data from second application
	 */
	public class SecondModel
	{
		private static var instance:SecondModel;
		
		[Bindable]
		public var recievedlData:String;
		
		[Bindable]
		public var sendInput:String;
		
		public function SecondModel() { 
			instance = this;
		}
		
		public static function getInstance():SecondModel {
			if (instance == null) {
				return new SecondModel();
			}
			return instance;
		}
	}
}