package{
	import events.BrowserEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.html.HTMLHost;
	
	[Event(name="titleUpdate", type="events.BrowserEvent")]
	[Event(name="locationUpdate", type="events.BrowserEvent")]
	public class BrowserHost extends HTMLHost implements IEventDispatcher{
		private var _dispatcher:IEventDispatcher;
		public function BrowserHost():void{
			super(false);
			_dispatcher = new EventDispatcher(this);
		}
		override public function updateLocation(locationURL:String):void{
			this._dispatcher.dispatchEvent(new BrowserEvent(BrowserEvent.LOCATION_UPDATE, false, false, locationURL));
		}
		override public function updateTitle(title:String):void{
			this._dispatcher.dispatchEvent(new BrowserEvent(BrowserEvent.TITLE_UPDATE, false, false, title));
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void{
			this._dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void{
			this._dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean{
			return this._dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean{
			return this._dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean{
			return this._dispatcher.willTrigger(type);
		}
	}
}