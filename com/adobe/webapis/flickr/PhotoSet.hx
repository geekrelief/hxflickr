/*
Adobe Systems Incorporated(r) Source Code License Agreement
Copyright(c) 2005 Adobe Systems Incorporated. All rights reserved.
	
Please read this Source Code License Agreement carefully before using
the source code.
	
Adobe Systems Incorporated grants to you a perpetual, worldwide, non-exclusive,
no-charge, royalty-free, irrevocable copyright license, to reproduce,
prepare derivative works of, publicly display, publicly perform, and
distribute this source code and such derivative works in source or
object code form without any attribution requirements.
	
The name "Adobe Systems Incorporated" must not be used to endorse or promote products
derived from the source code without prior written permission.
	
You agree to indemnify, hold harmless and defend Adobe Systems Incorporated from and
against any loss, damage, claims or lawsuits, including attorney's
fees that arise or result from your use or distribution of the source
code.
	
THIS SOURCE CODE IS PROVIDED "AS IS" AND "WITH ALL FAULTS", WITHOUT
ANY TECHNICAL SUPPORT OR ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. ALSO, THERE IS NO WARRANTY OF
NON-INFRINGEMENT, TITLE OR QUIET ENJOYMENT. IN NO EVENT SHALL MACROMEDIA
OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOURCE CODE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.webapis.flickr; 
	
	/**
	 * PhotoSet is a ValueObject for the Flickr API.
	 */
	class PhotoSet {
		
		public var description(getDescription, setDescription) : String ;
		
		public var id(getId, setId) : String ;
		
		public var ownerId(getOwnerId, setOwnerId) : String ;
		
		public var photoCount(getPhotoCount, setPhotoCount) : Int ;
		
		public var photos(getPhotos, setPhotos) : Array<Dynamic> ;
		
		public var primaryPhotoId(getPrimaryPhotoId, setPrimaryPhotoId) : String ;
		
		public var secret(getSecret, setSecret) : String ;
		
		public var server(getServer, setServer) : Int ;
		
		public var title(getTitle, setTitle) : String ;
		
		public var url(getUrl, setUrl) : String ;
		
		private var _id:String;
		private var _title:String;
		private var _url:String;
		private var _description:String;
		private var _photoCount:Int;
		private var _primaryPhotoId:String;
		private var _ownerId:String;
		private var _secret:String;
		private var _server:Int;
		private var _photos:Array<Dynamic>;
		
		/**
		 * Construct a new PhotoSet instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			_photos = new Array();
		}
		
		/**
		 * The id of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getId():String {
			return _id;
		}
		
		public function setId( value:String ):String {
			_id = value;
			return value;
		}
		
		/**
		 * The title of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTitle():String {
			return _title;
		}
		
		public function setTitle( value:String ):String {
			_title = value;
			return value;
		}
		
		/**
		 * The url of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getUrl():String {
			return _url;
		}
		
		public function setUrl( value:String ):String {
			_url = value;
			return value;
		}
		
		/**
		 * The description of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getDescription():String {
			return _description;
		}
		
		public function setDescription( value:String ):String {
			_description = value;
			return value;
		}
		
		/**
		 * The photo count of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotoCount():Int {
			return _photoCount;
		}
		
		public function setPhotoCount( value:Int ):Int {
			_photoCount = value;
			return value;
		}
		
		/**
		 * The primary photo id of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPrimaryPhotoId():String {
			return _primaryPhotoId;
		}
		
		public function setPrimaryPhotoId( value:String ):String {
			_primaryPhotoId = value;
			return value;
		}
		
		/**
		 * The owner id of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOwnerId():String {
			return _ownerId;
		}
		
		public function setOwnerId( value:String ):String {
			_ownerId = value;
			return value;
		}
		
		/**
		 * The secret of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getSecret():String {
			return _secret;
		}
		
		public function setSecret( value:String ):String {
			_secret = value;
			return value;
		}
		
		/**
		 * The server of the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getServer():Int {
			return _server;
		}
		
		public function setServer( value:Int ):Int {
			_server = value;
			return value;
		}
		
		/**
		 * The photos in the photo set
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotos():Array<Dynamic> {
			return _photos;
		}
		
		public function setPhotos( value:Array<Dynamic> ):Array<Dynamic> {
			_photos = value;
			return value;
		}
				
	}
