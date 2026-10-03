

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
	/// @param {Real} _x X coordinate to check
	/// @param {Real} _y Y coordinate to check
	/// @return Struct containing X and Y distances as .x and .y respectively
	function distanceTo(_x, _y) {
		var _xDist = min(
			abs(getX() - _x),
			abs(getX() - _x - room_width),
			abs(getX() - _x + room_width)
		)
		var _yDist = min(
			abs(getY() - _y),
			abs(getY() - _y - room_height),
			abs(getY() - _y + room_height)
		)
		return { x : _xDist, y : _yDist }
	}
	
	/// @desc Gets the distance to another wPoint, accounting for screenwraps
	/// @param {Struct.wPoint} _wPoint Point to check
	/// @return Struct containing X and Y distances as .x and .y respectively
	function distanceToPoint(_wPoint) {
		return distanceTo(_wPoint.getX(), _wPoint.getY())
	}
}

/// @desc Determine whether two objects are touching, accounting for screenwrapping
///	Returns whether they are contacting and the distance along the X and Y axes
/// @param obj1 The first object
/// @param obj2 The second object
/// @param x1Change (Optional) Considers obj1 to be offset by this amount
/// @param y1Change (Optional) Considers obj1 to be offset by this amount
function checkContacting(obj1, obj2, x1Change = 0, y1Change = 0) {
	var obj1_center = new wPoint(obj1.x + x1Change, obj1.y + y1Change)
	var obj2_center = new wPoint(obj2.x, obj2.y)
	
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
	var obj1_spr_width = obj1.sprite_index.bbox_right - obj1.sprite_index.bbox_left
	var obj2_spr_width = obj2.sprite_index.bbox_right - obj2.sprite_index.bbox_left
	var obj1_spr_height = obj1.sprite_index.bbox_bottom - obj1.sprite_index.bbox_top
	var obj2_spr_height = obj2.sprite_index.bbox_bottom - obj2.sprite_index.bbox_top
	
	contact.hit = (
		abs(dist.x) <= obj1_spr_width + obj2_spr_width
		&& abs(dist.y) <= obj1_spr_height + obj2_spr_height
	)
	
	return contact
}

function checkValidMove(obj, collisions, _x, _y) {
	var isValid = true
	
	for (var i = 0; i < array_length(collisions); i++) {
		var compare = collisions[i]
		
		var contact = checkContacting(obj, compare, _x, _y)
		
		if (contact.hit) {
			isValid = false
		}
	}
	
	return isValid
}