/**
 * Tweener
 * Transition controller for movieclips, sounds, textfields and other objects
 *
 * @author		Zeh Fernando, Nate Chatellier, Arthur Debert
 * Ported to haXe by Baluta Cristian (www.ralcr.com/caurina)
 * @version		1.31.70, compatible with haXe 2.0
 */

/*
Licensed under the MIT License

Copyright (c) 2006-2007 Zeh Fernando, Nate Chatellier and Arthur Debert

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

http://code.google.com/p/tweener/  - original project page
http://code.google.com/p/tweener/wiki/License
http://ralcr.com/caurina/   - where is hosted the ported version
http://lib.haxe.org/
*/
package caurina.transitions;

#if flash8
import flash.MovieClip;
#elseif flash9
import flash.display.MovieClip;
import flash.events.Event;
#end

class Tweener {
	private static var __tweener_controller__ : MovieClip;	// Used to ensure the stage copy is always accessible (garbage collection)
	
	private static var _engineExists : Bool = false;		// Whether or not the engine is currently running
	private static var _inited : Bool = false;				// Whether or not the class has been initiated
	private static var _currentTime : Float;				// The current time. This is generic for all tweenings for a "time grid" based update
	private static var _currentTimeFrame : Int;				// The current frame. Used on frame-based tweenings

	private static var _tweenList : Array<Dynamic>;			// List of active tweens

	private static var _timeScale : Float = 1;				// Time scale (default = 1)

	private static var _transitionList : Dynamic;			// List of "pre-fetched" transition functions
	private static var _specialPropertyList : Dynamic;		// List of special properties
	private static var _specialPropertyModifierList : Dynamic;	// List of special property modifiers
	private static var _specialPropertySplitterList : Dynamic;	// List of special property splitters


	/**
	 * There's no constructor.
	 */
	public function new () {
		trace ("Tweener is a static class and should not be instantiated.");
	}


	// ==================================================================================================================================
	// TWEENING CONTROL functions -------------------------------------------------------------------------------------------------------

