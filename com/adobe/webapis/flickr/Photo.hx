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
	 * Photo is a ValueObject for the Flickr API.
	 */
	class Photo {
		
		public var addMetaPermission(getAddMetaPermission, setAddMetaPermission) : Int ;
		
		public var canAddMeta(getCanAddMeta, setCanAddMeta) : Int ;
		
		public var canComment(getCanComment, setCanComment) : Int ;
		
		public var commentCount(getCommentCount, setCommentCount) : Int ;
		
		public var commentPermission(getCommentPermission, setCommentPermission) : Int ;
		
		public var dateAdded(getDateAdded, setDateAdded) : Date ;
		
		public var dateTaken(getDateTaken, setDateTaken) : Date ;
		
		public var dateUploaded(getDateUploaded, setDateUploaded) : Date ;
		
		public var description(getDescription, setDescription) : String ;
		
		public var exifs(getExifs, setExifs) : Array<Dynamic> ;
		
		public var iconServer(getIconServer, setIconServer) : Int ;
		
		public var id(getId, setId) : String ;
		
		public var isFamily(getIsFamily, setIsFamily) : Bool ;
		
		public var isFavorite(getIsFavorite, setIsFavorite) : Bool ;
		
		public var isFriend(getIsFriend, setIsFriend) : Bool ;
		
		public var isPublic(getIsPublic, setIsPublic) : Bool ;
		
		public var license(getLicense, setLicense) : Int ;
		
		public var notes(getNotes, setNotes) : Array<Dynamic> ;
		
		public var originalFormat(getOriginalFormat, setOriginalFormat) : String ;
		
		public var ownerId(getOwnerId, setOwnerId) : String ;
		
		public var ownerLocation(getOwnerLocation, setOwnerLocation) : String ;
		
		public var ownerName(getOwnerName, setOwnerName) : String ;
		
		public var ownerRealName(getOwnerRealName, setOwnerRealName) : String ;
		
		public var rotation(getRotation, setRotation) : Int ;
		
		public var secret(getSecret, setSecret) : String ;
		
		public var server(getServer, setServer) : Int ;
		
		public var tags(getTags, setTags) : Array<Dynamic> ;
		
		public var title(getTitle, setTitle) : String ;
		
		public var url(getUrl, setUrl) : String ;
		
		public var urls(getUrls, setUrls) : Array<Dynamic> ;
		
		private var _id:String;
		private var _ownerId:String;
		private var _ownerName:String;
		private var _secret:String;
		private var _server:Int;
		private var _iconServer:Int;
		private var _title:String;
		private var _description:String;
		private var _commentCount:Int;
		private var _isPublic:Bool;
		private var _isFriend:Bool;
		private var _isFamily:Bool;
		private var _license:Int;
		private var _dateUploaded:Date;
		private var _dateTaken:Date;
		private var _dateAdded:Date;
		private var _originalFormat:String;
		private var _url:String;
		private var _exifs:Array<Dynamic>;
		private var _rotation:Int;
		private var _ownerRealName:String;
		private var _ownerLocation:String;
		private var _isFavorite:Bool;
		private var _commentPermission:Int;
		private var _addMetaPermission:Int;
		private var _canComment:Int;
		private var _canAddMeta:Int;
		private var _notes:Array<Dynamic>;
		private var _tags:Array<Dynamic>;
		private var _urls:Array<Dynamic>;
		
		/**
		 * Construct a new Photo instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */
		public function new() {
			_exifs = new Array();
			_notes = new Array();
			_tags = new Array();
			_urls = new Array();
		}	
		
		/**
		 * The server farm id of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */		
		public var farmId:Int;
		
		/**
		 * The secret necessary to retrieve original source of photos
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */			
		public var originalSecret:String;
	
		/**
		 * The latitude that the image was taken at.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */			
		public var latitude:String;
		
		/**
		 * The longitude that the image was taken at.
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 9.0
		 * @tiptext
		 */			
		public var longitude:String;
		
		
		/**
		 * The id of the photo
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
		 * The id of owner of the photo
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
		 * The name of owner of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOwnerName():String {
			return _ownerName;
		}
		
		public function setOwnerName( value:String ):String {
			_ownerName = value;
			return value;
		}
		
		/**
		 * The photo secret
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
		 * The server of the photo
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
		 * The icon server of the photo
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
		 * The title of the photo
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
		 * The description of the photo
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
		 * The number of comments on the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getCommentCount():Int {
			return _commentCount;
		}
		
		public function setCommentCount( value:Int ):Int {
			_commentCount = value;
			return value;
		}
		
		/**
		 * Flag for the photo having public access
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsPublic():Bool {
			return _isPublic;
		}
		
		public function setIsPublic( value:Bool ):Bool {
			_isPublic = value;
			return value;
		}
		
		/**
		 * Flag for the photo having friend access
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
		 * Flag for the photo having family access
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
		 * The license of the photo, corresponding
		 * to a constant in the License class
		 *
		 * @see com.adobe.webapis.flickr.License
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getLicense():Int {
			return _license;
		}
		
		public function setLicense( value:Int ):Int {
			_license = value;
			return value;
		}
		
		/**
		 * The upload date of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getDateUploaded():Date {
			return _dateUploaded;
		}
		
		public function setDateUploaded( value:Date ):Date {
			_dateUploaded = value;
			return value;
		}
		
		/**
		 * The date the photo was taken
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getDateTaken():Date {
			return _dateTaken;
		}
		
		public function setDateTaken( value:Date ):Date {
			_dateTaken = value;
			return value;
		}
		
		/**
		 * The date the photo was added to Flickr
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getDateAdded():Date {
			return _dateAdded;
		}
		
		public function setDateAdded( value:Date ):Date {
			_dateAdded = value;
			return value;
		}
		
		/**
		 * The original format of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOriginalFormat():String {
			return _originalFormat;
		}
		
		public function setOriginalFormat( value:String ):String {
			_originalFormat = value;
			return value;
		}
		
		/**
		 * The url of the photo (when dealing with context)
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
		 * The exifs of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getExifs():Array<Dynamic> {
			return _exifs;
		}
		
		public function setExifs( value:Array<Dynamic> ):Array<Dynamic> {
			_exifs = value;
			return value;
		}
		
		/**
		 * The rotation of the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getRotation():Int {
			return _rotation;
		}
		
		public function setRotation( value:Int ):Int {
			_rotation = value;
			return value;
		}
		
		/**
		 * The owner of the photo's real name
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOwnerRealName():String {
			return _ownerRealName;
		}
		
		public function setOwnerRealName( value:String ):String {
			_ownerRealName = value;
			return value;
		}
		
		/**
		 * The location of the photo's owner
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getOwnerLocation():String {
			return _ownerLocation;
		}
		
		public function setOwnerLocation( value:String ):String {
			_ownerLocation = value;
			return value;
		}
		
		/**
		 * Whether or not the photo is a favorite
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsFavorite():Bool {
			return _isFavorite;
		}
		
		public function setIsFavorite( value:Bool ):Bool {
			_isFavorite = value;
			return value;
		}
		
		/**
		 * The comment permission for the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getCommentPermission():Int {
			return _commentPermission;
		}
		
		public function setCommentPermission( value:Int ):Int {
			_commentPermission = value;
			return value;
		}
		
		/**
		 * The add meta permission for the photo
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getAddMetaPermission():Int {
			return _addMetaPermission;
		}
		
		public function setAddMetaPermission( value:Int ):Int {
			_addMetaPermission = value;
			return value;
		}
		
		/**
		 * Whether or not the user can comment
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getCanComment():Int {
			return _canComment;
		}
		
		public function setCanComment( value:Int ):Int {
			_canComment = value;
			return value;
		}
		
		/**
		 * Whether or not the user can add meta data
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getCanAddMeta():Int {
			return _canAddMeta;
		}
		
		public function setCanAddMeta( value:Int ):Int {
			_canAddMeta = value;
			return value;
		}

		/**
		 * The notes for the photo - array of PhotoNote
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getNotes():Array<Dynamic> {
			return _notes;
		}
		
		public function setNotes( value:Array<Dynamic> ):Array<Dynamic> {
			_notes = value;
			return value;
		}
		
		/**
		 * The tags for the photo - array of PhotoTag
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
		
		/**
		 * The urls for the photo - array of PhotoUrl
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getUrls():Array<Dynamic> {
			return _urls;
		}
		
		public function setUrls( value:Array<Dynamic> ):Array<Dynamic> {
			_urls = value;
			return value;
		}
		
	}
