/**
* @author 		Shang Liang
* @copyright 	(c) New BSD Liscence - http://www.opensource.org/licenses/bsd-license.php
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
* 
*@description 	This example demonstrates retrieving photos with specific tags from Flickr with Adobe's as3flickrlib (http://code.google.com/p/as3flickrlib/) as part of Adobe's as3corelib (http://actionscript3libraries.riaforge.org/). From here, you can try more complicated functions like uploading and edit photos etc. 
* 
* 				There's no much documentation in as3flickrlib. You need to cross reference with Flickr API documentations (http://www.flickr.com/services/api/). The most confusing part is the FlickrResultEvent. All values are in event.data and the data structure for data is unknown. You need to check Flickr's API but sometimes the variable names are not consistent with Flickr's definition. One way to find out what data is there is to use a for loop e.g
* 				for(var i:String in evt.data) trace(i+": "+evt.data[i])
*/
package com.sl.flickr.sample; 
	
	import caurina.transitions.Tweener;	
	
	
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.PagedPhotoList;
	import com.adobe.webapis.flickr.Photo;
	import com.adobe.webapis.flickr.PhotoSize;
	import flash.text.TextField;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.system.Security;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Bitmap;
	import flash.system.LoaderContext;
	import flash.net.URLRequest;

	import flash.display.StageScaleMode;
	import flash.display.StageAlign;
	import flash.display.Stage;

	class Main extends MovieClip{

		/**
		 * Flickr URL address, used for Security.allowDomain.
		 */
		inline public static var FLICKR_URL:String = "http://www.flickr.com";
		inline public static var CROSSDOMAIN_URL:String = "http://api.flickr.com/crossdomain.xml";
		/**
		 * Developer's API key
		 */
		inline public static var API:String = "YOUR_API_KEY";
		/**
		 * API's secret number
		 */
		inline public static var SECRET:String = "YOUR_SECRET";

		/**
		 * FlickrService instance
		 */
		private var fs:FlickrService;

		private static var cur:MovieClip = flash.Lib.current;		
		/**
		 * PagedPhotoList to hold all photos
		 */
		private var photoList:PagedPhotoList;
		/**
		 * Current photo index in photoArr
		 */
		private var photoIndex:Int;
		/**
		 * Timer, used for tracking how long to load the images and stuff
		 */
		private var t:Int;

		static function main() {
			new Main();
		}

		/**
		 * Constructor
		 */
		public function new() {
			super();
			t = Std.int(flash.Lib.getTimer());

			/**
			 * Allow flickr domain, so we can do all the bitmapdata stuff
			 */
			
			Security.allowDomain(FLICKR_URL);
			Security.loadPolicyFile(CROSSDOMAIN_URL);
			
			
			/**
			 * Initialise FlikrService with the API keystrange 
			 * Secret number is also required, and it's assigned in the next line
			 * Why the constructor doesn't take secret key as the second parameter is not known. But I believe there's a valid reason
			 */
			fs = new FlickrService(API);
			fs.secret = SECRET;
			/**
			 * Get frob. Not sure what does it mean, but it's a must.
			 */
			fs.auth.getFrob();
			/**
			 * Listen for the response of the event
			 * Error listeners can be put for monitoring errors
			 */
			fs.addEventListener(FlickrResultEvent.AUTH_GET_FROB, hGetFrob);
			
			/**
			 * Set stage scale mode and stuff
			 */
			cur.stage.scaleMode = StageScaleMode.NO_SCALE;
			cur.stage.align = StageAlign.TOP_LEFT;
			cur.stage.addEventListener(Event.RESIZE, hStageResize);
			
			/**
			 * Start recording the timer
			 */
			t = Std.int(flash.Lib.getTimer());
		}
		
		/**
		 * Event handler for AUTH_GET_FROB
		 * Further calls need to wait till Frob is set
		 * @param	evt
		 */
		private function hGetFrob(evt:FlickrResultEvent):Void {
			if (evt.success) {
				trace("frob acquired");
				search();
			}
		}
		/**
		 * Search for photos with tag "dragonfly"
		 */
		private function search():Void {
			fs.photos.search("","ikaruga");
			/**
			 * Add event listener for search complete
			 */
			fs.addEventListener(FlickrResultEvent.PHOTOS_SEARCH, hPhotoSearch);
		}
		/**
		 * Event handler for PHOTOS_SEARCH
		 * @param	evt
		 */
		private function hPhotoSearch(evt:FlickrResultEvent):Void {
			trace("search finish");
			/**
			 * In this evt.data, photos are stored in data.photos and the data type is PagedPhotoList not an Array
			 * An array photos are stored in PagedPhotoList.photos
			 */
			photoList = evt.data.photos;
			/**
			 * Randomize the sequence a bit
			 */
			var temp:Photo;
			var p:Int;
			var len:Int = photoList.photos.length;
			for (i in 0...len) {
				temp = photoList.photos[i];
				p = Math.ceil(Math.random() * len);
				photoList.photos[i] = photoList.photos[p];
				photoList.photos[p] = temp;
			}
			photoIndex = 0;
			loadPhoto();
			
		}
		/**
		 * First step of loading a photo
		 * Get the url address first by calling getSizes()
		 */
		private function loadPhoto() {
			/**
			 * Get the Photo object going to load. The problem is photos retrieved through search function do not have complete information. 
			 * According to Flickr's API, it looks like this <photo id="2636" owner="47058503995@N01" secret="a123456" server="2" title="test_04" ispublic="1" isfriend="0" isfamily="0" />. There's no direct url to load the photo. We need to call another function getSizes() to get the path using the photo's ID
			 */
			var p:Photo = photoList.photos[photoIndex];
			photoIndex++;
			if (photoIndex == photoList.photos.length) {
				photoIndex = 0;
			}
			if (p.id == "") {
				loadPhoto();
				return;
			}
			fs.photos.getSizes(p.id);
			fs.addEventListener(FlickrResultEvent.PHOTOS_GET_SIZES, hPhotoSize);
			
			trace("getting photo sizes " + p.id);
		}
		/**
		 * Event Handler for PHOTOS_GET_SIZES
		 * @param	evt
		 */
		private function hPhotoSize(evt:FlickrResultEvent):Void {
			trace("size loaded");
			/**
			 * In this evt.data, photo sizes are are stored in data.photoSizes and the data type is an Array
			 * Each element in the data.photoSizes array is an PhotoSize object, confusing?
			 */
			var sizeArr:Array<PhotoSize> = evt.data.photoSizes;	
			/**
			 * The array stores photos in acending order, the last photoSize is the biggest photo. Let's get the largest because it should be the clearest.
			 */
			var s:PhotoSize = sizeArr[sizeArr.length - 1]; // get the second largest.
			/**
			 * Finally we know where to load the image. It's stored in PhotoSize.source (don't get bluffed by PhotoSize.url, it's the HTML page address)
			 */
			var l:Loader = new Loader();			
			l.load(new URLRequest(s.source),new LoaderContext(true));
			trace("loading photo sizes " + s.source);
			l.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, hPhotoProgress);
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, hPhotoComplete);
			cur.stage.addChild(l);
						
			/**
			 * Bring the text field to the front
			 */
			//var txt:TextField = cast( getChildByName("trace_txt"), TextField);
			//setChildIndex(txt, numChildren - 1);
			//var loading:MovieClip = cast( getChildByName("loading_mc"), MovieClip);
			//loading.visible = true;
			//setChildIndex(loading, numChildren - 1);
		}
		/**
		 * Event Handler for PROGRESS, monitor loading progress
		 * @param	evt
		 */
		private function hPhotoProgress(evt:ProgressEvent):Void {
			trace("loading image: " + evt.bytesLoaded +"/" + evt.bytesTotal);
			//var loading:MovieClip = cast( getChildByName("loading_mc"), MovieClip);			
		}
		/**
		 * Event Handler for PROGRESS, monitor loading progress
		 * @param	evt
		 */
		private function hPhotoComplete(evt:Event):Void {
			trace("photo loaded");
			
			var li:LoaderInfo = cast( evt.currentTarget, LoaderInfo);
			var loader:Loader = li.loader;
			
			var bm:Bitmap = cast( loader.content, Bitmap);
			bm.smoothing = true;
			loader.alpha = 0;
			/**
			 * rotate the photo if it's a portrait
			 */
			trace(bm.width, bm.height);
			if (bm.width < bm.height) {
				bm.y = bm.width;
				bm.rotation = -90;				
			}
			trace(bm.x, bm.y);
			/**
			 * resize the photo to fit the screen
			 */
			hStageResize();
			
			/**
			 * Give it some Mac effect
			 * Not very good programming here, but since it only run once every 10 seconds, not a big deal
			 */
			var ox:Float = loader.x;
			var oy:Float = loader.y;
			
			var oscale:Float = loader.scaleX;			
			loader.scaleX = loader.scaleY = oscale * 1.05;
			
			var w:Float = loader.width;
			var h:Float = loader.height;
			var sw:Int = cur.stage.stageWidth;
			var sh:Int = cur.stage.stageHeight;
			
			loader.x = Math.min(0,loader.x+(Math.random()-0.5) * (w - sw));
			loader.y = Math.min(0, loader.y+(Math.random() -0.5)* (h - sh));
			
			Tweener.addTween(loader, { alpha:1, time:1, transition:"easeInOutQuad" } );
			Tweener.addTween(loader, { x:ox, y:oy, scaleX:oscale, scaleY:oscale, time:5, transition:"easeInOutQuad" } );
			
			/**
			 * Remove the image after 60 seconds
			 */
			Tweener.addTween(loader, { delay:20, onComplete:function():Void{ cur.stage.removeChild(loader);}});
			/**
			 * Load the next photo after 5 seconds
			 */
			Tweener.addTween(this, { delay:5, onComplete:loadPhoto } );
			
			//var loading:MovieClip = cast( getChildByName("loading_mc"), MovieClip);
			//loading.visible = false;
		}

		/**
		 * Event Handler for stage RESIZE.
		 * Make images full screen, crop and resize them if necessary
		 * @param	evt
		 */
		private function hStageResize(?evt:Event=null):Void {
			var sw:Int = cur.stage.stageWidth;
			var sh:Int = cur.stage.stageHeight;			
			for (i in 0...numChildren) {
				if (!Std.is(getChildAt(i), Loader)) {
					continue;
				}
				var l:Loader = cast( getChildAt(i), Loader);
				Tweener.removeTweens(l, ["x", "y", "scaleX", "scaleY"]);
				var w:Float = l.width / l.scaleX;
				var h:Float = l.height / l.scaleY;
				var ratio:Float = Math.max(sw/w, sh/h);
				l.scaleY = l.scaleX = ratio;
				l.x = (sw-l.width) / 2;
				l.y = (sh-l.height) / 2;
			}
		}
		/**
		 * Trace function
		 * @param	str
		 */
		private function log(str:String):Void {
			//var txt:TextField = cast( getChildByName("trace_txt"), TextField);
			//var timeStr:String=((Std.int(Lib.getTimer())-t)/1000).toPrecision(2)+":\t";
			//txt.appendText(timeStr+str + "\n");
			//txt.scrollV = txt.maxScrollV;
			//trace(str);
		}
	}
	

