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
	 * UploadTicket is a ValueObject for the Flickr API.
	 */
	class UploadTicket {
		
		public var id(getId, setId) : String ;
		
		public var isComplete(getIsComplete, setIsComplete) : Bool ;
		
		public var isInvalid(getIsInvalid, setIsInvalid) : Bool ;
		
		public var photoId(getPhotoId, setPhotoId) : String ;
		
		public var uploadFailed(getUploadFailed, setUploadFailed) : Bool ;
		
		private var _id:String;
		private var _isInvalid:Bool;
		private var _isComplete:Bool;
		private var _uploadFailed:Bool;
		private var _photoId:String;
		
		/**
		 * Construct a new PhotoContext instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}
		
		/**
		 * The id of the ticket
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
		 * The photo id of the ticket
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotoId():String {
			return _photoId;
		}
		
		public function setPhotoId( value:String ):String {
			_photoId = value;
			return value;
		}
		
		/**
		 * Flag indicating if the ticket id is invalid
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsInvalid():Bool {
			return _isInvalid;
		}
		
		public function setIsInvalid( value:Bool ):Bool {
			_isInvalid = value;
			return value;
		}
		
		/**
		 * Flag indicating if the upload is complete
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getIsComplete():Bool {
			return _isComplete;
		}
		
		public function setIsComplete( value:Bool ):Bool {
			_isComplete = value;
			return value;
		}
		
		/**
		 * Flag indicating if the upload failed
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getUploadFailed():Bool {
			return _uploadFailed;
		}
		
		public function setUploadFailed( value:Bool ):Bool {
			_uploadFailed = value;
			return value;
		}
			
	}
