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

package com.adobe.webapis.flickr.methodgroups; 
	
	import com.adobe.crypto.MD5;
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.events.FlickrResultEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import haxe.xml.Fast;		

	import com.adobe.webapis.flickr.AuthPerm;
	import com.adobe.webapis.flickr.AuthResult;
	import com.adobe.webapis.flickr.Blog;
	import com.adobe.webapis.flickr.Category;
	import com.adobe.webapis.flickr.FlickrError;
	import com.adobe.webapis.flickr.FlickrService;
	import com.adobe.webapis.flickr.Group;
	import com.adobe.webapis.flickr.License;
	import com.adobe.webapis.flickr.NameValuePair;
	import com.adobe.webapis.flickr.PagedGroupList;
	import com.adobe.webapis.flickr.PagedPhotoList;
	import com.adobe.webapis.flickr.Permission;
	import com.adobe.webapis.flickr.Photo;
	import com.adobe.webapis.flickr.PhotoContext;
	import com.adobe.webapis.flickr.PhotoCount;
	import com.adobe.webapis.flickr.PhotoExif;
	import com.adobe.webapis.flickr.PhotoNote;
	import com.adobe.webapis.flickr.PhotoPool;
	import com.adobe.webapis.flickr.PhotoSet;
	import com.adobe.webapis.flickr.PhotoSize;
	import com.adobe.webapis.flickr.PhotoTag;
	import com.adobe.webapis.flickr.PhotoUrl;
	import com.adobe.webapis.flickr.UploadTicket;
	import com.adobe.webapis.flickr.User;

	/**
	 * Contains helper functions for the method group classes that are
	 * reused throughout them.
	 */
	 class MethodGroupHelper {
	
		/**
		 * Reusable method that the "method group" classes can call to invoke a
		 * method on the API.
		 *
		 * @param callBack The function to be notified when the RPC is complete
		 * @param method The name of the method to invoke ( like flickr.test.echo )
		 * @param signed A boolean value indicating if the method call needs
		 *			an api_sig attached to it
		 * @param params An array of NameValuePair or primitive elements to pass
		 *			as parameters to the remote method
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function invokeMethod( service:FlickrService, 
												callBack:(Event -> Void), method:String, 
												signed:Bool, ?params:Array<NameValuePair> = null ):Void
		{
			if(params == null) {
				params = [];
			}	
			// Create an array to store our name/value pairs
			// for the query because during signing we need to sort
			// these alphabetically
			var args:Array<NameValuePair> = params;
			
			args.push( new NameValuePair( "api_key", service.api_key ) );
			args.push( new NameValuePair( "method", method ) );
			
			// Loop over the params and add them as arguments
//			for ( i in 0...params.length) {
				// Do we have an argument name, or do we create one
//				if (Std.is( params[i] , NameValuePair) ) {
//					args.push( params[i] );
//				} else {
					// Create a unique argument name using our loop counter
//					args.push( new NameValuePair( "param" + i, params[i].toString() ) );
//				}
//			}
			
			// If a user is authenticated, automatically add their token
			if ( service.permission != AuthPerm.NONE && service.token != "" ) {
				args.push( new NameValuePair( "auth_token", service.token ) );
				// auto-sign the call because the user is authenticated
				signed = true;
			}
			
			// Sign the call if we have to, or if the user is logged in
			if ( signed ) {
				
				// sign the call according to the documentation point #8
				// here: http://www.flickr.com/services/api/auth.spec.html
				args.sort(function(a:NameValuePair, b:NameValuePair) { return if (a.name == b.name) 0 else if (a.name < b.name) -1 else 1; } );
				var sig:String = service.secret;
				for ( j in 0...args.length) {
					sig += args[j].name + args[j].value;
				}	
				args.push( new NameValuePair( "api_sig", MD5.hash( sig ) ) );
			}
			
			// Construct the query string to send to the Flickr service
			var query:String = "";
			for ( k in 0...args.length) {
				// This puts 1 too many "&" on the end, but that doesn't
				// affect the flickr call, so it doesn't matter
				query += args[k].name + "=" + args[k].value + "&";	
			}
			
			// Use the "internal" flickrservice namespace to be able to
			// access the urlLoader so we can make the request.
			var loader:URLLoader = service.urlLoader;
			
			// Construct a url request with our query string and invoke
			// the Flickr method
			loader.addEventListener( "complete", callBack );
			loader.load( new URLRequest( FlickrService.END_POINT + query ) );
		}
		
		/**
		 * Handle processing the result of the API call.
		 *
		 * @param service The FlickrService associated with the method group
		 * @param response The XML response we got from the loader call
		 * @param result The event to fill in the details of and dispatch
		 * @param propertyName The property in event.data that the results should be placed
		 * @param parseFunction The function to parse the response XML with
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function processAndDispatch( service:FlickrService, response:String, result:FlickrResultEvent, ?propertyName:String = "", ?parseFunction:Dynamic = null ):Void {
			// Process the response to create an object for return values
			var rsp:Dynamic = processResponse( response, propertyName, parseFunction );

			// Copy some properties from the response to the result event
			result.success = rsp.success;
			result.data = rsp.data;

			// Notify everyone listening
			service.dispatchEvent( result );
		}
		
		/**
		 * Reusable method that the "method group" classes can call
		 * to process the results of the Flickr method.
		 *
		 * @param flickrResponse The rest response string that aligns
		 *		with the documentation here: 
		 *			http://www.flickr.com/services/api/response.rest.html
		 * @param parseFunction A reference to the function that should be used
		 *		to parse the XML received from the server
		 * @param propertyName The name of the property to put the parsed data in.
		 *  	For example, the result object will contain a "data" property that
		 * 		will contain an additional property (the value of propertyName) that
		 * 		contains the actual data.
		 * @return An object with success and data properties.  Success
		 *		will be true if the call was completed, false otherwise.
		 *		Data will contain ether an array of NameValuePair (if
		 *		successful) or errorCode and errorMessage properties.
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function processResponse( flickrResponse:String, propertyName:String, parseFunction:Dynamic ):Dynamic {
			var result:Dynamic = {};
			result.data = {};
			
			// Use an XMLDocument to convert a string to XML

			var doc:Fast = new haxe.xml.Fast(Xml.parse(flickrResponse));

			// Get the root rsp node from the document
			var rsp:Fast = doc.node.rsp;
			
			// Clean up a little
			doc = null; 
			
			if ( rsp.att.stat == "ok" ) {
				result.success = true;
				
				// Parse the XML object into a user-defined class (This gives us
				// nice code hinting, and abstracts away the FlickrAPI a bit - if
				// the FlickrAPI changes responses we can modify this service
				// without the user having to update their program code
				if ( parseFunction == null ) {
					// No parse function speficied, just pass through the XML data.
					// Construct an object that we can access via E4X since
					// the result we get back from Flickr is an xml response
					result.data = rsp;
				} else {
					Reflect.setField(result.data, propertyName, parseFunction( rsp ));
				}			
								
			} else {
				result.success = false;
				
				// In the event that we don't get an xml object
				// as part of the error returned, just
				// use the plain text as the error message
				
				var error:FlickrError = new FlickrError();
				if ( rsp.x != null ) 
				{
					error.errorCode = Std.parseInt( rsp.node.err.att.code );
					error.errorMessage = rsp.node.err.att.msg;
					
					result.data.error = error;
				}
				else 
				{
					error.errorCode = -1;
					error.errorMessage = rsp.innerData;
					
					result.data.error = error;
				}
			}
			
			return result;			
		}
		
		/**
		 * Converts a date object into a Flickr date string
		 *
		 * @param date The date to convert
		 * @return A string representing the date in a format
		 *		that Flickr understands
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function dateToString( date:Date ):String {
			// Don't do anything if the date is invalid
			if ( date == null ) {
				return "";
			} else {
				return date.getFullYear() + "-" + (date.getMonth() + 1)
					+ "-" + date.getDate() + " " + date.getHours()
					+ ":" + date.getMinutes() + ":" + date.getSeconds();
			}
		}
		
		/**
		 * Converts a Flickr date string into a date object
		 *
		 * @param date The string to convert
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public static function stringToDate( ?str:String = "" ):Date {
			if ( str == "" ) {
				return null;
			}
			
			var date:Date;
			// split the date into date / time parts
			var parts:Array<String> = str.split( " " );
			
			// See if we have the xxxx-xx-xx xx:xx:xx format
			if ( parts.length == 2 ) {
				var dateParts:Array<String> = parts[0].split( "-" );
				var timeParts:Array<String> = parts[1].split( ":" );
			
				date = new Date(Std.parseInt(dateParts[0]), Std.parseInt(dateParts[1]) - 1, Std.parseInt(dateParts[2]), Std.parseInt(timeParts[0]), Std.parseInt(timeParts[1]), Std.parseInt(timeParts[2]));
			} else {
				// Create a date based on # of seconds since Jan 1, 1970 GMT
				date = Date.fromTime(Std.parseInt( str ) * 1000 );
			}
			
			return date;
		}
		
		/**
		 * Converts an auth result XML object into an AuthResult instance
		 */
		public static function parseAuthResult( xml:Fast ):AuthResult {
			var authResult:AuthResult = new AuthResult();

			xml = xml.node.auth;

			authResult.token = xml.node.token.innerData;
			authResult.perms = xml.node.perms.innerData;
			authResult.user = new User();
			authResult.user.nsid = xml.node.user.att.nsid;
			authResult.user.username = xml.node.user.att.username;
			authResult.user.fullname = xml.node.user.att.fullname;
			return authResult;
		}
		
		/**
		 * Converts a frob XML object into a string (the frob value)
		 */
		public static function parseFrob( xml:Fast ):String {
			return xml.node.frob.innerData;
		}
		
		/**
		 * Converts a blog list XML object into an arry of Blog instances
		 */
		public static function parseBlogList( xml:Fast ):Array<Blog> {
			var blogs:Array<Blog> = new Array();
			
			for ( b in xml.node.blogs.nodes.blog ) {
				var blog:Blog = new Blog();
				blog.id = b.att.id;
				blog.name = b.att.name;
				blog.needsPassword = b.att.needspassword == "1";
				blog.url = b.att.url;
				
				blogs.push( blog );
			}
			
			return blogs;
		}
		
		/**
		 * Converts a contact list XML object into an array of User instances
		 */
		public static function parseContactList( xml:Fast ):Array<User> {
			var contacts:Array<User> = new Array();
			
			for ( c in xml.node.contacts.nodes.contact ) {
				var contact:User = new User();
				contact.nsid = c.att.nsid;
				contact.username = c.att.username;
				contact.fullname = c.att.realname;
				contact.isFriend = c.att.friend == "1";
				contact.isFamily = c.att.family == "1";
				contact.isIgnored = c.att.ignored == "1";
				
				contacts.push( contact );
			}
			
			return contacts;	
		}
		
		/**
		 * Converts a pages photo list XML object into a PagesPhotoList instance
		 */
		public static function parsePagedPhotoList( xml:Fast ):PagedPhotoList {
			var pagedPhotoList:PagedPhotoList = new PagedPhotoList();

			xml = xml.node.photos;

			pagedPhotoList.page = Std.parseInt( xml.att.page );
			pagedPhotoList.pages = Std.parseInt( xml.att.pages );
			pagedPhotoList.perPage = Std.parseInt( xml.att.perpage);
			pagedPhotoList.total = Std.parseInt( xml.att.total);
			
			var photos:Array<Photo> = new Array();
			for ( p in xml.nodes.photo) {
				var photo:Photo = new Photo();
				photo.id = p.att.id;
				photo.ownerId = p.att.owner;
				photo.secret = p.att.secret;
				photo.server = Std.parseInt( p.att.server );
				if(p.has.latitude){ photo.latitude = p.att.latitude;}
				if(p.has.longitude){ photo.longitude = p.att.longitude;}
				photo.farmId = Std.parseInt( p.att.farm );
				if(p.has.originalSecret){ photo.originalSecret = p.att.originalSecret;}
				photo.title = p.att.title;
				photo.isPublic = p.att.ispublic == "1";
				photo.isFriend = p.att.isfriend == "1";
				photo.isFamily = p.att.isfamily == "1";
				if ( p.has.license ){ photo.license = Std.parseInt( p.att.license ); }
				if ( p.has.dateupload ){ photo.dateUploaded = stringToDate( p.att.dateupload ); }
				if ( p.has.datetake ){ photo.dateTaken = stringToDate( p.att.datetaken ); }
				if ( p.has.dateadded ){ photo.dateAdded = stringToDate( p.att.dateadded); }
				if ( p.has.ownername ){ photo.ownerName = p.att.ownername; }
				if ( p.has.iconserver ) { photo.iconServer = Std.parseInt( p.att.iconserver ); }
				if ( p.has.originalformat){ photo.originalFormat = p.att.originalformat; }
				
				photos.push( photo );
			}
			
			pagedPhotoList.photos = photos;
			return pagedPhotoList;
		}
		
		/**
		 * Converts a group category XML object into a Category instance
		 */
		public static function parseGroupCategory( xml:Fast ):Category {
			var category:Category = new Category();
			
			xml = xml.node.category;

			category.name = xml.att.name;
			category.path = xml.att.path;
			category.pathIds = xml.att.pathids;
			
			// Build sub categories
			for ( subcat in xml.nodes.subcat ) {
				var subcategory:Category = new Category();
				subcategory.id = subcat.att.id;
				subcategory.name = subcat.att.name;
				subcategory.count = Std.parseInt( subcat.att.count );
				
				category.subCategories.push( subcategory );
			}
			
			// Build groups
			for ( g in xml.nodes.group ) {
				var group:Group = new Group();
				group.nsid = g.att.id;
				group.name = g.att.name;
				group.members = Std.parseInt( g.att.members );
				group.online = Std.parseInt( g.att.online );
				group.chatNsid = g.att.chatnsid;
				group.inChat = Std.parseInt( g.att.inchat );
				
				category.groups.push( group );	
			}
			
			return category;
		}
		
		/**
		 * Converts a group XML object into a Group instance
		 */
		public static function parseGroup( xml:Fast ):Group {
			var group:Group = new Group();

			xml = xml.node.group;

			group.nsid = xml.att.id;
			if ( group.nsid == "" ) {
				group.nsid = xml.att.nsid;
			}
			group.name = xml.node.name.innerData;
			if ( group.name == "" ) {
				group.name = xml.node.groupname.innerData;
			}
			group.description = xml.node.description.innerData;
			if ( xml.node.members.innerData != "" ) {
				group.members = Std.parseInt( xml.node.members.innerData );
			}
			if ( xml.node.privacy.innerData != "" ) {
				group.privacy = Std.parseInt( xml.node.privacy.innerData );
			}

			group.url = xml.att.url;

			return group;
		}
		
		/**
		 * Converts a paged group list XML object into a PagedGroupList instance
		 */
		public static function parsePagedGroupList( xml:Fast ):PagedGroupList {
			var pagedGroupList:PagedGroupList = new PagedGroupList();
			
			xml = xml.node.groups;
			
			pagedGroupList.page = Std.parseInt( xml.att.page );
			pagedGroupList.pages = Std.parseInt( xml.att.pages );
			pagedGroupList.perPage = Std.parseInt( xml.att.perpage );
			pagedGroupList.total = Std.parseInt( xml.att.total );
			
			for ( g in xml.nodes.group ) {
				var group:Group = new Group();
				group.nsid = g.att.nsid;
				group.name = g.att.name;
				group.isEighteenPlus = g.att.eighteenplus == "1";
				
				pagedGroupList.groups.push( group );
			}
			
			return pagedGroupList;
		}
		
		/**
		 * Converts a context XML object into an Array of Photo instances.
		 * The first element is the previous photo, the second element is
		 * the next photo.
		 */
		public static function parseContext( xml:Fast ):Array<Photo> {
			var context:Array<Photo> = new Array();
			
			var prev:Fast = xml.node.prevphoto;
			var photo:Photo = new Photo();
			photo.id = prev.att.id;
			photo.secret = prev.att.secret;
			photo.title = prev.att.title;
			photo.url = prev.att.url;
			
			context.push( photo );
			
			var next:Fast = xml.node.nextphoto;
			photo = new Photo();
			photo.id = next.att.id;
			photo.secret = next.att.secret;
			photo.title = next.att.title;
			photo.url = next.att.url;
			
			context.push( photo );
			
			return context;
		}
		
		/**
		 * Converts a group list XML object into an Array of Group instances.
		 */
		public static function parseGroupList( xml:Fast ):Array<Group> {
			var groups:Array<Group> = new Array();
			
			for ( g in xml.node.groups.nodes.group ) {
				var group:Group = new Group();
				group.nsid = g.att.nsid;
				group.name = g.att.name;
				group.isAdmin = g.att.admin == "1";
				if ( g.att.privacy != "" ) {
					group.privacy = Std.parseInt( g.att.privacy );
				}
				if ( g.att.photos != "" ) {
					group.photos = Std.parseInt( g.att.photos );
				}
				if ( g.att.iconserver != "") {
					group.iconServer = Std.parseInt( g.att.iconserver );
				}
				
				groups.push( group );	
			}
			
			return groups;
		}
		
		/**
		 * Converts a user XML object into a User instance
		 */
		public static function parseUser( xml:Fast ):User {
			var user:User = new User();

			xml = xml.node.user;
	
			// Either nsid or id will be defined, try nsid first
			user.nsid = xml.att.nsid;
			if ( user.nsid.length == 0 ) {
				user.nsid = xml.att.id;
			}
			user.username = xml.node.username.innerData;
			user.isPro = xml.att.ispro == "1";
			user.bandwidthMax = Std.parseInt( xml.node.bandwidth.att.max );
			user.bandwidthUsed = Std.parseInt( xml.node.bandwidth.att.used );
			user.filesizeMax = Std.parseInt( xml.node.filesize.att.max );
			user.url = xml.att.url;
			
			return user;	
		}
		
		/**
		 * Converts a person XML object into a User instance
		 */
		public static function parsePerson( xml:Fast ):User {
			var user:User = new User();
			xml = xml.node.person;
	
			user.nsid = xml.att.nsid;
			user.isAdmin = xml.att.isadmin == "1";
			user.isPro = xml.att.ispro == "1";
			user.iconServer = Std.parseInt( xml.att.iconserver );
			user.iconFarm = Std.parseInt( xml.att.iconfarm );
			user.username = xml.node.username.innerData;
			user.fullname = xml.node.realname.innerData;
			user.mboxSha1Sum = xml.node.mbox_sha1sum.innerData;
			user.location = xml.node.location.innerData;
			user.photoUrl = xml.node.photosurl.innerData;
			user.profileUrl = xml.node.profileurl.innerData;
			user.firstPhotoUploadDate = stringToDate( xml.node.photos.node.firstdate.innerData );
			user.firstPhotoTakenDate = stringToDate( xml.node.photos.node.firstdatetaken.innerData );
			user.photoCount = Std.parseInt( xml.node.photos.node.count.innerData );
			
			return user;	
		}
		
		/**
		 * Converts a photo context XML object into a PhotoContext instance
		 */
		public static function parsePhotoContext( xml:Fast ):PhotoContext {
		 	var photoContext:PhotoContext = new PhotoContext();
		 	
		 	for ( s in xml.nodes.set ) {
		 		var photoSet:PhotoSet = new PhotoSet();
		 		photoSet.id = s.att.id;
		 		photoSet.title = s.att.title;
		 		
		 		photoContext.sets.push( photoSet );
		 	}
		 	
		 	for ( p in xml.nodes.pool ) {
		 		var photoPool:PhotoPool = new PhotoPool();
		 		photoPool.id = p.att.id;
		 		photoPool.title = p.att.title;
		 		
		 		photoContext.pools.push( photoPool );
		 	}
		 	
		 	return photoContext;	
		 }
		 
		 /**
		  * Converts a photo list XML object into an Array of Photo instances
		  */
		 public static function parsePhotoList( xml:Fast ):Array<Photo> {
		 	var photos:Array<Photo> = new Array();
		 	
		 	for ( p in xml.node.photos.nodes.photo ) {
				var photo:Photo = new Photo();
				photo.id = p.att.id;
				photo.farmId = Std.parseInt( p.att.farm );
				photo.ownerId = p.att.owner;
				photo.secret = p.att.secret;
				photo.server = Std.parseInt( p.att.server );
				photo.ownerName = p.att.username;
				photo.title = p.att.title;
								
				photos.push( photo );
			}
			
			return photos;	
		}
		
		/**
		 * Converts a photo context XML object into a PhotoContext instance
		 */
		public static function parsePhotoCountList( xml:Fast ):Array<PhotoCount> {
			var photoCounts:Array<PhotoCount> = new Array();
			
			for ( p in xml.node.photocounts.nodes.photocount ) {
				var photoCount:PhotoCount = new PhotoCount();
				photoCount.count = Std.parseInt( p.att.count );
				photoCount.fromDate = stringToDate( p.att.fromdate); 
				photoCount.toDate = stringToDate( p.att.todate );
				
				photoCounts.push( photoCount );
			}
			
			return photoCounts;
		}
		
		/**
		 * Converts a photo exif list XML object into a Photo instance
		 */
		public static function parsePhotoExifs( xml:Fast ):Photo {
			var photo:Photo = new Photo();
			
			xml = xml.node.photo;

			photo.id = xml.att.id;
			photo.secret = xml.att.secret;
			photo.server = Std.parseInt( xml.att.server );
			
			for ( e in xml.nodes.exif ) {
				var photoExif:PhotoExif = new PhotoExif();
				photoExif.tag = Std.parseInt( e.att.tag );
				photoExif.tagspaceId = Std.parseInt( e.att.tagspaceid );
				photoExif.tagspace = e.att.tagspace;
				photoExif.label = e.att.label;
				photoExif.raw = e.node.raw.innerData;
				photoExif.clean = e.node.clean.innerData;
				
				photo.exifs.push( photoExif );	
			}
			
			return photo;
		}
		
		/**
		 * Converts a photo XML object into a Photo instance
		 */
		public static function parsePhoto( xml:Fast ):Photo {
			var photo:Photo = new Photo();
			
			xml = xml.node.photo;
	
			photo.id = xml.att.id;
			photo.farmId = Std.parseInt( xml.att.farm );
			photo.secret = xml.att.secret;
			if ( xml.att.server != "" ) {
				photo.server = Std.parseInt( xml.att.server );
			}
			photo.isFavorite = xml.att.isfavorite == "1";
			if ( xml.att.license != "" ) {
				photo.license = Std.parseInt( xml.att.license );
			}
			if ( xml.att.rotation != "") {
				photo.rotation = Std.parseInt( xml.att.rotation );
			}
			photo.originalFormat = xml.att.originalformat;
			photo.ownerId = xml.att.nsid;
			photo.ownerName = xml.att.username;
			photo.ownerRealName = xml.att.realname;
			photo.ownerLocation = xml.att.location;
			photo.title = xml.node.title.innerData;
			photo.description = xml.node.description.innerData;
			if ( xml.node.permissions.att.permcomment != "") {
				photo.commentPermission = Std.parseInt( xml.node.permissions.att.permcomment );	
			}
			if ( xml.node.permissions.att.permaddmeta != "") {
				photo.addMetaPermission = Std.parseInt( xml.node.permissions.att.permaddmeta );
			}
			photo.dateAdded = stringToDate( xml.node.dates.att.posted );
			photo.dateTaken = stringToDate( xml.node.dates.att.taken );
			if ( xml.node.editability.att.cancomment != "") {
				photo.canComment = Std.parseInt( xml.node.editability.att.cancomment );
			}
			if ( xml.node.editability.att.canaddmeta != "") {
				photo.canAddMeta = Std.parseInt( xml.node.editability.att.canaddmeta );
			}
			if ( xml.node.comments.innerData != "") {
				photo.commentCount = Std.parseInt( xml.node.comments.innerData );
			}
			
			for ( n in xml.node.notes.nodes.note ) {
				var photoNote:PhotoNote = new PhotoNote();
				photoNote.id = n.att.id;
				photoNote.authorId = n.att.author;
				photoNote.authorName = n.att.authorname;
				photoNote.rectangle = new Rectangle();
				photoNote.rectangle.x = Std.parseInt( n.att.x );
				photoNote.rectangle.y = Std.parseInt( n.att.y );
				photoNote.rectangle.width = Std.parseInt( n.att.w );
				photoNote.rectangle.height = Std.parseInt( n.att.h );
				photoNote.note = n.innerData;
				
				photo.notes.push( photoNote );	
			}
			
			for ( t in xml.node.tags.nodes.tag ) {
				var photoTag:PhotoTag = new PhotoTag();
				photoTag.id = t.att.id;
				photoTag.authorId = t.att.author;
				photoTag.raw = t.att.raw;
				photoTag.tag = t.innerData;
				
				photo.tags.push( photoTag );
			}
			
			for ( u in xml.node.urls.nodes.url ) {
				var photoUrl:PhotoUrl = new PhotoUrl();
				photoUrl.type = u.att.type;
				photoUrl.url = u.innerData;
				
				photo.urls.push( photoUrl );
			}
			
			return photo;
		}
		
		/**
		 * Converts a photo perm XML object into a Photo instance
		 */
		public static function parsePhotoPerms( xml:Fast ):Photo {
			var photo:Photo = new Photo();

			xml = xml.node.perms;
			
			photo.id = xml.att.id;
			photo.isPublic = xml.att.ispublic == "1";
			photo.isFriend = xml.att.isfriend == "1";
			photo.isFamily = xml.att.isfamily == "1";
			photo.canComment = Std.parseInt( xml.att.permcomment );
			photo.canAddMeta = Std.parseInt( xml.att.permaddmeta );
			
			return photo;
		}
		
		/**
		 * Converts a size list XML object into an array of PhotoSize instances
		 */
		public static function parsePhotoSizeList( xml:Fast ):Array<PhotoSize> {
			var photoSizes:Array<PhotoSize> = new Array();
			
			for ( s in xml.node.sizes.nodes.size ) {
				var photoSize:PhotoSize = new PhotoSize();
				photoSize.label = s.att.label;
				photoSize.width = Std.parseInt( s.att.width );
				photoSize.height = Std.parseInt( s.att.height );
				photoSize.source = s.att.source;
				photoSize.url = s.att.url;
				
				photoSizes.push( photoSize );	
			}
			
			return photoSizes;
		}
		
		/**
		 * Converts a license list XML object into an array of License instances
		 */
		public static function parseLicenseList( xml:Fast ):Array<License> {
			var licenses:Array<License> = new Array();
			
			for ( l in xml.node.licenses.nodes.license ) {
				var license:License = new License();
				license.id = Std.parseInt( l.att.id );
				license.name = l.att.name;
				license.url = l.att.url;
				
				licenses.push( license );	
			}
			
			return licenses;
		}
		
		/**
		 * Converts a note XML object into a Note instance
		 */
		public static function parsePhotoNote( xml:Fast ):PhotoNote {
			var photoNote:PhotoNote = new PhotoNote();
			
			photoNote.id = xml.node.note.att.id;
			
			return photoNote;
		}
		
		/**
		 * Converts an uploader ticket list XML object into an Array of UploadTicket instances
		 */
		public static function parseUploadTicketList( xml:Fast ):Array<UploadTicket> {
			var uploadTickets:Array<UploadTicket> = new Array();
			
			for ( t in xml.node.uploader.nodes.ticket ) {
				var uploadTicket:UploadTicket = new UploadTicket();
				uploadTicket.id = t.att.id;
				uploadTicket.photoId = t.att.photoid;
				uploadTicket.isComplete = t.att.complete == "1";
				uploadTicket.uploadFailed = t.att.complete == "2";
				uploadTicket.isInvalid = t.att.invalid == "1";
				
				uploadTickets.push( uploadTicket );	
			}
			
			return uploadTickets;
		}
		
		/**
		 * Converts a photo set XML object into a PhotoSet instance
		 */
		public static function parsePhotoSet( xml:Fast ):PhotoSet {
			var photoSet:PhotoSet = new PhotoSet();

			xml = xml.node.photoset;
	
			photoSet.id = xml.att.id;
			photoSet.url = xml.att.url;
			photoSet.ownerId = xml.att.owner;
			photoSet.primaryPhotoId = xml.att.primary;
			if ( xml.att.photos != "" ) {
				photoSet.photoCount = Std.parseInt( xml.att.photos );	
			}
			photoSet.title = xml.node.title.innerData;
			photoSet.description = xml.node.description.innerData;
			photoSet.secret = xml.att.secret;
			if ( xml.att.server != "" ) {
				photoSet.server = Std.parseInt( xml.att.server );	
			}
			
			for ( p in xml.nodes.photo ) {
				var photo:Photo = new Photo();
				photo.id = p.att.id;
				photo.secret = p.att.secret;
				photo.title = p.att.title;
				photo.server = Std.parseInt( p.att.server );
				photo.farmId = Std.parseInt( p.att.farm );
				
				photoSet.photos.push( photo );	
			}
			
			return photoSet;
		}
		
		/**
		 * Converts a photo set list XML object into a PhotoSet instance
		 */
		public static function parsePhotoSetList( xml:Fast ):Array<PhotoSet> {
			var photoSets:Array<PhotoSet> = new Array();
			
			for ( s in xml.node.photosets.nodes.photoset ) {
				var photoSet:PhotoSet = new PhotoSet();
				photoSet.id = s.att.id;
				photoSet.url = s.att.url;
				photoSet.ownerId = s.att.ownerid;
				photoSet.primaryPhotoId = s.att.primary;
				photoSet.photoCount = Std.parseInt( s.att.photos );	
				photoSet.secret = s.att.secret;
				photoSet.server = Std.parseInt( s.att.server );	
				photoSet.title = s.node.title.innerData;
				photoSet.description = s.node.description.innerData;
				
				photoSets.push( photoSet );	
			}
			
			return photoSets;
		}
		
		/**
		 * Converts a tag list XML object into a User instance
		 */
		public static function parseUserTags( xml:Fast ):User {
			var user:User = new User();
			
			user.nsid = xml.node.who.att.id;
			for ( t in xml.node.who.node.tags.nodes.tag ) {
				var photoTag:PhotoTag = new PhotoTag();
				photoTag.raw = t.innerData;
				photoTag.tag = t.innerData;
				if ( t.att.count != "") {
					photoTag.count = Std.parseInt( t.att.count);
				}
				user.tags.push( photoTag );	
			}
			
			return user;	
		}
		
		/**
		 * Converts a tag list XML object into an Array of PhotoTag instances
		 */
		public static function parseTagList( xml:Fast ):Array<PhotoTag> {
			var tags:Array<PhotoTag> = new Array();
			
			for ( t in xml.node.tags.nodes.tag ) {
				var photoTag:PhotoTag = new PhotoTag();
				photoTag.raw = t.innerData;
				photoTag.tag = t.innerData;
				tags.push( photoTag );	
			}
			
			return tags;
		}

	}
	
