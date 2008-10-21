/*
	Copyright (c) 2008, Adobe Systems Incorporated
	All rights reserved.

	Redistribution and use in source and binary forms, with or without 
	modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, 
    	this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, 
    	this list of conditions and the following disclaimer in the 
    	documentation and/or other materials provided with the distribution.
    * Neither the name of Adobe Systems Incorporated nor the names of its 
    	contributors may be used to endorse or promote products derived from 
    	this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
	AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
	IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
	ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
	LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
	CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
	SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
	INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
	CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
	ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
	POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.webapis.flickr; 
	
	/**
	 * User is a ValueObject for the Flickr API.
	 */
	/*[RemoteClass(alias="com.adobe.webapis.flickr.User")]*/
	class User {
		
		public var bandwidthMax(getBandwidthMax, setBandwidthMax) : Int ;
		
		public var bandwidthUsed(getBandwidthUsed, setBandwidthUsed) : Int ;
		
		public var filesizeMax(getFilesizeMax, setFilesizeMax) : Int ;
		
		public var firstPhotoTakenDate(getFirstPhotoTakenDate, setFirstPhotoTakenDate) : Date ;
		
		public var firstPhotoUploadDate(getFirstPhotoUploadDate, setFirstPhotoUploadDate) : Date ;
		
		public var fullname(getFullname, setFullname) : String ;
		
		public var iconServer(getIconServer, setIconServer) : Int ;
		
		public var isAdmin(getIsAdmin, setIsAdmin) : Bool ;
		
		public var isFamily(getIsFamily, setIsFamily) : Bool ;
		
		public var isFriend(getIsFriend, setIsFriend) : Bool ;
		
		public var isIgnored(getIsIgnored, setIsIgnored) : Bool ;
		
		public var isPro(getIsPro, setIsPro) : Bool ;
		
		public var location(getLocation, setLocation) : String ;
		
		public var mboxSha1Sum(getMboxSha1Sum, setMboxSha1Sum) : String ;
		
		public var nsid(getNsid, setNsid) : String ;
		
		public var photoCount(getPhotoCount, setPhotoCount) : Int ;
		
		public var photoUrl(getPhotoUrl, setPhotoUrl) : String ;
		
		public var profileUrl(getProfileUrl, setProfileUrl) : String ;
		
		public var tags(getTags, setTags) : Array<Dynamic> ;
		
		public var url(getUrl, setUrl) : String ;
		
		public var username(getUsername, setUsername) : String ;
		
		private var _nsid:String;
		private var _username:String;
		private var _fullname:String;
		private var _isPro:Bool;
		private var _bandwidthMax:Int;
		private var _bandwidthUsed:Int;
		private var _filesizeMax:Int;
		private var _url:String;
		private var _isIgnored:Bool;
		private var _isFriend:Bool;
		private var _isFamily:Bool;
		private var _isAdmin:Bool;
		private var _iconServer:Int;
		private var _mboxSha1Sum:String;
		private var _location:String;
		private var _photoUrl:String;
		private var _profileUrl:String;
		private var _firstPhotoUploadDate:Date;
		private var _firstPhotoTakenDate:Date;
		private var _photoCount:Int;
		private var _tags:Array<Dynamic>;
		
		
		
		public var iconFarm:Int;
		
		/**
		 * Construct a new User instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			_tags = new Array();
		}	
		
		/**
		 * The NSID of the user
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
		 * The username of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getUsername():String {
			return _username;
		}
		
		public function setUsername( value:String ):String {
			_username = value;
			return value;
		}
		
		/**
		 * The full name of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getFullname():String {
			return _fullname;
		}
		
		public function setFullname( value:String ):String {
			_fullname = value;
			return value;
		}
		
		/**
		 * Flag if the user has a pro account
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsPro():Bool {
			return _isPro;
		}
		
		public function setIsPro( value:Bool ):Bool {
			_isPro = value;
			return value;
		}
		
		/**
		 * The max bandwidth for the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getBandwidthMax():Int {
			return _bandwidthMax;
		}
		
		public function setBandwidthMax( value:Int ):Int {
			_bandwidthMax = value;
			return value;
		}
		
		/**
		 * The used bandwidth for the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getBandwidthUsed():Int {
			return _bandwidthUsed;
		}
		
		public function setBandwidthUsed( value:Int ):Int {
			_bandwidthUsed = value;
			return value;
		}
		
		/**
		 * The max filesize of an image for the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getFilesizeMax():Int {
			return _filesizeMax;
		}
		
		public function setFilesizeMax( value:Int ):Int {
			_filesizeMax = value;
			return value;
		}
		
		/**
		 * The url for the user's flickr page
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
		 * Flag if the user is ignored
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsIgnored():Bool {
			return _isIgnored;	
		}
		
		public function setIsIgnored( value:Bool ):Bool {
			_isIgnored = value;
			return value;
		}
		
		/**
		 * Flag if the user is family
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsFamily():Bool {
			return _isFamily;	
		}
		
		public function setIsFamily( value:Bool ):Bool {
			_isFamily = value;
			return value;
		}
		
		/**
		 * Flag if the user is friend
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsFriend():Bool {
			return _isFriend;
		}
		
		public function setIsFriend( value:Bool ):Bool {
			_isFriend = value;
			return value;
		}
		
		/**
		 * Flag if the user is an admin
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
		 * The icon server of the user
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
		 * The sha1 sum of the mailbox of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getMboxSha1Sum():String {
			return _mboxSha1Sum;
		}
		
		public function setMboxSha1Sum( value:String ):String {
			_mboxSha1Sum = value;
			return value;
		}
		
		/**
		 * The location of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getLocation():String {
			return _location;
		}
		
		public function setLocation( value:String ):String {
			_location = value;
			return value;
		}
		
		/**
		 * The photo url of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotoUrl():String {
			return _photoUrl;
		}
		
		public function setPhotoUrl( value:String ):String {
			_photoUrl = value;
			return value;
		}
		
		/**
		 * The profile url of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getProfileUrl():String {
			return _profileUrl;
		}
		
		public function setProfileUrl( value:String ):String {
			_profileUrl = value;
			return value;
		}
		
		/**
		 * The date of the user's first photo upload
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getFirstPhotoUploadDate():Date {
			return _firstPhotoUploadDate;
		}
		
		public function setFirstPhotoUploadDate( value:Date ):Date {
			_firstPhotoUploadDate = value;
			return value;
		}
		
		/**
		 * The date of the user's first photo taken
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getFirstPhotoTakenDate():Date {
			return _firstPhotoTakenDate;
		}
		
		public function setFirstPhotoTakenDate( value:Date ):Date {
			_firstPhotoTakenDate = value;
			return value;
		}
		
		/**
		 * The number of photos uploaded by the user
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
		 * The tags of the user
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTags():Array<Dynamic> {
			return _tags;
		}
		
		public function setTags( value:Array<Dynamic> ):Array<Dynamic> {
			_tags = value;
			return value;
		}
		
	}
	
