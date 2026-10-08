#region Structs

/// @desc Points that automatically screenwrap, use get and set functions
/// @param _x Starting X coordinate
/// @param _y Starting Y coordinate
/// @param wraps Whether to screenwrap during object creation
function wPoint(_x, _y, wraps = true) constructor {
	if (wraps) {
		while (_x < 0) {
			_x += room_width
		}
		while (_y < 0) {
			_y += room_height
		}
		_x = _x % room_width
		_y = _y % room_height
	}
	_x_internal = _x
	_y_internal = _y
	
	function getX() {
		return _x_internal
	}
	
	function setX(_x, wraps = true) {
		if (wraps) {
			while (_x < 0) {
				_x += room_width
			}
			_x_internal = _x % room_width
		} else {
			_x_internal = _x
		}
	}
	
	function getY() {
		return _y_internal
	}
	
	function setY(_y, wraps = true) {
		if (wraps) {
			while (_y < 0) {
				_y += room_height
			}
			_y_internal = _y % room_height
		} else {
			_y_internal = _y
		}
	}
	
	/// @desc Gets the distance to a point, accounting for screenwraps
	/// - CAN BE NEGATIVE -
	/// Positive means the point is down or to the right
	/// Negative means the point is up or to the left
	/// @param {Real} _x X coordinate to check
	/// @param {Real} _y Y coordinate to check
	/// @return Struct containing X and Y distances as .x and .y respectively
	function distanceTo(_x, _y) {
		// Find smallest X distance, including by wrapping
		var _xDist = _x - getX()
		if (abs(_x - getX() - room_width) < abs(_xDist)) {
			_xDist = _x - getX() - room_width
		}
		if (abs(_x - getX() + room_width) < abs(_xDist)) {
			_xDist = _x - getX() + room_width
		}
		
		// Find smallest Y distance, including by wrapping
		var _yDist = _y - getY()
		if (abs(_y - getY() - room_height) < abs(_yDist)) {
			_yDist = _y - getY() - room_height
		}
		if (abs(_y - getY() + room_height) < abs(_yDist)) {
			_yDist = _y - getY() + room_height
		}
		
		return { x : _xDist, y : _yDist }
	}
	
	/// @desc Gets the distance to another wPoint, accounting for screenwraps
	/// - CAN BE NEGATIVE -
	/// Positive means the point is down or to the right
	/// Negative means the point is up or to the left
	/// @param {Struct.wPoint} _wPoint Point to check
	/// @return Struct containing X and Y distances as .x and .y respectively
	function distanceToPoint(_wPoint) {
		return distanceTo(_wPoint.getX(), _wPoint.getY())
	}

	/// @desc Returns a new wPoint with coordinates offset
	/// @param {Real} _x The X offset
	/// @param {Real} _y The Y offset
	function withPosChange(_x, _y) {
		return new wPoint(getX() + _x, getY() + _y, should_screenwrap())
	}
}

/// @desc Struct for keeping track of object collisions
/// @param {Bool} _hit Whether the objects are colliding
/// @param {Real} _xDist The X distance between the objects
/// @param {Real} _yDist The Y distance between the objects
/// @param {Id.Instance, Id.TileMapElement} _obj The object that was hit
function Contact(_hit, _xDist, _yDist, _obj) constructor {
	hit = _hit
	xDist = _xDist
	yDist = _yDist
	obj = _obj
}

/// @desc Struct for keeping track of tilemap collisions
function MapContact(_map) constructor {
	directions = [false, false, false, false, false]
	obj = _map
}

#endregion Structs

/// @desc Returns whether screenwrapping is active
function should_screenwrap() {
	if (instance_exists(obj_generator)) {
		with (obj_generator) {
			if (isOn) {
				return true
			}
		}
	}
	return false
}

/// @desc Returns whether a thing is a reference to a tilemap
/// Technically, this checks whether something is not an object
/// @param thing The thing to check
function isTilemap(thing) {
	return !instance_exists(thing)
}

/// @desc Gets the size of an object
/// Returned as a struct with width as .w and height as .h
/// Tilemaps are considered size 0 on both axes
/// @param {Id.Instance, Id.TileMapElement} obj The object
function getObjSize(obj) {
	// Consider tilemaps to be of size 0
	if (isTilemap(obj)) {
		return { w : 0, h : 0 }
		
	} else {
		return {
			w : abs(obj.object_index.bbox_right - obj.object_index.bbox_left),
			h : abs(obj.object_index.bbox_bottom - obj.object_index.bbox_top)
		}
	}
}

