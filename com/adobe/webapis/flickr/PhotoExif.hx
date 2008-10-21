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
	 * PhotoExif is a ValueObject for the Flickr API.
	 */
	class PhotoExif {
		
		public var clean(getClean, setClean) : String ;
		
		public var label(getLabel, setLabel) : String ;
		
		public var raw(getRaw, setRaw) : String ;
		
		public var tag(getTag, setTag) : Int ;
		
		public var tagspace(getTagspace, setTagspace) : String ;
		
		public var tagspaceId(getTagspaceId, setTagspaceId) : Int ;
		
		private var _tagspace:String;
		private var _tagspaceId:Int;
		private var _tag:Int;
		private var _label:String;
		private var _raw:String;
		private var _clean:String;
		
		/**
		 * Construct a new PhotoExif instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}
		
		/**
		 * The tagspace of the photo exif
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTagspace():String {
			return _tagspace;
		}
		
		public function setTagspace( value:String ):String {
			_tagspace = value;
			return value;
		}
		
		/**
		 * The tagspace id of the photo exif
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTagspaceId():Int {
			return _tagspaceId;
		}
		
		public function setTagspaceId( value:Int ):Int {
			_tagspaceId = value;
			return value;
		}

		/**
		 * The tag of the photo exif
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTag():Int {
			return _tag;
		}
		
		public function setTag( value:Int ):Int {
			_tag = value;
			return value;
		}
		
		/**
		 * The label of the photo exif
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getLabel():String {
			return _label;
		}
		
		public function setLabel( value:String ):String {
			_label = value;
			return value;
		}
		
		/**
		 * The raw of the photo exif
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
		 * The clean of the photo exif
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getClean():String {
			return _clean;
		}
		
		public function setClean( value:String ):String {
			_clean = value;
			return value;
		}						
	}
