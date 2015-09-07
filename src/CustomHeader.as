package {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequestHeader;

	[Bindable]
	[RemoteClass("CustomHeader")]
	public class CustomHeader extends EventDispatcher{
		public var name:String;
		public var value:String;
		public function CustomHeader(name:String="", value:String=""):void{
			super();
			this.name = name;
			this.value = value;
		}
		public function isValid():Boolean{
			return this.name && this.value;
		}
		public function getHeader():URLRequestHeader{
			return new URLRequestHeader(this.name, this.value);
		}
	}
}