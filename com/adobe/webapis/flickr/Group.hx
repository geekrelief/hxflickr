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
	 * Group is a ValueObject for the Flickr API.
	 */
	class Group {
		
		public var chatNsid(getChatNsid, setChatNsid) : String ;
		
		public var description(getDescription, setDescription) : String ;
		
		public var iconServer(getIconServer, setIconServer) : Int ;
		
		public var inChat(getInChat, setInChat) : Int ;
		
		public var isAdmin(getIsAdmin, setIsAdmin) : Bool ;
		
		public var isEighteenPlus(getIsEighteenPlus, setIsEighteenPlus) : Bool ;
		
		public var members(getMembers, setMembers) : Int ;
		
		public var name(getName, setName) : String ;
		
		public var nsid(getNsid, setNsid) : String ;
		
		public var online(getOnline, setOnline) : Int ;
		
		public var photos(getPhotos, setPhotos) : Int ;
		
		public var privacy(getPrivacy, setPrivacy) : Int ;
		
		public var url(getUrl, setUrl) : String ;
		
		private var _nsid:String;
		private var _name:String;
		private var _description:String;
		private var _privacy:Int;
		private var _members:Int;
		private var _online:Int;
		private var _chatNsid:String;
		private var _inChat:Int;
		private var _isEighteenPlus:Bool;
		private var _isAdmin:Bool;
		private var _photos:Int;
		private var _iconServer:Int;
		private var _url:String;
		
		/**
		 * Construct a new Group instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}	
		
		/**
		 * The nsid of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getNsid():String {
			return _nsid;
		}
		
		public function setNsid( value:String ):String {
			_nsid = value;
			return value;
		}
		
		/**
		 * The name of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getName():String {
			return _name;
		}
		
		public function setName( value:String ):String {
			_name = value;
			return value;
		}
		
		/**
		 * The description of the group
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
		 * The privacy of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPrivacy():Int {
			return _privacy;
		}
		
		public function setPrivacy( value:Int ):Int {
			_privacy = value;
			return value;
		}
		
		/**
		 * The members in the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getMembers():Int {
			return _members;
		}
		
		public function setMembers( value:Int ):Int {
			_members = value;
			return value;
		}
		
		/**
		 * The number of group members online
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOnline():Int {
			return _online;
		}
		
		public function setOnline( value:Int ):Int {
			_online = value;
			return value;
		}
		
		/**
		 * The chatNsid of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getChatNsid():String {
			return _chatNsid;
		}
		
		public function setChatNsid( value:String ):String {
			_chatNsid = value;
			return value;
		}
		
		/**
		 * The number of people in the group chat
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getInChat():Int {
			return _inChat;
		}
		
		public function setInChat( value:Int ):Int {
			_inChat = value;
			return value;
		}
		
		/**
		 * Flag for if the group is 18+ or not
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsEighteenPlus():Bool {
			return _isEighteenPlus;	
		}
		
		public function setIsEighteenPlus( value:Bool ):Bool {
			_isEighteenPlus = value;	
			return value;
		}
		
		/**
		 * Flag for if the current user is the admin of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsAdmin():Bool {
			return _isAdmin;	
		}
		
		public function setIsAdmin( value:Bool ):Bool {
			_isAdmin = value;	
			return value;
		}
		
		/**
		 * The number of photos in the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotos():Int {
			return _photos;	
		}
		
		public function setPhotos( value:Int ):Int {
			_photos = value;	
			return value;
		}
		
		/**
		 * The icon server of the group
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIconServer():Int {
			return _iconServer;
		}
		
		public function setIconServer( value:Int ):Int {
			_iconServer = value;
			return value;
		}
		
		/**
		 * The url of the group
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
		
	}
