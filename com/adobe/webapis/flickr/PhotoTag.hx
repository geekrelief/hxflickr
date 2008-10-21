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
	 * PhotoTag is a ValueObject for the Flickr API.
	 */
	class PhotoTag {
	
		public var authorId(getAuthorId, setAuthorId) : String ;
	
		public var count(getCount, setCount) : Int ;
	
		public var id(getId, setId) : String ;
	
		public var raw(getRaw, setRaw) : String ;
	
		public var tag(getTag, setTag) : String ;
	
		private var _id:String;
		private var	_authorId:String;
		private var _raw:String;
		private var _tag:String;
		private var _count:Int;
		
		/**
		 * Construct a new PhotoTag instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}
	
		/**
		 * The id of the tag
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
		 * The id of the author of the tag
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
		 * The raw tag value
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getRaw():String {
			return _raw;
		}
		
		public function setRaw( value:String ):String {
			_raw = value;
			return value;
		}
		
		/**
		 * The tag value
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTag():String {
			return _tag;
		}
		
		public function setTag( value:String ):String {
			_tag = value;
			return value;
		}
		
		/**
		 * The count value - only populated from tags.getListUserPopular
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getCount():Int {
			return _count;
		}
		
		public function setCount( value:Int ):Int {
			_count = value;
			return value;
		}
	}
