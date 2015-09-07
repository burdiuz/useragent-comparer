/**
 * Created with IntelliJ IDEA.
 * User: Oleg Galabura
 * Date: 28.01.13
 * Time: 13:35
 * To change this template use File | Settings | File Templates.
 */
package {
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequestHeader;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayList;

	[Bindable]
	public class Settings {
		static public const FILE_NAME:String = "settings.amf";
		static public const instance:Settings = new Settings();
		public var userAgents:ArrayList = new ArrayList([
			new UserAgent("Googlebot 2.1", "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"), 
			new UserAgent("Bingbot 2.0", "Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)"), 
			new UserAgent("Yahoo! Slurp", "Mozilla/5.0 (compatible; Yahoo! Slurp; http://help.yahoo.com/help/us/ysearch/slurp)"), 
			new UserAgent("YandexBot 3.0", "Mozilla/5.0 (compatible; YandexBot/3.0; +http://yandex.com/bots)"), 
			new UserAgent("Android Webkit Browser", "Mozilla/5.0 (Linux; U; Android 4.0.3; ko-kr; LG-L160L Build/IML74K) AppleWebkit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30"), 
			new UserAgent("BlackBerry", "Mozilla/5.0 (BlackBerry; U; BlackBerry 9900; en) AppleWebKit/534.11+ (KHTML, like Gecko) Version/7.1.0.346 Mobile Safari/534.11+"), 
			new UserAgent("Nokia N97i", "NokiaN97i/SymbianOS/9.1 Series60/3.0"), 
			new UserAgent("IEMobile 9.0", "Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0)"), 
			new UserAgent("Opera Mini 9.80", "Opera/9.80 (J2ME/MIDP; Opera Mini/9.80 (S60; SymbOS; Opera Mobi/23.348; U; en) Presto/2.5.25 Version/10.54"), 
			new UserAgent("Opera Mobile 12.02", "Opera/12.02 (Android 4.1; Linux; Opera Mobi/ADR-1111101157; U; en-US) Presto/2.9.201 Version/12.02"), 
			new UserAgent("Safari 6.0", "Mozilla/5.0 (iPad; CPU OS 6_0 like Mac OS X) AppleWebKit/536.26 (KHTML, like Gecko) Version/6.0 Mobile/10A5355d Safari/8536.25"), 
			new UserAgent("Firefox 16.0.1", "Mozilla/6.0 (Windows NT 6.2; WOW64; rv:16.0.1) Gecko/20121011 Firefox/16.0.1"), 
			new UserAgent("Chrome 24.0.1312.60", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.60 Safari/537.17"), 
			new UserAgent("Internet Explorer 10.6", "Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0"), 
			new UserAgent("Opera 12.14", "Opera/9.80 (Windows NT 6.0) Presto/2.12.388 Version/12.14"), 
			new UserAgent("Lynx 2.8.7rel.2", "Lynx/2.8.7rel.2 libwww-FM/2.14 SSL-MM/1.4.1 OpenSSL/1.0.0a")
		]);
		public var customHeaders:ArrayList = new ArrayList([
			new CustomHeader("Accept-Encoding", "gzip, deflate"), 
			new CustomHeader("Accept-Language", "q=0.8,en-us;q=0.5,en;q=0.3")
		]);
		public var enableCookies:Boolean = false;
		public var startMaximized:Boolean = true;
		public var url:String = "";
		public function Settings():void{
			super();
			if(instance) throw new Error("Settings class cannot be instantiated, use static property \"instance\" instead.");
			readInternal(this);
		}
		public function getRequestHeaders():Array{
			const headers:Array = [];
			for each(var header:CustomHeader in this.customHeaders.source){
				if(header && header.isValid()){
					headers.push(header.getHeader());
				}
			}
			return headers;
		}
		static public function read():void{
			readInternal(Settings.instance);
		}
		static private function readInternal(target:Settings):void{
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			if(!file.exists || file.isDirectory) return;
			const bytes:ByteArray = FileUtils.read(file);
			bytes.position = 0;
			var object:Object = bytes.readObject();
			for(var property:String in object){
				if(property in target) target[property] = object[property];
			}
		}
		static public function write():void{
			var file:File = File.applicationStorageDirectory.resolvePath(FILE_NAME);
			if(file.exists) file.deleteFile();
			const bytes:ByteArray = new ByteArray();
			bytes.writeObject(instance);
			FileUtils.write(bytes, file);
		}
	}
}
