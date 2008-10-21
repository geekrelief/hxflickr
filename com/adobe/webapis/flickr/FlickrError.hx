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
	 * These are the common errors that can happen during
	 * a call to a flickr method.  Each method may have
	 * some method-specific errors, and unfortunately
	 * they don't share error #'s so we can't put them
	 * in this class.
	 *
	 * For instance, an error code of 1 for "flickr.blogs.postPhoto"
	 * is "Blog not found", whereas the same code of 1 for
	 * "flickr.photos.addTags" is "Photo not found", which means the
	 * developer using this API will have to check the method-specific
	 * errors by hand instead of with these constants.
	 */
	class FlickrError {
		
		public var errorCode(getErrorCode, setErrorCode) : Int ;
		
		public var errorMessage(getErrorMessage, setErrorMessage) : String ;
		
		/** The passed signature was invalid. */
		public static var INVALID_SIGNATURE:Int = 96;
		
		/** The call required signing but no signature was sent. */
		public static var MISSING_SIGNATURE:Int = 97;
		
		/** The login details or auth token passed were invalid. */
		public static var LOGIN_FAILED:Int = 98;
		
		/** The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions. */
		public static var INSUFFICIENT_PERMISSIONS:Int = 99;	
		
		/** The API key passed was not valid or has expired. */
		public static var INVALID_API_KEY:Int = 	100;
		
		/** The requested service is temporarily unavailable. */
		public static var SERVICE_CURRENTLY_UNAVAILABLE:Int = 105;
		
		/** The requested response format was not found. */
		public static var FORMAT_NOT_FOUND:Int = 111;
		
		/** The requested method was not found. */
		public static var METHOD_NOT_FOUND:Int = 112;
	
		/** The SOAP envelope send in the request could not be parsed. */
		public static var INVALID_SOAP_ENVELOPE:Int = 114;
		
		/** The XML-RPC request document could not be parsed */
		public static var INVALID_XML_RPC_CALL:Int = 115;
		
		private var _errorCode:Int;
		private var _errorMessage:String;
		
		/**
		 * Constructs a new FlickrError instance
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing	
		}
		
		/**
		 * The error code returned from Flickr
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getErrorCode():Int {
			return _errorCode;	
		}
		
		public function setErrorCode( value:Int ):Int {
			_errorCode = value;	
			return value;
		}
		
		/**
		 * The error message returned from Flickr
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getErrorMessage():String {
			return _errorMessage;	
		}
		
		public function setErrorMessage( value:String ):String {
			_errorMessage = value;	
			return value;
		}
		
	}	
	