	/**
	 * Adds a new tweening
	 *
	 * @param		(first-n param)		Object				Object that should be tweened: a movieclip, textfield, etc.. OR an array of objects
	 * @param		(last param)		Object				Object containing the specified parameters in any order, as well as the properties that should be tweened and their values
	 * @param		.time				Number				Time in seconds or frames for the tweening to take (defaults 2)
	 * @param		.delay				Number				Delay time (defaults 0)
	 * @param		.useFrames			Boolean				Whether to use frames instead of seconds for time control (defaults false)
	 * @param		.transition			String/Function		Type of transition equation... (defaults to "easeoutexpo")
	 * @param		.transitionParams	Object				* Direct property, See the TweenListObj class
	 * @param		.onStart			Function			* Direct property, See the TweenListObj class
	 * @param		.onUpdate			Function			* Direct property, See the TweenListObj class
	 * @param		.onComplete			Function			* Direct property, See the TweenListObj class
	 * @param		.onOverwrite		Function			* Direct property, See the TweenListObj class
	 * @param		.onStartParams		Array				* Direct property, See the TweenListObj class
	 * @param		.onUpdateParams		Array				* Direct property, See the TweenListObj class
	 * @param		.onCompleteParams	Array				* Direct property, See the TweenListObj class
	 * @param		.onOverwriteParams	Array				* Direct property, See the TweenListObj class
	 * @param		.rounded			Boolean				* Direct property, See the TweenListObj class
	 * @param		.skipUpdates		Number				* Direct property, See the TweenListObj class
	 * @return							Boolean				TRUE if the tween was successfully added, FALSE if otherwise
	 */
	public static function addTween (p_scopes:Dynamic, p_parameters:Dynamic) : Bool {
		if (p_scopes == null) return false;

		var rScopes = new Array<Dynamic>(); // List of objects to tween
		if (Std.is (p_scopes, Array)) {
			// The first argument is an array
			rScopes = p_scopes;/*.concat()*/
		} else {
			// The first argument(s) is(are) object(s)
			rScopes = [p_scopes];
		}

        // make properties chain ("inheritance")
		var p_obj : Dynamic = TweenListObj.makePropertiesChain (p_parameters);
		
		// Creates the main engine if it isn't active
		if (!_inited) init();
		if (!_engineExists || __tweener_controller__ == null) startEngine(); // Quick fix for Flash not resetting the vars on double ctrl+enter...
		
		// Creates a "safer", more strict tweening object
		var rTime:Float = Math.isNaN (Reflect.field (p_obj, "time")) ? 0 : Reflect.field (p_obj, "time"); // Real time
		var rDelay:Float = Math.isNaN (Reflect.field (p_obj, "delay")) ? 0 : Reflect.field (p_obj, "delay"); // Real delay

		// Creates the property list; everything that isn't a hardcoded variable
		var rProperties = {}; // Object containing a list of PropertyInfoObj instances
		var restrictedWords = {time:true, delay:true, useFrames:true, skipUpdates:true, transition:true, transitionParams:true, onStart:true, onUpdate:true, onComplete:true, onOverwrite:true, onError:true, rounded:true, onStartParams:true, onUpdateParams:true, onCompleteParams:true, onOverwriteParams:true, onStartScope:true, onUpdateScope:true, onCompleteScope:true, onOverwriteScope:true, onErrorScope:true, quickAdd:true};
		var modifiedProperties = {};
		
		for (istr in Reflect.fields (p_obj)) {
			if (!Reflect.field (restrictedWords, istr)) {
				// It's an additional pair, so adds
				if (Reflect.field (_specialPropertySplitterList, istr) != null) {
					// Special property splitter
					var splitProperties:Array<Dynamic> = Reflect.field (_specialPropertySplitterList, istr).splitValues (Reflect.field (p_obj, istr), Reflect.field (_specialPropertySplitterList, istr).parameters);

					for (i in splitProperties) {
						if (Reflect.field (_specialPropertySplitterList, i.name) != null) {
							var splitProperties2:Array<Dynamic> = Reflect.field (_specialPropertySplitterList, i.name).splitValues (i.value, Reflect.field (_specialPropertySplitterList, i.name).parameters);
							for (j in splitProperties2) {
								Reflect.setField (rProperties, j.name, {valueStart:null, valueComplete:j.value, arrayIndex:j.arrayIndex, isSpecialProperty:false});
							}
						} else {
							Reflect.setField (rProperties, i.name, {valueStart:null, valueComplete:i.value, arrayIndex:i.arrayIndex, isSpecialProperty:false});
						}
					}
				} else if (Reflect.field (_specialPropertyModifierList, istr) != null) {
					// Special property modifier
					var tempModifiedProperties:Array<Dynamic> = Reflect.field (_specialPropertyModifierList, istr).modifyValues (Reflect.field (p_obj, istr));
					for (i in tempModifiedProperties) {
						Reflect.setField (modifiedProperties, i.name, {modifierParameters:i.parameters, modifierFunction:Reflect.field (_specialPropertyModifierList, istr).getValue});
					}
				} else {
					// Regular property or special property, just add the property normally
					Reflect.setField (rProperties, istr, {valueStart:null, valueComplete:Reflect.field (p_obj, istr)});
				}
			}
		}

		// Verifies whether the properties exist or not, for warning messages
		for (istr in Reflect.fields (rProperties)) {

			if (Reflect.field (_specialPropertyList, istr) != null) {
				Reflect.field (rProperties, istr).isSpecialProperty = true;
			} else {
				if (Reflect.field (rScopes[0], istr) == null) {
					printError ("The property '" + istr + "' doesn't seem to be a normal object property of " + rScopes[0].toString() + " or a registered special property.");
				}
			}
		}

		// Adds the modifiers to the list of properties
		for (istr in Reflect.fields (modifiedProperties)) {
			if (Reflect.field (rProperties, istr) != null) {
				Reflect.field (rProperties, istr).modifierParameters = Reflect.field (modifiedProperties, istr).modifierParameters;
				Reflect.field (rProperties, istr).modifierFunction = Reflect.field (modifiedProperties, istr).modifierFunction;
			}
		}

		var rTransition : Dynamic; // Real transition
		
		if (Std.is (p_obj.transition, String)) {
			// String parameter, transition names
			var trans = p_obj.transition.toLowerCase();
			rTransition = Reflect.field (_transitionList, trans);
		} else {
			// Proper transition function
			rTransition = p_obj.transition;
		}
		if (rTransition == null) rTransition = Reflect.field (_transitionList, "easeoutcubic");
		
		var nProperties : Dynamic;
		var nTween:TweenListObj;

		for (i in 0...rScopes.length) {
			// Makes a copy of the properties
			nProperties = {};
			for (istr in Reflect.fields (rProperties)) {
				Reflect.setField (nProperties, istr, new PropertyInfoObj (	Reflect.field (rProperties, istr).valueStart,
																			Reflect.field (rProperties, istr).valueComplete,
																			Reflect.field (rProperties, istr).valueComplete,
																			Reflect.field (rProperties, istr).arrayIndex,
																			{},
																			Reflect.field (rProperties, istr).isSpecialProperty,
																			Reflect.field (rProperties, istr).modifierFunction,
																			Reflect.field (rProperties, istr).modifierParameters)
				);
			}
			
			if (p_obj.useFrames == true) {
				nTween = new TweenListObj(
					/* scope			*/	rScopes[i],
					/* timeStart		*/	_currentTimeFrame + (rDelay / _timeScale),
					/* timeComplete		*/	_currentTimeFrame + ((rDelay + rTime) / _timeScale),
					/* useFrames		*/	true,
					/* transition		*/	rTransition,
											p_obj.transitionParams
				);
			} else {
				nTween = new TweenListObj(
					/* scope			*/	rScopes[i],
					/* timeStart		*/	_currentTime + ((rDelay * 1000) / _timeScale),
					/* timeComplete		*/	_currentTime + (((rDelay * 1000) + (rTime * 1000)) / _timeScale),
					/* useFrames		*/	false,
					/* transition		*/	rTransition,
											p_obj.transitionParams
				);
			}

			nTween.properties			=	nProperties;
			nTween.onStart				=	p_obj.onStart;
			nTween.onUpdate				=	p_obj.onUpdate;
			nTween.onComplete			=	p_obj.onComplete;
			nTween.onOverwrite			=	p_obj.onOverwrite;
			nTween.onError              =   p_obj.onError;
			nTween.onStartParams		=	p_obj.onStartParams;
			nTween.onUpdateParams		=	p_obj.onUpdateParams;
			nTween.onCompleteParams		=	p_obj.onCompleteParams;
			nTween.onOverwriteParams	=	p_obj.onOverwriteParams;
			nTween.onStartScope			=	p_obj.onStartScope;
			nTween.onUpdateScope		=	p_obj.onUpdateScope;
			nTween.onCompleteScope		=	p_obj.onCompleteScope;
			nTween.onOverwriteScope		=	p_obj.onOverwriteScope;
			nTween.onErrorScope			=	p_obj.onErrorScope;
			nTween.rounded				=	p_obj.rounded;
			nTween.skipUpdates			=	p_obj.skipUpdates;

			// Remove other tweenings that occur at the same time
			if (!p_obj.quickAdd) removeTweensByTime (nTween.scope, nTween.properties, nTween.timeStart, nTween.timeComplete);

			// And finally adds it to the list
			_tweenList.push (nTween);

			// Immediate update and removal if it's an immediate tween -- if not deleted, it executes at the end of this frame execution
			if (rTime == 0 && rDelay == 0) {
				var myT = _tweenList.length-1;
				updateTweenByIndex (myT);
				removeTweenByIndex (myT, false);
			}
		}

		return true;
	}

