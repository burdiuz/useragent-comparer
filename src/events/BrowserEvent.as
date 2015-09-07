package events{
	import flash.events.Event;
	
	public class BrowserEvent extends Event{
		static public const LOCATION_UPDATE:String = "locationUpdate";
		static public const TITLE_UPDATE:String = "titleUpdate";
		private var _value:String;
		public function BrowserEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false, value:String=null):void{
			super(type, bubbles, cancelable);
			_value = value;
		}
		public function get value():String{
			return this._value;
		}
		override public function clone():Event{
			return new BrowserEvent(this.type, this.bubbles, this.cancelable, this._value);
		}
	}
}