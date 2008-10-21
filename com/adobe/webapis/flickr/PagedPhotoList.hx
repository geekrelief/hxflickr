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
	 * PagedPhotoList is a ValueObject for the Flickr API.
	 */
	class PagedPhotoList {
		
		public var page(getPage, setPage) : Int ;
		
		public var pages(getPages, setPages) : Int ;
		
		public var perPage(getPerPage, setPerPage) : Int ;
		
		public var photos(getPhotos, setPhotos) : Array<Photo> ;
		
		public var total(getTotal, setTotal) : Int ;
		
		private var _page:Int;
		private var _pages:Int;
		private var _perPage:Int;
		private var _total:Int;
		private var _photos:Array<Photo>;
		
		/**
		 * Construct a new PagedPhotoList instance
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function new() {
			_photos = new Array();
		}
		
		/**
		 * The current page of photos
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPage():Int {
			return _page;
		}
		
		public function setPage( value:Int ):Int {
			_page = value;	
			return value;
		}
		
		/**
		 * The number of photo pages
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPages():Int {
			return _pages;
		}
		
		public function setPages( value:Int ):Int {
			_pages = value;	
			return value;
		}
		
		/**
		 * The number of photos per page
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPerPage():Int {
			return _perPage;
		}
		
		public function setPerPage( value:Int ):Int {
			_perPage = value;	
			return value;
		}
		
		/**
		 * The total number of photos
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getTotal():Int {
			return _total;
		}
		
		public function setTotal( value:Int ):Int {
			_total = value;	
			return value;
		}
		
		/**
		 * The container holding the Photo instances
		 *
		 * @langversion ActionScript 3.0
		 * @playerversion Flash 8.5
		 * @tiptext
		 */
		public function getPhotos():Array<Photo> {
			return _photos;
		}
		
		public function setPhotos( value:Array<Photo> ):Array<Photo> {
			_photos = value;	
			return value;
		}
				
	}
