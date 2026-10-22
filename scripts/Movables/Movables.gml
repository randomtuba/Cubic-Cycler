/// @desc Struct for tracking position and related variables of movable objects
/// Note: Directly modifying "point" may lead to strange behaviour, use move() and setPos()
/// @param {Real} _x Starting X coordinate
/// @param {Real} _y Starting Y coordinate
/// @param {Real} _xdrag Multiplier applied to X speed every step
/// @param {Real} _ydrag Multiplier applied to Y speed every step
/// @param {Id.Instance} _parent Reference to parent object
function Position(_x, _y, _xdrag, _ydrag, _parent) constructor {
	parent = _parent
	
	point = new wPoint(_x, _y)

	x_speed = 0
	y_speed = 0
	x_this_frame = 0
	y_this_frame = 0
	x_drag = _xdrag
	y_drag = _ydrag
	
	hit_right_conveyor = false
	hit_left_conveyor = false
	
	hit_tractors = [false, false, false, false, false]
	
	/// @desc Returns the current X and Y motion
	function getMotion() {
		return {
			x : x_speed + x_this_frame,
			y : y_speed + y_this_frame
		}
	}
	
	/// @desc Moves some distance
	/// @param {Real} _x The X distance
	/// @param {Real} _y The Y distance
	/// @param {Bool} wraps (Optional) Whether to screenwrap or not, default true
	function move(_x, _y, wraps = true) {
		point.setX(point.getX() + _x, wraps)
		point.setY(point.getY() + _y, wraps)
		
		updateParent()
	}
	
	/// @desc Sets the position
	/// @param {Real} _x The X position
	/// @param {Real} _y The Y position
	function setPos(_x, _y) {
		point.setX(_x)
		point.setY(_y)
		
		updateParent()
	}
	
	/// @desc Updates the parent's X and Y coordinates
	function updateParent() {
		parent.x = point.getX()
		parent.y = point.getY()
	}
	
	/// @desc Runs all code that should be run at step end
	function end_step() {
		x_speed *= x_drag
		y_speed *= y_drag
		
		x_this_frame = 0
		y_this_frame = 0
		
		hit_right_conveyor = false
		hit_left_conveyor = false
		
		hit_tractors = [false, false, false, false, false]
	}
}