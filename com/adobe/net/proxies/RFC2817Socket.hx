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
package com.adobe.net.proxies;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.Socket;

	/**
	 * This class allows TCP socket connections through HTTP proxies in accordance with
	 * RFC 2817:
	 * 
	 * ftp://ftp.rfc-editor.org/in-notes/rfc2817.txt
	 * 
	 * It can also be used to make direct connections to a destination, as well. If you
	 * pass the host and port into the constructor, no proxy will be used. You can also
	 * call connect, passing in the host and the port, and if you didn't set the proxy
	 * info, a direct connection will be made. A proxy is only used after you have called
	 * the setProxyInfo function.
	 * 
	 * The connection to and negotiation with the proxy is completely hidden. All the
	 * same events are thrown whether you are using a proxy or not, and the data you
	 * receive from the target server will look exact as it would if you were connected
	 * to it directly rather than through a proxy.
	 * 
	 * @author Christian Cantrell
	 * 
	 **/
	class RFC2817Socket
		extends Socket
	{
		private var proxyHost:String ;
		private var host:String ;
		private var proxyPort:Int ;
		private var port:Int ;
		private var deferredEventHandlers:Dynamic ;
		private var buffer:String ;

		/**
		 * Construct a new RFC2817Socket object. If you pass in the host and the port,
		 * no proxy will be used. If you want to use a proxy, instantiate with no
		 * arguments, call setProxyInfo, then call connect.
		 **/
		public function new(?host:String = null, ?port:Int = 0)
		{
			
			proxyHost = null;
			host = null;
			proxyPort = 0;
			port = 0;
			deferredEventHandlers = new Object();
			buffer = new String();
			if (host != null && port != 0)
			{
				super(host, port);
			}
		}
		
		/**
		 * Set the proxy host and port number. Your connection will only proxied if
		 * this function has been called.
		 **/
		public function setProxyInfo(host:String, port:Int):Void
		{
			this.proxyHost = host;
			this.proxyPort = port;

			var deferredSocketDataHandler:Dynamic = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
			var deferredConnectHandler:Dynamic = this.deferredEventHandlers[Event.CONNECT];

			if (deferredSocketDataHandler != null)
			{
				super.removeEventListener(ProgressEvent.SOCKET_DATA, deferredSocketDataHandler.listener, deferredSocketDataHandler.useCapture);
			}

			if (deferredConnectHandler != null)
			{
				super.removeEventListener(Event.CONNECT, deferredConnectHandler.listener, deferredConnectHandler.useCapture);
			}
		}
		
		/**
		 * Connect to the specified host over the specified port. If you want your
		 * connection proxied, call the setProxyInfo function first.
		 **/
		public override function connect(host:String, port:Int):Void
		{
			if (this.proxyHost == null)
			{
				this.redirectConnectEvent();
				this.redirectSocketDataEvent();
				super.connect(host, port);
			}
			else
			{
				this.host = host;
				this.port = port;
				super.addEventListener(Event.CONNECT, this.onConnect);
				super.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
				super.connect(this.proxyHost, this.proxyPort);
			}
		}

		private function onConnect(event:Event):Void
		{
			this.writeUTFBytes("CONNECT "+this.host+":"+this.port+" HTTP/1.1\n\n");
			this.flush();
			this.redirectConnectEvent();
		}
		
		private function onSocketData(event:ProgressEvent):Void
		{
			while (this.bytesAvailable != 0)
			{
				this.buffer += this.readUTFBytes(1);
				if (this.buffer.search(~/\r?\n\r?\n$/) != -1)
				{
					this.checkResponse(event);
					break;
				}
			}
		}
		
		private function checkResponse(event:ProgressEvent):Void
		{
			var responseCode:String = this.buffer.substr(this.buffer.indexOf(" ")+1, 3);

			if (responseCode.search(~/^2/) == -1)
			{
				var ioError:IOErrorEvent = new IOErrorEvent(IOErrorEvent.IO_ERROR);
				ioError.text = "Error connecting to the proxy ["+this.proxyHost+"] on port ["+this.proxyPort+"]: " + this.buffer;
				this.dispatchEvent(ioError);
			}
			else
			{
				this.redirectSocketDataEvent();
				this.dispatchEvent(new Event(Event.CONNECT));
				if (this.bytesAvailable > 0)
				{
					this.dispatchEvent(event);
				}
			}
			this.buffer = null;
		}
		
		private function redirectConnectEvent():Void
		{
			super.removeEventListener(Event.CONNECT, onConnect);
			var deferredEventHandler:Dynamic = this.deferredEventHandlers[Event.CONNECT];
			if (deferredEventHandler != null)
			{
				super.addEventListener(Event.CONNECT, deferredEventHandler.listener, deferredEventHandler.useCapture, deferredEventHandler.priority, deferredEventHandler.useWeakReference);			
			}
		}
		
		private function redirectSocketDataEvent():Void
		{
			super.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			var deferredEventHandler:Dynamic = this.deferredEventHandlers[ProgressEvent.SOCKET_DATA];
			if (deferredEventHandler != null)
			{
				super.addEventListener(ProgressEvent.SOCKET_DATA, deferredEventHandler.listener, deferredEventHandler.useCapture, deferredEventHandler.priority, deferredEventHandler.useWeakReference);			
			}
		}
		
		public override function addEventListener(type:String, listener:Dynamic, ?useCapture:Bool = false, ?priority:Int=0.0, ?useWeakReference:Bool=false):Void
		{
			if (type == Event.CONNECT || type == ProgressEvent.SOCKET_DATA)
			{
				this.deferredEventHandlers[type] = {listener:listener,useCapture:useCapture, priority:priority, useWeakReference:useWeakReference};
			}
			else
			{
				super.addEventListener(type, listener, useCapture, priority, useWeakReference);
			}
		}
	}