	// A "caller" is like this: [          |     |  | ||] got it? :)
	// this function is crap - should be fixed later/extend on addTween()

	/**
	 * Adds a new *caller* tweening
	 *
	 * @param		(first-n param)		Object				Object that should be tweened: a movieclip, textfield, etc.. OR an array of objects
	 * @param		(last param)		Object				Object containing the specified parameters in any order, as well as the properties that should be tweened and their values
	 * @param		.time				Number				Time in seconds or frames for the tweening to take (defaults 2)
	 * @param		.delay				Number				Delay time (defaults 0)
	 * @param		.count				Number				Number of times this caller should be called
	 * @param		.transition			String/Function		Type of transition equation... (defaults to "easeoutexpo")
	 * @param		.onStart			Function			Event called when tween starts
	 * @param		.onUpdate			Function			Event called when tween updates
	 * @param		.onComplete			Function			Event called when tween ends
	 * @param		.waitFrames			Boolean				Whether to wait (or not) one frame for each call
	 * @return							Boolean				TRUE if the tween was successfully added, FALSE if otherwise
	 */
#if !tweener_lite
	public static function addCaller (p_scopes:Dynamic, p_parameters:Dynamic) : Bool {
		if (p_scopes == null) return false;

		var rScopes = new Array<Dynamic>(); // List of objects to tween
		if (Std.is (p_scopes, Array)) {
			// The first argument is an array
			rScopes = p_scopes/*.concat()*/;
		} else {
			// The first argument(s) is(are) object(s)
			rScopes = [p_scopes];
		}
		
		var p_obj = p_parameters;
		
		// Creates the main engine if it isn't active
		if (!_inited) init();
		if (!_engineExists || __tweener_controller__ == null) startEngine(); // Quick fix for Flash not resetting the vars on double ctrl+enter...
		
		// Creates a "safer", more strict tweening object
		var rTime:Float = Math.isNaN (Reflect.field (p_obj, "time")) ? 0 : Reflect.field (p_obj, "time"); // Real time
		var rDelay:Float = Math.isNaN (Reflect.field (p_obj, "delay")) ? 0 : Reflect.field (p_obj, "delay"); // Real delay
		
		var rTransition:Dynamic; // Real transition
		if (Std.is (p_obj.transition, String)) {
			// String parameter, transition names
			var trans = p_obj.transition.toLowerCase();
			rTransition = Reflect.field (_transitionList, trans);
		} else {
			// Proper transition function
			rTransition = p_obj.transition;
		}
		if (rTransition == null) rTransition = Reflect.field (_transitionList, "easeoutcubic");

		var nTween : TweenListObj;
		
		for (i in 0...rScopes.length) {

			if (p_obj.useFrames == true) {
				nTween = new TweenListObj(
					/* scope			*/	rScopes[i],
					/* timeStart		*/	_currentTimeFrame + (rDelay / _timeScale),
					/* timeComplete		*/	_currentTimeFrame + ((rDelay + rTime) / _timeScale),
					/* useFrames		*/	true,
					/* transition		*/	rTransition,
											p_obj.transitionParams
				);
			} else {
				nTween = new TweenListObj(
					/* scope			*/	rScopes[i],
					/* timeStart		*/	_currentTime + ((rDelay * 1000) / _timeScale),
					/* timeComplete		*/	_currentTime + (((rDelay * 1000) + (rTime * 1000)) / _timeScale),
					/* useFrames		*/	false,
					/* transition		*/	rTransition,
											p_obj.transitionParams
				);
			}

			nTween.properties			=	null;
			nTween.onStart				=	p_obj.onStart;
			nTween.onUpdate				=	p_obj.onUpdate;
			nTween.onComplete			=	p_obj.onComplete;
			nTween.onOverwrite			=	p_obj.onOverwrite;
			nTween.onStartParams		=	p_obj.onStartParams;
			nTween.onUpdateParams		=	p_obj.onUpdateParams;
			nTween.onCompleteParams		=	p_obj.onCompleteParams;
			nTween.onOverwriteParams	=	p_obj.onOverwriteParams;
			nTween.onStartScope			=	p_obj.onStartScope;
			nTween.onUpdateScope		=	p_obj.onUpdateScope;
			nTween.onCompleteScope		=	p_obj.onCompleteScope;
			nTween.onOverwriteScope		=	p_obj.onOverwriteScope;
			nTween.onErrorScope			=	p_obj.onErrorScope;
			nTween.isCaller				=	true;
			nTween.count				=	p_obj.count;
			nTween.waitFrames			=	p_obj.waitFrames;

			// And finally adds it to the list
			_tweenList.push (nTween);

			// Immediate update and removal if it's an immediate tween -- if not deleted, it executes at the end of this frame execution
			if (rTime == 0 && rDelay == 0) {
				var myT = _tweenList.length-1;
				updateTweenByIndex (myT);
				removeTweenByIndex (myT, false);
			}
		}

		return true;
	}
#end
	/**
	 * Remove an specified tweening of a specified object the tweening list, if it conflicts with the given time
	 *
	 * @param		p_scope				Object						List of objects affected
	 * @param		p_properties		Object 						List of properties affected (PropertyInfoObj instances)
	 * @param		p_timeStart			Number						Time when the new tween starts
	 * @param		p_timeComplete		Number						Time when the new tween ends
	 * @return							Boolean						Whether or not it actually deleted something
	 */
	public static function removeTweensByTime (p_scope:Dynamic, p_properties:Dynamic, p_timeStart:Float, p_timeComplete:Float) : Bool {
		var removed = false;
		var removedLocally : Bool;
		
		for (i in 0..._tweenList.length) {
			if (p_scope == _tweenList[i].scope) {
				// Same object...
				if (p_timeComplete > _tweenList[i].timeStart && p_timeStart < _tweenList[i].timeComplete) {
					// New time should override the old one...
					removedLocally = false;
					for (pName in Reflect.fields (_tweenList[i].properties)) {
						if (Reflect.field (p_properties, pName) != null) {
							// Same object, same property
							// Finally, remove this old tweening and use the new one
							if (_tweenList[i].onOverwrite != null) {
								var eventScope = _tweenList[i].onOverwriteScope != null ? _tweenList[i].onOverwriteScope : _tweenList[i].scope;
								try {
									Reflect.callMethod (eventScope, _tweenList[i].onOverwrite, _tweenList[i].onOverwriteParams);
								} catch (e:Dynamic) {
									handleError (_tweenList[i], e, "onOverwrite");
								}
							}
							Reflect.setField (_tweenList[i].properties, pName, null);
							removedLocally = true;
							removed = true;
						}
					}
					if (removedLocally) {
						// Verify if this can be deleted
						if (AuxFunctions.getObjectLength (_tweenList[i].properties) == 0) removeTweenByIndex (i, false);
					}
				}
			}
		}

		return removed;
	}

