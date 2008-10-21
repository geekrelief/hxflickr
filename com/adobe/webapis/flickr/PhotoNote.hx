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
	
	import flash.geom.Rectangle;
	
	/**
	 * PhotoNote is a ValueObject for the Flickr API.  It describes
	 * the location and position of a note on an image.
	 */
	class PhotoNote {
		
		public var authorId(getAuthorId, setAuthorId) : String ;
		
		public var authorName(getAuthorName, setAuthorName) : String ;
		
		public var id(getId, setId) : String ;
		
		public var note(getNote, setNote) : String ;
		
		public var rectangle(getRectangle, setRectangle) : Rectangle ;
		
		private var _id:String;
		private var _authorId:String;
		private var _authorName:String;
		private var _rectangle:Rectangle;
		private var _note:String;
		
		/**
		 * Construct a new PhotoNote instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}
		
		/**
		 * The id of the note
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
		 * The id of the author of the note
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getAuthorId():String {
			return _authorId;
		}
		
		public function setAuthorId( value:String ):String {
			_authorId = value;
			return value;
		}
		
		/**
		 * The name of the author of the note
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getAuthorName():String {
			return _authorName;
		}
		
		public function setAuthorName( value:String ):String {
			_authorName = value;
			return value;
		}
		
		/**
		 * The bounding rectangle of the note
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getRectangle():Rectangle {
			return _rectangle;
		}
		
		public function setRectangle( value:Rectangle ):Rectangle {
			_rectangle = value;
			return value;
		}
		
		/**
		 * The contents of the note
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getNote():String {
			return _note;
		}
		
		public function setNote( value:String ):String {
			_note = value;
			return value;
		}
	
	}
