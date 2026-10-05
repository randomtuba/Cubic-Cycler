
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
if (!movement.x) {
	pos.x_speed = 0
}
if (!movement.y) {
	pos.y_speed = 0
}