	/**
	 * Remove tweenings from a given object from the tweening list
	 *
	 * @param		p_tween				Object		Object that must have its tweens removed
	 * @param		(2nd-last params)	Object		Property(ies) that must be removed
	 * @return							Boolean		Whether or not it successfully removed this tweening
	 */
	public static function removeTweens (p_scope:Dynamic, args:Array<String>) : Bool {
		// Create the property list
		var properties = new Array<String>();
		
		for (i in 1...args.length) {
			if (Std.is (args[i], String) && !AuxFunctions.isInArray (args[i], properties)) properties.push (args[i]);
		}
		// Call the affect function on the specified properties
		return affectTweens (removeTweenByIndex, p_scope, properties);
	}

	/**
	 * Remove all tweenings from the engine
	 *
	 * @return							Boolean		Whether or not it successfully removed a tweening
	 */
	public static function removeAllTweens () : Bool {
		if (_tweenList == null) return false;
		var removed = false;
		
		for (i in 0..._tweenList.length) {
			removeTweenByIndex (i, false);
			removed = true;
		}
		return removed;
	}

	/**
	 * Pause tweenings from a given object
	 *
	 * @param		p_scope				Object		Object that must have its tweens paused
	 * @param		(2nd-last params)	Object		Property(ies) that must be paused
	 * @return							Boolean		Whether or not it successfully paused something
	 */
	public static function pauseTweens (p_scope:Dynamic, args:Array<String>) : Bool {
		// Create the property list
		var properties = new Array<String>();
		
		for (i in 1...args.length) {
			if (Std.is (args[i], String) && !AuxFunctions.isInArray (args[i], properties)) properties.push (args[i]);
		}
		// Call the affect function on the specified properties
		return affectTweens (pauseTweenByIndex, p_scope, properties);
	}

	/**
	 * Pause all tweenings on the engine
	 *
	 * @return							Boolean		Whether or not it successfully paused a tweening
	 */
	public static function pauseAllTweens () : Bool {
		if (_tweenList == null) return false;
		var paused = false;
		
		for (i in 0..._tweenList.length) {
			pauseTweenByIndex (i);
			paused = true;
		}
		return paused;
	}
	
	/**
	 * Resume tweenings from a given object
	 *
	 * @param		p_scope				Object		Object that must have its tweens resumed
	 * @param		(2nd-last params)	Object		Property(ies) that must be resumed
	 * @return							Boolean		Whether or not it successfully resumed something
	 */
	public static function resumeTweens (p_scope:Dynamic, args:Array<String>) : Bool {
		// Create the property list
		var properties = new Array<String>();
		
		for (i in 1...args.length) {
			if (Std.is (args[i], String) && !AuxFunctions.isInArray (args[i], properties)) properties.push (args[i]);
		}
		// Call the affect function on the specified properties
		return affectTweens (resumeTweenByIndex, p_scope, properties);
	}
	
	/**
	 * Resume all tweenings on the engine
	 *
	 * @return							Boolean		Whether or not it successfully resumed a tweening
	 */
	public static function resumeAllTweens () : Bool {
		if (_tweenList == null || _tweenList == []) return false;
		var resumed = false;
		
		for (i in 0..._tweenList.length) {
			resumeTweenByIndex (i);
			resumed = true;
		}
		return resumed;
	}

