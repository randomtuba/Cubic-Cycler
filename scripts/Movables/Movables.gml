/// @desc Struct for tracking position and related variables of movable objects
/// @param {Real} _x Starting X coordinate
/// @param {Real} _y Starting Y coordinate
/// @param {Id.Instance} _parent Reference to parent object
function Position(_x, _y, _parent) constructor {
	parent = _parent
	
	point = new wPoint(_x, _y)

	x_speed = 0
	y_speed = 0
	x_this_frame = 0
	y_this_frame = 0
	
	hit_right_conveyor = false
	hit_left_conveyor = false
	
	hit_up_tractor = false
	hit_down_tractor = false
	hit_right_tractor = false
	hit_left_tractor = false
	
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
	
	/// @desc Updates the parent's X and Y coordinates
	function updateParent() {
		parent.x = point.getX()
		parent.y = point.getY()
	}
	
	/// @desc Resets all variables that should be reset at the end of the frame
	function reset_frame_vars() {
		x_this_frame = 0
		y_this_frame = 0
		
		hit_right_conveyor = false
		hit_left_conveyor = false
		
		hit_up_tractor = false
		hit_down_tractor = false
		hit_right_tractor = false
		hit_left_tractor = false
	}
}