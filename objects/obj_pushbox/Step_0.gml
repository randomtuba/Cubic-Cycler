
var groundCheck = checkGrounded(self, collisions, 5)
var _grounded = !groundCheck.valid

runEventsAndGrounded(groundCheck.blockers)

// Gravity
if (!_grounded) {
	pos.y_speed += 0.4
}

// Movement
var motion = pos.getMotion()
var movement = attemptMoveInSteps(self, collisions, motion.x, motion.y, 4, instance_exists(obj_generator))

// Don't reset speed when pushing a box
// "d" is a direction
for (var d = 0; d < 5; d++) {
	var set = movement.blockers[d]
	for (var i = 0; i < array_length(set); i++) {
		var obj = set[i]
		if (instance_exists(obj) && obj.object_index == obj_pushbox) {
			if (d == Direction.Left || d == Direction.Right) {
				movement.x = true
			} else if (d == Direction.Up || d == Direction.Down) {
				movement.y = true
			}
		}
	}
}

// Reset speed if blocked
if (!movement.x) {
	pos.x_speed = 0
}
if (!movement.y) {
	pos.y_speed = 0
}


runBlockerEvents(movement.blockers)