	/**
	 * Do some generic action on specific tweenings (pause, resume, remove, more?)
	 *
	 * @param		p_function			Function	Function to run on the tweenings that match
	 * @param		p_scope				Object		Object that must have its tweens affected by the function
	 * @param		p_properties		Array		Array of strings that must be affected
	 * @return							Boolean		Whether or not it successfully affected something
	 */
	private static function affectTweens (p_affectFunction:Dynamic, p_scope:Dynamic, p_properties:Array<String>) : Bool {
		var affected = false;
		
		if (_tweenList == null || _tweenList == []) return false;
		
		for (i in 0..._tweenList.length) {
			if (_tweenList[i].scope == p_scope) {
				if (p_properties.length == 0) {
					// Can affect everything
					p_affectFunction (i);
					affected = true;
				} else {
					// Must check whether this tween must have specific properties affected
					var affectedProperties = new Array<String>();
					for (prop in p_properties) {
						if (Reflect.field (_tweenList[i].properties, prop) != null) {
							affectedProperties.push (prop);
						}
					}
					if (affectedProperties.length > 0) {
						// This tween has some properties that need to be affected
						var objectProperties = AuxFunctions.getObjectLength (_tweenList[i].properties);
						if (objectProperties == affectedProperties.length) {
							// The list of properties is the same as all properties, so affect it all
							p_affectFunction (i);
						} else {
							// The properties are mixed, so split the tween and affect only certain specific properties
							var slicedTweenIndex = splitTweens (i, affectedProperties);
							p_affectFunction (slicedTweenIndex);
						}
						affected = true;
					}
				}
			}
		}
		return affected;
	}
	
	/**
	 * Splits a tweening in two
	 *
	 * @param		p_tween				Number		Object that must have its tweens split
	 * @param		p_properties		Array		Array of strings containing the list of properties that must be separated
	 * @return							Number		The index number of the new tween
	 */
	public static function splitTweens (p_tween:Int, p_properties:Array<String>) : Int {
		// First, duplicates
		var originalTween:TweenListObj = _tweenList[p_tween];
		var newTween:TweenListObj = originalTween.clone (false);
		
		// Now, removes tweenings where needed
		
		// Removes the specified properties from the old one
		for (prop in p_properties) {
			if (Reflect.field (originalTween.properties, prop) != null) {
				Reflect.setField (originalTween.properties, prop, null);
			}
		}

		// Removes the unspecified properties from the new one
		var found : Bool;
		for (pName in Reflect.fields (newTween.properties)) {
			found = false;
			for (prop in p_properties) {
				if (prop == pName) {
					found = true;
					break;
				}
			}
			if (!found) {
				Reflect.setField (newTween.properties, pName, null);
			}
		}

		// If there are empty property lists, a cleanup is done on the next updateTweens() cycle
		_tweenList.push (newTween);
		return (_tweenList.length - 1);
		
	}


	// ==================================================================================================================================
	// ENGINE functions -----------------------------------------------------------------------------------------------------------------

	/**
	 * Updates all existing tweenings
	 *
	 * @return							Boolean		FALSE if no update was made because there's no tweening (even delayed ones)
	 */
	private static function updateTweens () : Bool {
		if (_tweenList == null || _tweenList == []) return false;
		
		var i = 0;
		while (i < _tweenList.length) {
			// Looping throught each Tweening and updating the values accordingly
			if (!_tweenList[i].isPaused) {
				if (!updateTweenByIndex (i)) {
					removeTweenByIndex (i, false);
				}
				if (_tweenList[i] == null) {
					removeTweenByIndex (i, true);
					i--;
				}
			}
			i++;
		}

		return true;
	}
	
	/**
	 * Remove an specific tweening from the tweening list
	 *
	 * @param		p_tween				Number		Index of the tween to be removed on the tweenings list
	 * @return							Boolean		Whether or not it successfully removed this tweening
	 */
	public static function removeTweenByIndex (p_tween:Int, p_finalRemoval:Bool) : Bool {
		_tweenList[p_tween] = null;
		if (p_finalRemoval) _tweenList.splice (p_tween, 1);
		return true;
	}

	/**
	 * Pauses an specific tween
	 *
	 * @param		p_tween				Number		Index of the tween to be paused
	 * @return							Boolean		Whether or not it successfully paused this tweening
	 */
	public static function pauseTweenByIndex (p_tween:Int) : Bool {
		var tTweening = _tweenList[p_tween];	// Shortcut to this tweening
		if (tTweening == null || tTweening.isPaused) return false;
		tTweening.timePaused = getCurrentTweeningTime (tTweening);
		Reflect.setField (tTweening, "isPaused", true);
		//tTweening.isPaused = true;

		return true;
	}

	/**
	 * Resumes an specific tween
	 *
	 * @param		p_tween				Number		Index of the tween to be resumed
	 * @return							Boolean		Whether or not it successfully resumed this tweening
	 */
	public static function resumeTweenByIndex (p_tween:Int) : Bool {
		var tTweening = _tweenList[p_tween];	// Shortcut to this tweening
		if (tTweening == null || !tTweening.isPaused) return false;
		var cTime = getCurrentTweeningTime (tTweening);
		tTweening.timeStart += cTime - tTweening.timePaused;
		tTweening.timeComplete += cTime - tTweening.timePaused;
		Reflect.setField (tTweening, "timePaused", null);
		Reflect.setField (tTweening, "isPaused", false);

		return true;
	}