/// @desc Gets a MapContact based on an object and a tilemap
/// @param {Id.Instance} obj The object to check
/// @param {Id.TileMapElement} map The tilemap
/// @param x1Change (Optional) Considers obj to be offset by this amount
/// @param y1Change (Optional) Considers obj to be offset by this amount
/// @param buffer (Optional) Determines how precise the directional collision should be, default 4	
function checkContactTilemap(obj, map, x1Change = 0, y1Change = 0, buffer = 4) {
	var obj_center = new wPoint(obj.x - abs(obj.sprite_xoffset) + abs(obj.sprite_width) / 2 + x1Change,
								obj.y - abs(obj.sprite_yoffset) + abs(obj.sprite_height) / 2 + y1Change)
	var obj_size = getObjSize(obj)
	
	// This is returned later
	var contact = new MapContact(map)
	
	// Try to find all colliding tiles, based on 9 points around obj1_center
	for (var _x = -1; _x <= 1; _x++) {
		for (var _y = -1; _y <= 1; _y++) {
			var check = new wPoint(
				(obj_center.getX() + _x * (obj_size.w / 2)),
				(obj_center.getY() + _y * (obj_size.h / 2)),
				should_screenwrap()
			)
			
			
			var tile = tilemap_get_at_pixel(map, check.getX(), check.getY())
			
			// If successful, determine which direction the collision was in
			if (tile > 0) {
				contact.directions[Direction.None] = true
				// Check whether it's still colliding after small movements towards the center of obj
				var xPoint = check.withPosChange(-_x * (abs(x1Change) + buffer), 0)
				var xMoved = tilemap_get_at_pixel(map, xPoint.getX(), xPoint.getY())
				
				var yPoint = check.withPosChange(0, -_y * (abs(y1Change) + buffer))
				var yMoved = tilemap_get_at_pixel(map, yPoint.getX(), yPoint.getY())
				
				if (yMoved == 0) {
					// Was a vertical collision (Priority over horizontal)
					if (_y > 0) {
						contact.directions[Direction.Down] = true
					} else if (_y < 0) {
						contact.directions[Direction.Up] = true
					}
					
				} else if (xMoved == 0) {
					// Was a horizontal collision
					if (_x > 0) {
						contact.directions[Direction.Right] = true
					} else if (_x < 0) {
						contact.directions[Direction.Left] = true
					}
				}
			}
		}
	}
	
	return contact
}

/// @desc Checks for contact using Game Maker's built in methods
/// @param {Id.Instance} obj The object to check
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} compare The list of things to consider solid
/// @param x1Change (Optional) Considers obj to be offset by this amount
/// @param y1Change (Optional) Considers obj to be offset by this amount
/// @param buffer (Optional) Determines how precise the directional collision should be, default 4
function checkContactGM(obj, compare, x1Change = 0, y1Change = 0, buffer = 4) {
	var obj1_center = new wPoint(obj.x - abs(obj.sprite_xoffset) + abs(obj.sprite_width) / 2 + x1Change,
								obj.y - abs(obj.sprite_yoffset) + abs(obj.sprite_height) / 2 + y1Change)
	
	// This is returned at the end
	var contacts = []
	
	// Account for screenwrapped positions, 9 total
	for (var _x = -1; _x <= 1; _x++) {
		for (var _y = -1; _y <= 1; _y++) {
			// Get hit objects
			var hitObjects = ds_list_create()
			with (obj) {
				instance_place_list(x + x1Change + room_width * _x, y + y1Change + room_height * _y, compare, hitObjects, false)
			}
			
			// Store any hits alongside their distances
			for (var i = 0; i < ds_list_size(hitObjects); i++) {
				var obj2 = ds_list_find_value(hitObjects, i)
				
				if (isTilemap(obj2)) {
					// Tilemap collision
					var contact = checkContactTilemap(obj, obj2, x1Change, y1Change, buffer)
					array_push(contacts, contact)
				} else {
					// Regular object collision
					var obj2_center = new wPoint(obj2.x - abs(obj2.sprite_xoffset) + abs(obj2.sprite_width) / 2,
											obj2.y - abs(obj2.sprite_yoffset) + abs(obj2.sprite_height) / 2)
					var dist = obj1_center.distanceToPoint(obj2_center)
					var contact = new Contact(true, dist.x, dist.y, obj2) 
					array_push(contacts, contact)
				}
				
			}
			
			ds_list_destroy(hitObjects)
		}
	}
	
	return contacts
}

