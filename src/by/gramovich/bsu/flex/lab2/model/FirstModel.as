package by.gramovich.bsu.flex.lab2.model
{
	import mx.collections.ArrayCollection;

	/**
	 * Model for data from first application
	 */
	public class FirstModel
	{
		private static var instance:FirstModel;
		
		[Bindable]
		public var xml:XML;
		
		[Bindable]
		public var selection:String;
		/**
		 * Collection of compare operatons
		 */
		[Bindable]
		public var comparisonOperations:ArrayCollection = new ArrayCollection([{label:"<", data:"lower"},
			{label:"<=", data:"lowerOrEquals"},
			{label:"=", data:"equals"}, 
			{label:">", data:"greater"},
			{label:">=", data:"greaterOrEquals"}]);
		[Bindable]
		public var selectedComparison:Object;
		[Bindable]
		public var squareInput:String;
		
		[Bindable]
		public var selectedType:String;
		
		[Bindable]
		public var recievedData:String;
		
		[Bindable]
		public var types:ArrayCollection = new ArrayCollection();
		
		public function FirstModel()
		{
			instance = this;
		}
		
		public static function getInstance():FirstModel {
			if (instance == null) {
				return new FirstModel();
			}
			return instance;
		}

		
		
	}
}