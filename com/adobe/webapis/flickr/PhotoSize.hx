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
	 * PhotoSize is a ValueObject for the Flickr API.
	 */
	class PhotoSize {
	
		public var height(getHeight, setHeight) : Int ;
	
		public var label(getLabel, setLabel) : String ;
	
		public var source(getSource, setSource) : String ;
	
		public var url(getUrl, setUrl) : String ;
	
		public var width(getWidth, setWidth) : Int ;
	
		private var _label:String;
		private var	_width:Int;
		private var _height:Int;
		private var _source:String;
		private var _url:String;
		
		/**
		 * Construct a new PhotoSize instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new():Void {
			// do nothing
		}
	
		/**
		 * The label of the size
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
		 * The width of the photo for this size
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getWidth():Int {
			return _width;
		}
		
		public function setWidth( value:Int ):Int {
			_width = value;
			return value;
		}
		
		/**
		 * The height of the photo for this size
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getHeight():Int {
			return _height;
		}
		
		public function setHeight( value:Int ):Int {
			_height = value;
			return value;
		}
		
		/**
		 * The source of the photo in the size
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getSource():String {
			return _source;
		}
		
		public function setSource( value:String ):String {
			_source = value;
			return value;
		}
		
		/**
		 * The url of the photo in the size
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
