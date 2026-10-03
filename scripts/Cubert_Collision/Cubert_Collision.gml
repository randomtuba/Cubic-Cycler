/// @desc Points that automatically screenwrap, use get and set functions
/// @param _x Starting X coordinate
/// @param _y Starting Y coordinate
function wPoint(_x, _y) constructor {
	_x_internal = _x % room_width
	_y_internal = _y % room_height
	
	function getX() {
		return _x_internal
	}
	
	function setX(_x) {
		_x_internal = _x % room_width
	}
	
	function getY() {
		return _y_internal
	}
	
	function setY(_y) {
		_y_internal = _y % room_height
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
	/// @param {Struct.wPoint} _wPoint Point to check
	/// @return Struct containing X and Y distances as .x and .y respectively
	function distanceToPoint(_wPoint) {
		return distanceTo(_wPoint.getX(), _wPoint.getY())
	}
}

/// @desc Gets the size of an object
/// Returned as a struct with width as .w and height as .h
/// @param {Id.Instance, Id.TileMapElement} obj The object
function getObjSize(obj) {
	var obj_width = obj.sprite_index.bbox_right - obj.sprite_index.bbox_left
	var obj_height = obj.sprite_index.bbox_bottom - obj.sprite_index.bbox_top
	
	return { w : obj_width, h : obj_height }
}

/// @desc Determine whether two objects are touching, accounting for screenwrapping
///	Returns whether they are contacting and the distance along the X and Y axes
/// @param {Id.Instance} obj1 The first object
/// @param {Id.Instance, Id.TileMapElement} obj2 The second object
/// @param x1Change (Optional) Considers obj1 to be offset by this amount
/// @param y1Change (Optional) Considers obj1 to be offset by this amount
function checkContacting(obj1, obj2, x1Change = 0, y1Change = 0) {
	var obj1_size = getObjSize(obj1)
	var obj2_size = getObjSize(obj2)
	var obj1_center = new wPoint(obj1.x - abs(obj1.sprite_xoffset) + abs(obj1.sprite_width) / 2 + x1Change,
								obj1.y - abs(obj1.sprite_yoffset) + abs(obj1.sprite_height) / 2 + y1Change)
	var obj2_center = new wPoint(obj2.x - abs(obj2.sprite_xoffset) + abs(obj2.sprite_width) / 2,
								obj2.y - abs(obj2.sprite_yoffset) + abs(obj2.sprite_height) / 2)
	
	// This will be returned at the end
	var contact = {
		hit : false,
		xDist : 0,
		yDist : 0
	}
	
	// Get distances
	var dist = obj1_center.distanceToPoint(obj2_center)
	contact.xDist = dist.x
	contact.yDist = dist.y
	
	// Determine contact
	
	contact.hit = (
		abs(dist.x) <= obj1_size.w + obj2_size.w
		&& abs(dist.y) <= obj1_size.h + obj2_size.h
	)
	
	return contact
}

/// @desc Determines whether it would be valid to move an object by some offset
/// @param {Id.Instance} obj The object
/// @param collisions An array containing all objects that should be considered solid
/// @param _x The X offset to apply
/// @param _y The Y offset to apply
/// @param {Enum.Direction} _direction (Optional) If specified, only considers collisions in this direction
/// @param buffer (Optional) Used by _direction to determine how precise the collision should be, default 4
function checkValidMove(obj, collisions, _x, _y, _direction = Direction.None, buffer = 4) {
	var isValid = true
	var blockingObjects = []
	
	for (var i = 0; i < array_length(collisions); i++) {
		var compare = collisions[i]
		// Skip the object / tileset if there are no active instances of it
		if (!instance_exists(compare)) {
			continue
		}
		
		var contact = checkContacting(obj, compare, _x, _y)
		
		if (contact.hit) {
			var objSize = getObjSize(obj)
			var xSpace = objSize.w * 5/6
			var ySpace = objSize.h * 5/6
			// Make sure the direction is valid
			switch _direction {
				case Direction.None:
					isValid = false
					array_push(blockingObjects, compare)
				break
			
				case Direction.Up:
					if (contact.yDist < buffer - ySpace && abs(contact.xDist) < xSpace) {
						isValid = false
						array_push(blockingObjects, compare)
					}
				break
				
				case Direction.Down:
					if (contact.yDist > ySpace - buffer && abs(contact.xDist) < xSpace) {
						isValid = false
						array_push(blockingObjects, compare)
					}
				break
			
				case Direction.Left:
					if (contact.xDist < buffer - xSpace && abs(contact.yDist) < ySpace) {
						isValid = false
						array_push(blockingObjects, compare)
					}
				break
			
				case Direction.Right:
					if (contact.xDist > xSpace - buffer && abs(contact.yDist) < ySpace) {
						isValid = false
						array_push(blockingObjects, compare)
					}
				break
			}
		}
	}
	
	return { valid : isValid, blockers : blockingObjects }
}

/// @desc Determine if an object is grounded
/// Returns whether it is grounded and any objects that it is grounded on
/// @param {Id.Instance} obj The object
/// @param collisions An array containing all objects that should be considered solid
/// @param buffer (Optional) The distance at which things can be considered touching, default 2
function checkGrounded(obj, collisions, buffer = 2) {
	return checkValidMove(obj, collisions, 0, buffer, Direction.Down)
}

/// @desc Attempts to move an object by some offset
/// Returns whether the move was valid
/// This will change the coordinates of the passed object if the move succeeds
/// @param {Id.Instance} obj The object
/// @param collisions An array containing all objects that should be considered solid
/// @param _x The X offset to apply
/// @param _y The Y offset to apply
function attemptMove(obj, collisions, _x, _y) {
	var succeededX = false
	var succeededY = false
	
	var validDown = checkValidMove(obj, collisions, _x, _y, Direction.Down)
	var validUp = checkValidMove(obj, collisions, _x, _y, Direction.Up)
	var validRight = checkValidMove(obj, collisions, _x, _y, Direction.Right)
	var validLeft = checkValidMove(obj, collisions, _x, _y, Direction.Left)
	
	if ((validRight.valid && _x > 0) || (validLeft.valid && _x < 0)) {
		obj.x += _x
		succeededX = true
	}
	if ((validDown.valid && _y > 0) || (validUp.valid && _y < 0)) {
		obj.y += _y
		succeededY = true
	}
	
	show_debug_message("Move:")
	show_debug_message(validDown)
	show_debug_message(validUp)
	show_debug_message(validRight)
	show_debug_message(validLeft)
	
	return { x : succeededX, y : succeededY }
}

