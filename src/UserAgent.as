package {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	[Bindable]
	[RemoteClass("UserAgent")]
	public class UserAgent extends EventDispatcher{
		public var title:String;
		public var value:String;
		public function UserAgent(title:String="", value:String=""):void{
			super();
			this.title = title;
			this.value = value;
		}
		override public function toString():String{
			return this.value;
		}
		public function valueOf():Object{
			return this.value;
		}
	}
}