	/**
	 * Updates an specific tween
	 *
	 * @param		i					Number		Index (from the tween list) of the tween that should be updated
	 * @return							Boolean		FALSE if it's already finished and should be deleted, TRUE if otherwise
	 */
	private static function updateTweenByIndex (i:Int) : Bool {
		var tTweening : Dynamic = _tweenList[i];	// Shortcut to this tweening
		
		if (tTweening == null || tTweening.scope == null) return false;
		
		var isOver = false;				// Whether or not it's over the update time
		var mustUpdate : Bool;			// Whether or not it should be updated (skipped if false)
		
		var nv : Float;					// New value for each property
		
		var t : Float;					// current time (frames, seconds)
		var b : Float;					// beginning value
		var c : Float;					// change in value
		var d : Float; 					// duration (frames, seconds)
		
		var pName : String;				// Property name, used in loops
		var eventScope : Dynamic;		// Event scope, used to call functions

		// Shortcut stuff for speed
		var tScope : Dynamic;			// Current scope
		var cTime : Float = getCurrentTweeningTime (tTweening);
		var tProperty : Dynamic;		// Property being checked
		
		if (cTime >= tTweening.timeStart) {
			// Can already start

			tScope = tTweening.scope;

			if (tTweening.isCaller) {
				// It's a 'caller' tween
				do {
					t = ((tTweening.timeComplete - tTweening.timeStart)/tTweening.count) * (tTweening.timesCalled + 1);
					b = tTweening.timeStart;
					c = tTweening.timeComplete - tTweening.timeStart;
					d = tTweening.timeComplete - tTweening.timeStart;
					nv = tTweening.transition (t, b, c, d, tTweening.transitionParams);

					if (cTime >= nv) {
						if (tTweening.onUpdate != null) {
							eventScope = tTweening.onUpdateScope != null ? tTweening.onUpdateScope : tScope;
							try {
								Reflect.callMethod (eventScope, tTweening.onUpdate, tTweening.onUpdateParams);
							} catch (e:Dynamic) {
								handleError (tTweening, e, "onUpdate");
							}
						}
						
						Reflect.setField (tTweening, "timesCalled", Reflect.field (tTweening, "timesCalled") + 1);
						
						if (tTweening.timesCalled >= tTweening.count) {
							isOver = true;
							break;
						}
						if (tTweening.waitFrames) break;
					}
					
				} while (cTime >= nv);
			} else {
				// It's a normal transition tween

				mustUpdate = tTweening.skipUpdates < 1 || tTweening.skipUpdates == null || tTweening.updatesSkipped >= tTweening.skipUpdates;

				if (cTime >= tTweening.timeComplete) {
					isOver = true;
					mustUpdate = true;
				}
				
				if (!tTweening.hasStarted) {

					// First update, read all default values (for proper filter tweening)
					if (tTweening.onStart != null) {
						eventScope = tTweening.onStartScope != null ? tTweening.onStartScope : tScope;
						try {
							Reflect.callMethod (eventScope, tTweening.onStart, tTweening.onStartParams);
						} catch (e:Dynamic) {
							handleError (tTweening, e, "onStart");
						}
					}
					var pv : Float=0;

					for (pName in Reflect.fields (tTweening.properties)) {
						if (Reflect.field (tTweening.properties, pName).isSpecialProperty) {
							// It's a special property, tunnel via the special property function
							if (Reflect.field (_specialPropertyList, pName).preProcess != null) {
								Reflect.field (tTweening.properties, pName).valueComplete = Reflect.field (_specialPropertyList, pName).preProcess (tScope, Reflect.field (_specialPropertyList, pName).parameters, Reflect.field (tTweening.properties, pName).originalValueComplete, Reflect.field (tTweening.properties, pName).extra);
							}
							pv = Reflect.field (_specialPropertyList, pName).getValue (tScope, Reflect.field (_specialPropertyList, pName).parameters, Reflect.field (tTweening.properties, pName).extra);
						} else {
							// Directly read property
							pv = Reflect.field (tScope, pName);
						}
						Reflect.field (tTweening.properties, pName).valueStart = Math.isNaN (pv) ? Reflect.field (tTweening.properties, pName).valueComplete : pv;
					}

					mustUpdate = true;
					Reflect.setField (tTweening, "hasStarted", true);
				}
				
				if (mustUpdate) {
					for (pName in Reflect.fields (tTweening.properties)) {
						tProperty = Reflect.field (tTweening.properties, pName);

						if (isOver) {
							// Tweening time has finished, just set it to the final value
							nv = tProperty.valueComplete;
						} else {
							if (tProperty.hasModifier) {
								// Modified
								t = cTime - tTweening.timeStart;
								d = tTweening.timeComplete - tTweening.timeStart;
								nv = tTweening.transition (t, 0, 1, d, tTweening.transitionParams);
								nv = tProperty.modifierFunction (tProperty.valueStart, tProperty.valueComplete, nv, tProperty.modifierParameters);
							} else {
								// Normal update
								t = cTime - tTweening.timeStart;
								b = tProperty.valueStart;
								c = tProperty.valueComplete - tProperty.valueStart;
								d = tTweening.timeComplete - tTweening.timeStart;
								nv = tTweening.transition (t, b, c, d, tTweening.transitionParams);
							}
						}
						
						if (tTweening.rounded) nv = Math.round (nv);
						if (tProperty.isSpecialProperty) {
							// It's a special property, tunnel via the special property method
							Reflect.field (_specialPropertyList, pName).setValue (tScope, nv, Reflect.field (_specialPropertyList, pName).parameters, Reflect.field (tTweening.properties, pName).extra);
						} else {
							// Directly set property
							Reflect.setField (tScope, pName, nv);
						}
					}
					
					Reflect.setField (tTweening, "updatesSkipped", 0);
					//tTweening.updatesSkipped = 0;
					
					if (tTweening.onUpdate != null) {
						eventScope = tTweening.onUpdateScope != null ? tTweening.onUpdateScope : tScope;
						try {
							Reflect.callMethod (eventScope, tTweening.onUpdate, tTweening.onUpdateParams);
						} catch (e:Dynamic) {
							handleError (tTweening, e, "onUpdate");
						}
					}
				} else {
					Reflect.setField (tTweening, "updatesSkipped", Reflect.field (tTweening, "updatesSkipped") + 1);
				}
			}
			
			if (isOver && tTweening.onComplete != null) {
				eventScope = tTweening.onCompleteScope != null ? tTweening.onCompleteScope : tScope;
				try {
					Reflect.callMethod (eventScope, tTweening.onComplete, tTweening.onCompleteParams);
				} catch (e:Dynamic) {
					handleError (tTweening, e, "onComplete");
				}
			}

			return (!isOver);
		}

		// On delay, hasn't started, so return true
		return true;
	}