/// @desc Returns whether a contact is in the correct direction
/// @param {Id.Instance} obj The object colliding
/// @param {Struct.Contact} contact The contact
/// @param {Enum.Direction} _direction The desired direction
/// @param buffer (Optional) Determines how precise the directional collision should be, default 4
function contactMeetsDirection(obj, contact, _direction, buffer = 4) {
	if (contact.hit) {
		var obj1Size = getObjSize(obj)
		var obj2Size = getObjSize(contact.obj)
		var xSpace = (obj1Size.w / 2 + obj2Size.w / 2) * 7/8
		var ySpace = (obj1Size.h / 2 + obj2Size.h / 2) * 7/8
		// Make sure the direction is valid
		switch _direction {
			case Direction.Up:
				if (buffer > (contact.yDist + ySpace) && abs(contact.xDist) < xSpace) {
					return true
				}
			break
		
			case Direction.Down:
				if (-buffer < (contact.yDist - ySpace) && abs(contact.xDist) < xSpace) {
					return true
				}
			break
			
			case Direction.Left:
				if (buffer > (contact.xDist + xSpace) && abs(contact.yDist) < ySpace) {
					return true
				}
			break
		
			case Direction.Right:
				if (-buffer < (contact.xDist - xSpace) && abs(contact.yDist) < ySpace) {
					return true
				}
			break
		
			case Direction.None:
				return true
		}
	}
	return false
}

/// @desc Determines whether it would be valid to move an object by some offset using Game Maker's built-in functions
/// @param {Id.Instance} obj The object
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} collisions An array containing all objects that should be considered solid
/// @param {Real} _x The X offset to apply
/// @param {Real} _y The Y offset to apply
/// @param {Enum.Direction} _direction (Optional) If specified, only considers collisions in this direction
/// @param buffer (Optional) Used by _direction to determine how precise the collision should be, default 4
function checkValidMoveGM(obj, collisions, _x, _y, _direction = Direction.None, buffer = 4) {
	// These are returned later
	var isValid = true
	var blockers = []
	
	// List of all contacts, either Struct.Contact or Struct.MapContact
	var contacts = checkContactGM(obj, collisions, _x, _y, buffer)
	
	for (var i = 0; i < array_length(contacts); i++) {
		var c = contacts[i]
		if (is_instanceof(c, MapContact)) {
			// Tilemap collision
			var matchesDirection = c.directions[_direction]
			
			if (matchesDirection) {
				isValid = false
				array_push(blockers, c.obj)
			}
		} else {
			// Regular collision
			var matchesDirection = contactMeetsDirection(obj, c, _direction, buffer)
		
			if (matchesDirection) {
				isValid = false
				array_push(blockers, c.obj)
			}
		}
	}
	
	return { valid : isValid, blockers }
}

/// @desc Determines whether it would be valid to move an object by some offset
/// Returns arrays intended to be indexed by the Direction enum
/// @param {Id.Instance} obj The object
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} collisions An array containing all objects that should be considered solid
/// @param {Real} _x The X offset to apply
/// @param {Real} _y The Y offset to apply
/// @param buffer (Optional) Used to determine how precise the directional collision should be, default 4
function checkValidMoveAllDirections(obj, collisions, _x, _y, buffer = 4) {
	// These are returned later
	// Can be indexed by the Direction enum
	var isValid = [true, true, true, true, true]
	var blockers = [[], [], [], [], []]
	
	// List of all contacts, either Struct.Contact or Struct.MapContact
	var contacts = checkContactGM(obj, collisions, _x, _y, buffer)
	
	for (var i = 0; i < array_length(contacts); i++) {
		var c = contacts[i]
		if (is_instanceof(c, MapContact)) {
			// Tilemap collision
			for (var j = 0; j < 5; j++) {
				if (c.directions[j]) {
					isValid[j] = false
					array_push(blockers[j], c.obj)
				}
			}
		} else {
			// Regular collision
			for (var j = 0; j < 5; j++) {
				var matchesDirection = contactMeetsDirection(obj, c, j, buffer)
		
				if (matchesDirection) {
					isValid[j] = false
					array_push(blockers[j], c.obj)
				}
			}
		}
	}
	
	return { valid : isValid, blockers }
}

/// @desc Determine if an object is grounded
/// Returns whether it is grounded and any objects that it is grounded on
/// @param {Id.Instance} obj The object
/// @param collisions An array containing all objects that should be considered solid
/// @param buffer (Optional) The distance at which things can be considered touching, default 2
function checkGrounded(obj, collisions, buffer = 2) {
	return checkValidMoveGM(obj, collisions, 0, buffer, Direction.Down)
}

/// @desc Attempts to move an object by some offset
/// Returns whether the move was valid
/// This will change the coordinates of the passed object if the move succeeds
/// @param {Id.Instance} obj The object
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} collisions An array containing all objects that should be considered solid
/// @param _x The X offset to apply
/// @param _y The Y offset to apply
/// @param buffer (Optional) The distance to check for directional collisions, default 4
/// @param {Bool} wraps (Optional) Whether to screenwrap or not, default true
function attemptMove(obj, collisions, _x, _y, buffer = 4, wraps = true) {
	var valid = checkValidMoveAllDirections(obj, collisions, _x, _y, buffer)
	
	// This is returned later
	var success = {
		x : false,
		y : false,
		blockers : valid.blockers
	}
	
	// Prevent movement into obstacles
	if ((valid.valid[Direction.Right] && _x > 0) || (valid.valid[Direction.Left] && _x < 0)) {
		obj.pos.move(_x, 0, wraps)
		success.x = true
	}
	if ((valid.valid[Direction.Down] && _y > 0) || (valid.valid[Direction.Up] && _y < 0)) {
		obj.pos.move(0, _y, wraps)
		success.y = true
	}
	
	return success
}

