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
	 * License is a ValueObject for the Flickr API.
	 * 
	 * There are also static constants to map license
	 * numbers to name values and make code more readable.
	 */
	class License {
		
		public var id(getId, setId) : Int ;
		
		public var name(getName, setName) : String ;
		
		public var url(getUrl, setUrl) : String ;
		
		inline public static var ALL_RIGHTS_RESERVED:Int = 0;
		
		inline public static var ATTRIBUTION:Int = 4;
		
		inline public static var ATTRIBUTION_NODERIVS:Int = 6;
		
		inline public static var ATTRIBUTION_NONCOMMERCIAL_NODERIVS:Int = 3;
		
		inline public static var ATTRIBUTION_NONCOMMERCIAL:Int = 2;
		
		inline public static var ATTRIBUTION_NONCOMMERCIAL_SHAREALIKE:Int = 1;
		
		inline public static var ATTRIBUTION_SHAREALIKE:Int = 5;
		
		private var _id:Int;
		private var _name:String;
		private var _url:String;
		
		/**
		 * Construct a new License instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			// do nothing
		}
	
		/**
		 * The id of the license
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getId():Int {
			return _id;
		}
		
		public function setId( value:Int ):Int {
			_id = value;
			return value;
		}
		
		/**
		 * The name of the license
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
		 * The url of the license
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
		
