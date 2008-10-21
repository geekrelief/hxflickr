/*
  Copyright (c) 2008, Adobe Systems Incorporated
  All rights reserved.

  Redistribution and use in source and binary forms, with or without 
  modification, are permitted provided that the following conditions are
  met:

  * Redistributions of source code must retain the above copyright notice, 
    this list of conditions and the following disclaimer.
  
  * Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the 
    documentation and/or other materials provided with the distribution.
  
  * Neither the name of Adobe Systems Incorporated nor the names of its 
    contributors may be used to endorse or promote products derived from 
    this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR 
  CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.adobe.crypto;

	import com.adobe.utils.IntUtil;
	import flash.utils.ByteArray;
	//import mx.utils.Base64Encoder;
	import hash.BaseCode;
	
	/**
	 * The SHA-256 algorithm
	 * 
	 * @see http://csrc.nist.gov/publications/fips/fips180-2/fips180-2withchangenotice.pdf
	 */
	class SHA256
	{
		
		/**
		 *  Performs the SHA256 hash algorithm on a string.
		 *
		 *  @param s		The string to hash
		 *  @return			A string containing the hash value of s
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 *  @tiptext
		 */
		public static function hash( s:String ):String {
			var blocks:Array<Dynamic> = createBlocksFromString( s );
			var byteArray:ByteArray = hashBlocks( blocks );
			
			return IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true );
		}
		
		/**
		 *  Performs the SHA256 hash algorithm on a ByteArray.
		 *
		 *  @param data		The ByteArray data to hash
		 *  @return			A string containing the hash value of data
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 */
		public static function hashBytes( data:ByteArray ):String
		{
			var blocks:Array<Dynamic> = createBlocksFromByteArray( data );
			var byteArray:ByteArray = hashBlocks(blocks);
			
			return IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true )
					+ IntUtil.toHex( byteArray.readInt(), true );
		}
		
		/**
		 *  Performs the SHA256 hash algorithm on a string, then does
		 *  Base64 encoding on the result.
		 *
		 *  @param s		The string to hash
		 *  @return			The base64 encoded hash value of s
		 *  @langversion	ActionScript 3.0
		 *  @playerversion	9.0
		 *  @tiptext
		 */
		public static function hashToBase64( s:String ):String
		{
			var blocks:Array<Dynamic> = createBlocksFromString( s );
			var byteArray:ByteArray = hashBlocks(blocks);

			// ByteArray.toString() returns the contents as a UTF-8 string,
			// which we can't use because certain byte sequences might trigger
			// a UTF-8 conversion.  Instead, we convert the bytes to characters
			// one by one.
			var charsInByteArray:String = "";
			byteArray.position = 0;
			var j:Int = 0;
			while (j < byteArray.length)
			{
				var byte:UInt = byteArray.readUnsignedByte();
				charsInByteArray += String.fromCharCode(byte);
				j++;
			}

			/*
			var encoder:Base64Encoder = new Base64Encoder();
			encoder.encode(charsInByteArray);
			return encoder.flush();
			*/
			return BaseCode.encode(charsInByteArray, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/");
		}
		
		private static function hashBlocks( blocks:Array<Dynamic> ):ByteArray {
			var h0:Int = 0x6a09e667;
			var h1:Int = 0xbb67ae85;
			var h2:Int = 0x3c6ef372;
			var h3:Int = 0xa54ff53a;
			var h4:Int = 0x510e527f;
			var h5:Int = 0x9b05688c;
			var h6:Int = 0x1f83d9ab;
			var h7:Int = 0x5be0cd19;
			
			var k:Array<Dynamic> = new Array(0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5, 0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174, 0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da, 0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967, 0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85, 0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070, 0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3, 0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2);
			
			var len:Int = blocks.length;
			var w:Array<Dynamic> = new Array( 64 );
			
			// loop over all of the blocks
			var i:Int = 0;
				
			while ( i < len) {
				
				var a:Int = h0;
				var b:Int = h1;
				var c:Int = h2;
				var d:Int = h3;
				var e:Int = h4;
				var f:Int = h5;
				var g:Int = h6;
				var h:Int = h7;
				
				var t:Int = 0;
					
				while (t < 64) {
					
					if ( t < 16 ) {
						w[t] = blocks[ i + t ];
						if(isNaN(w[t])) { w[t] = 0; }
					} else {
						var ws0:Int = IntUtil.ror(w[t-15], 7) ^ IntUtil.ror(w[t-15], 18) ^ (w[t-15] >>> 3);
						var ws1:Int = IntUtil.ror(w[t-2], 17) ^ IntUtil.ror(w[t-2], 19) ^ (w[t-2] >>> 10);
						w[t] = w[t-16] + ws0 + w[t-7] + ws1;
					}
					
					var s0:Int = IntUtil.ror(a, 2) ^ IntUtil.ror(a, 13) ^ IntUtil.ror(a, 22);
					var maj:Int = (a & b) ^ (a & c) ^ (b & c);
					var t2:Int = s0 + maj;
					var s1:Int = IntUtil.ror(e, 6) ^ IntUtil.ror(e, 11) ^ IntUtil.ror(e, 25);
					var ch:Int = (e & f) ^ ((~e) & g);
					var t1:Int = h + s1 + ch + k[t] + w[t];
					
					h = g;
					g = f;
					f = e;
					e = d + t1;
					d = c;
					c = b;
					b = a;
					a = t1 + t2;
					t++;
					
				}
					
				//Add this chunk's hash to result so far:
				h0 += a;
				h1 += b;
				h2 += c;
				h3 += d;
				h4 += e;
				h5 += f;
				h6 += g;
				h7 += h;
				i += 16 ;
				
			}
			
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeInt(h0);
			byteArray.writeInt(h1);
			byteArray.writeInt(h2);
			byteArray.writeInt(h3);
			byteArray.writeInt(h4);
			byteArray.writeInt(h5);
			byteArray.writeInt(h6);
			byteArray.writeInt(h7);
			byteArray.position = 0;
			return byteArray;
		}
		
		/**
		 *  Converts a ByteArray to a sequence of 16-word blocks
		 *  that we'll do the processing on.  Appends padding
		 *  and length in the process.
		 *
		 *  @param data		The data to split into blocks
		 *  @return			An array containing the blocks into which data was split
		 */
		private static function createBlocksFromByteArray( data:ByteArray ):Array<Dynamic>
		{
			var oldPosition:Int = data.position;
			data.position = 0;
			
			var blocks:Array<Dynamic> = new Array();
			var len:Int = data.length * 8;
			var mask:Int = 0xFF; // ignore hi byte of characters > 0xFF
			var i:Int = 0;
			while ( i < len)
			{
				blocks[ i >> 5 ] |= ( data.readByte() & mask ) << ( 24 - i % 32 );
				i += 8 ;
			}
			
			// append padding and length
			blocks[ len >> 5 ] |= 0x80 << ( 24 - len % 32 );
			blocks[ ( ( ( len + 64 ) >> 9 ) << 4 ) + 15 ] = len;
			
			data.position = oldPosition;
			
			return blocks;
		}
					
		/**
		 *  Converts a string to a sequence of 16-word blocks
		 *  that we'll do the processing on.  Appends padding
		 *  and length in the process.
		 *
		 *  @param s	The string to split into blocks
		 *  @return		An array containing the blocks that s was split into.
		 */
		private static function createBlocksFromString( s:String ):Array<Dynamic>
		{
			var blocks:Array<Dynamic> = new Array();
			var len:Int = s.length * 8;
			var mask:Int = 0xFF; // ignore hi byte of characters > 0xFF
			var i:Int = 0;
			while ( i < len) {
				blocks[ i >> 5 ] |= ( s.charCodeAt( i / 8 ) & mask ) << ( 24 - i % 32 );
				i += 8 ;
			}
			
			// append padding and length
			blocks[ len >> 5 ] |= 0x80 << ( 24 - len % 32 );
			blocks[ ( ( ( len + 64 ) >> 9 ) << 4 ) + 15 ] = len;
			return blocks;
		}
	}
