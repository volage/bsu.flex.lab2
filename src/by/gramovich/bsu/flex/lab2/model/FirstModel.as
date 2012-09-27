package by.gramovich.bsu.flex.lab2.model
{
	import mx.collections.ArrayCollection;

	public class FirstModel
	{
		
		[Bindable]
		public var xmlBase:XML;
		
		[Bindable]
		public var messageToSend:String;
		
		[Bindable]
		public var selectedType:String;
		
		[Bindable]
		public var selectedOperation:String;
		
		[Bindable]
		public var selectedSquare:String;
		
		[Bindable]
		public var externalData:String;
		
		[Bindable]
		public var types:ArrayCollection = new ArrayCollection();
		
		/**
		 * Collection of compare operatons
		 */
		public var comparisonOperations:ArrayCollection = new ArrayCollection(["<", "<=", "=", ">=", ">"]);
		
		public function FirstModel()
		{}

		
		
	}
}