	/**
	 * Initiates the Tweener. Should only be ran once
	 */
	private static function init () : Void {
		_inited = true;
		
		// Registers all default equations
		_transitionList = {};
		Equations.init();
		
		// Registers all default special properties
		_specialPropertyList = {};
		_specialPropertyModifierList = {};
		_specialPropertySplitterList = {};
	}
	
	/**
	 * Adds a new function to the available transition list "shortcuts"
	 *
	 * @param		p_name				String		Shorthand transition name
	 * @param		p_function			Function	The proper equation function
	 */
	public static function registerTransition (p_name:String, p_function:Dynamic) : Void {
		if (!_inited) init();
		Reflect.setField (_transitionList, p_name, p_function);
	}
	
	/**
	 * Adds a new special property to the available special property list.
	 *
	 * @param		p_name				Name of the "special" property.
	 * @param		p_getFunction		Function that gets the value.
	 * @param		p_setFunction		Function that sets the value.
	 */
	public static function registerSpecialProperty (p_name:String, p_getFunction:Dynamic, p_setFunction:Dynamic, ?p_parameters:Array<Dynamic>, ?p_preProcessFunction:Dynamic) : Void {
		if (!_inited) init();
		var sp = new SpecialProperty (p_getFunction, p_setFunction, p_parameters, p_preProcessFunction);
		Reflect.setField (_specialPropertyList, p_name, sp);
	}

	/**
	 * Adds a new special property modifier to the available modifier list.
	 *
	 * @param		p_name				Name of the "special" property modifier.
	 * @param		p_modifyFunction	Function that modifies the value.
	 * @param		p_getFunction		Function that gets the value.
	 */
	public static function registerSpecialPropertyModifier (p_name:String, p_modifyFunction:Dynamic, p_getFunction:Dynamic) : Void {
		if (!_inited) init();
		var spm = new SpecialPropertyModifier (p_modifyFunction, p_getFunction);
		Reflect.setField (_specialPropertyModifierList, p_name, spm);
	}

	/**
	 * Adds a new special property splitter to the available splitter list.
	 *
	 * @param		p_name				Name of the "special" property splitter.
	 * @param		p_splitFunction		Function that splits the value.
	 */
	public static function registerSpecialPropertySplitter (p_name:String, p_splitFunction:Dynamic, ?p_parameters:Array<Dynamic>) : Void {
		if (!_inited) init();
		var sps = new SpecialPropertySplitter (p_splitFunction, p_parameters);
		Reflect.setField (_specialPropertySplitterList, p_name, sps);
	}

	/**
	 * Starts the Tweener class engine. It is supposed to be running every time a tween exists
	 */
	private static function startEngine () : Void {
		_engineExists = true;
		_tweenList = [];

#if flash8
		var randomDepth = Math.floor (Math.random() * 999999);
		__tweener_controller__ = flash.Lib._root.createEmptyMovieClip (getControllerName(), 31338+randomDepth);
		__tweener_controller__.onEnterFrame = onEnterFrame;
#elseif flash9
		__tweener_controller__ = new MovieClip();
		__tweener_controller__.addEventListener (Event.ENTER_FRAME, Tweener.onEnterFrame);
#end

		_currentTimeFrame = 0;
		updateTime();
	}

	/**
	 * Stops the Tweener class engine
	 */
	private static function stopEngine () : Void {
		_engineExists = false;
		_tweenList = null;
		_currentTime = 0;
		_currentTimeFrame = 0;
#if flash8
		__tweener_controller__.onEnterFrame = null;
		__tweener_controller__.removeMovieClip();
#elseif flash9
		__tweener_controller__.removeEventListener (Event.ENTER_FRAME, Tweener.onEnterFrame);
		__tweener_controller__ = null;
#end
	}

	/**
	 * Updates the time to enforce time grid-based updates
	 */
	public static function updateTime () : Void {
		_currentTime = flash.Lib.getTimer();
	}
	
	/**
	 * Updates the current frame count
	 */
	public static function updateFrame () : Void {
		_currentTimeFrame++;
	}