/// @desc Attempts to move an object by some offset, separated into several steps
/// Returns whether the move was valid
/// This will change the coordinates of the passed object if the move succeeds
/// @param {Id.Instance} obj The object
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} collisions An array containing all objects that should be considered solid
/// @param _x The X offset to apply
/// @param _y The Y offset to apply
/// @param buffer (Optional) The distance to check for directional collisions, default 4
/// @param {Bool} wraps (Optional) Whether to screenwrap or not, default true
/// @param steps (Optional) Number of steps, default 4
function attemptMoveInSteps(obj, collisions, _x, _y, buffer = 4, wraps = true, steps = 4) {
	var xPerStep = _x / steps
	var yPerStep = _y / steps
	
	// This is returned later
	var success = {
		x : true,
		y : true,
		blockers : []
	}
	
	for (var step = 1; step <= steps; step++) {
		var result = attemptMove(obj, collisions, xPerStep, yPerStep, buffer, wraps)
		
		if (step == steps) {
			success = result
		}
	}
	
	return success
}

/// @desc Gets all touching objects from the passed collisions
/// @param {Id.Instance} obj The object
/// @param {Id.TileMapElement, Asset.GMObject, Constant.All, Array} collisions An array containing all objects that should be counted
function getContacting(obj, collisions) {
	// This is returned at the end
	var contacts = []
	
	// Account for screenwrapped positions, 9 total
	for (var _x = -1; _x <= 1; _x++) {
		for (var _y = -1; _y <= 1; _y++) {
			// Get hit objects
			var hitObjects = ds_list_create()
			with (obj) {
				instance_place_list(x + room_width * _x, y + room_height * _y, collisions, hitObjects, false)
			}
			
			// Store any hits
			for (var i = 0; i < ds_list_size(hitObjects); i++) {
				var obj2 = ds_list_find_value(hitObjects, i)
				array_push(contacts, obj2)
			}
			
			ds_list_destroy(hitObjects)
		}
	}
	
	return contacts
}
	
/// @desc Calls the apply_interaction(obj) function of all objects in list
/// @param list The list of objects to work on
function runEvents(list) {
	for (var i = 0; i < array_length(list); i++) {
		var obj = list[i]
		with obj {
			try {
				apply_interaction(other)
			} catch (_exception) {
				show_debug_message("")
				show_debug_message("Error when calling apply_interaction() function from " + string(object_index) + ":")
				show_debug_message(_exception)
				show_debug_message("")
			}
		}
	}
}

/// @desc Calls the apply_interaction(obj) function of one object
/// @param list The object to work on
function runEvent(obj) {
	with obj {
		try {
			apply_interaction(other)
		} catch (_exception) {
			show_debug_message("")
			show_debug_message("Error when calling apply_interaction() function from " + string(object_index) + ":")
			show_debug_message(_exception)
			show_debug_message("")
		}
	}
}
	
/// @desc Calls the apply_interaction(obj) function of one object with an associated direction
/// @param list The object to work on
/// @param dir The direction
function runEventWithDirection(obj, dir) {
	with obj {
		try {
			apply_interaction(other, dir)
		} catch (_exception) {
			show_debug_message("")
			show_debug_message("Error when calling apply_interaction() function from " + string(object_index) + ":")
			show_debug_message(_exception)
			show_debug_message("")
		}
	}
}
	
/// @desc Calls the apply_interaction(obj) function of all contacting objects and ground objects in the passed list
/// @param list The list of objects to check for grounded interactions
function runEventsAndGrounded(groundedObjects) {
	runEvents(getContacting(self, HAVE_CONTACT_BEHAVIOUR))
	for (var i = 0; i < array_length(groundedObjects); i++) {
		var current = groundedObjects[i]
		if (instance_exists(current) && array_contains(HAVE_GROUNDED_BEHAVIOUR, current.object_index)) {
			runEvent(current)
		}
	}
}

/// @desc Calls the apply_interaction(obj) function of all blockers with an interaction
/// @param blockers The list of objects to work on
function runBlockerEvents(blockers) {
	// "d" is a direction
	for (var d = 0; d < 5; d++) {
		for (var i = 0; i < array_length(blockers[d]); i++) {
			var current = blockers[d][i]
			if (instance_exists(current) && array_contains(HAVE_BLOCKER_BEHAVIOUR, current.object_index)) {
				runEventWithDirection(current, d)
			}
		}
	}
}