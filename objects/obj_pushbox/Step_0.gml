
var groundCheck = checkGrounded(self, shredding ? [] : collisions, 5)
var _grounded = !groundCheck.valid

runEventsAndGrounded(groundCheck.blockers)

// Gravity
if (!_grounded || shredding) {
	var _g = 0.4
	pos.x_speed += _g * dcos(gravity_direction);
	pos.y_speed -= _g * dsin(gravity_direction);
}

if (shredding) {
	pos.wraps = false;
	pos.move(pos.x_speed, pos.y_speed, false);
	return;
}


// Movement
var motion = pos.getMotion()
var mov_x_spd = am_i_in_view(pos.point.getX(), pos.point.getY()) ? motion.x : 0;
var mov_y_spd = am_i_in_view(pos.point.getX(), pos.point.getY()) ? motion.y : 0;
var movement = attemptMoveInSteps(self, collisions, mov_x_spd, mov_y_spd, 4, wraps&&should_screenwrap())

// Don't reset speed when pushing a box
// "d" is a direction
for (var d = 0; d < 5; d++) {
	var set = movement.blockers[d]
	for (var i = 0; i < array_length(set); i++) {
		var obj = set[i]
		if (instance_exists(obj) && obj.object_index == obj_pushbox) {
			if (d == Direction.Left || d == Direction.Right) { movement.x = true }
			else if (d == Direction.Up || d == Direction.Down) { movement.y = true }
		}
	}
}
movement.x = true;
movement.y = true;

// Reset speed if blocked
if (!movement.x) { pos.x_speed = 0 }
if (!movement.y) { pos.y_speed = 0 }

runBlockerEvents(movement.blockers)