	/**
	 * Ran once every frame. It's the main engine, updates all existing tweenings.
	 */
#if flash8
	public static function onEnterFrame () : Void {
#elseif flash9
	public static function onEnterFrame (e:Event) : Void {
#end
		updateTime();
		updateFrame();
		var hasUpdated = false;
		hasUpdated = updateTweens();
		if (!hasUpdated) stopEngine();	// There's no tweening to update or wait, so it's better to stop the engine
	}

	/**
	 * Sets the new time scale.
	 *
	 * @param		p_time				Number		New time scale (0.5 = slow, 1 = normal, 2 = 2x fast forward, etc)
	 */
	public static function setTimeScale (p_time:Float) : Void {
		if (Math.isNaN (p_time)) p_time = 1;
		if (p_time < 0.00001) p_time = 0.00001;
		if (p_time != _timeScale) {
			// Multiplies all existing tween times accordingly
			for (tweenListObj in _tweenList) {
				var cTime = getCurrentTweeningTime (tweenListObj);
				tweenListObj.timeStart    = cTime - ((cTime - tweenListObj.timeStart) * _timeScale / p_time);
				tweenListObj.timeComplete = cTime - ((cTime - tweenListObj.timeComplete) * _timeScale / p_time);
				if (tweenListObj.timePaused != null) tweenListObj.timePaused = cTime - ((cTime - tweenListObj.timePaused) * _timeScale / p_time);
			}
			// Sets the new timescale value (for new tweenings)
			_timeScale = p_time;
		}
	}
#if !tweener_lite
	// ==================================================================================================================================
	// AUXILIARY functions --------------------------------------------------------------------------------------------------------------

	/**
	 * Finds whether or not an object has any tweening
	 *
	 * @param		p_scope				Object		Target object
	 * @return							Boolean		Whether or not there's a tweening occuring on this object (paused, delayed, or active)
	 */
	public static function isTweening (p_scope:Dynamic) : Bool {
        for (tweenListObj in _tweenList) {
            if (tweenListObj.scope == p_scope) {
                return true;
            }
        }
        return false;
    }

	/**
	 * Return an array containing a list of the properties being tweened for this object
	 *
	 * @param		p_scope				Object		Target object
	 * @return							Array		List of strings with properties being tweened (including delayed or paused)
	 */
	public static function getTweens (p_scope:Dynamic) : Array<String> {
        var tList = new Array<String>();
		
        for (tweenListObj in _tweenList) {
            if (tweenListObj.scope == p_scope) {
				for (pName in Reflect.fields (tweenListObj.properties)) {
					tList.push (pName);
				}
            }
        }
		return tList;
    }

	/**
	 * Return the number of properties being tweened for this object
	 *
	 * @param		p_scope				Object		Target object
	 * @return							Number		Total count of properties being tweened (including delayed or paused)
	 */
	public static function getTweenCount (p_scope:Dynamic) : Int {
		var c = 0;

        for (tweenListObj in _tweenList) {
            if (tweenListObj.scope == p_scope) {
				c += AuxFunctions.getObjectLength (tweenListObj.properties);
            }
        }
		return c;
    }
#end
    /* Handles errors when Tweener executes any callbacks (onStart, onUpdate, etc)
    *  If the TweenListObj specifies an <code>onError</code> callback it well get called, passing the <code>Error</code> object and the current scope as parameters. If no <code>onError</code> callback is specified, it will trace a stackTrace.
    */
    private static function handleError (pTweening:Dynamic, pError:Dynamic, pCallBackName:String) : Void {
        // do we have an error handler?
        if (pTweening.onError != null && Reflect.isFunction (pTweening.onError)){
            // yup, there's a handler. Wrap this in a try catch in case the onError throws an error itself.
			var eventScope:Dynamic = pTweening.onErrorScope != null ? pTweening.onErrorScope : pTweening.scope;
            try {
                Reflect.callMethod (eventScope, pTweening.onError, [pTweening.scope, pError]);
            } catch (metaError : Dynamic) {
				printError (pTweening.scope.toString() + " raised an error while executing the 'onError' handler. Original error:\n " + pError +  "\nonError error: " + metaError);
            }
        } else {
            // if handler is undefied or null trace the error message (allows empty onErro's to ignore errors)
            if (pTweening.onError == null) {
				printError (pTweening.scope.toString() + " raised an error while executing the '" + pCallBackName.toString() + "'handler. \n" + pError );
            }
        }
    }

	/**
	 * Get the current tweening time (no matter if it uses frames or time as basis), given a specific tweening
	 *
	 * @param		p_tweening				TweenListObj		Tween information
	 */
	public static function getCurrentTweeningTime (p_tweening:Dynamic) : Float {
		return p_tweening.useFrames ? _currentTimeFrame : _currentTime;
	}

	/**
	 * Return the current tweener version
	 *
	 * @return							String		The number of the current Tweener version
	 */
	public static function getVersion () : String {
		return "haXe2.0 1.31.70";
    }

	/**
	 * Return the name for the controller movieclip
	 *
	 * @return							String		The number of the current Tweener version
	 */
	public static function getControllerName () : String {
		return "__tweener_controller__" + Tweener.getVersion();
    }



	// ==================================================================================================================================
	// DEBUG functions ------------------------------------------------------------------------------------------------------------------

	/**
	 * Output an error message
	 *
	 * @param		p_message				String		The error message to output
	 */
	public static function printError (p_message:String) : Void {
		//
		trace ("## [Tweener] Error: " + p_message);
	}

}
