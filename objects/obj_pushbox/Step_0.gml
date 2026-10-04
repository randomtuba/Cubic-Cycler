
var groundCheck = checkGrounded(self, collisions)
var _grounded = !groundCheck.valid

runEvents(getContacting(self, HAVE_CONTACT_BEHAVIOUR))
runEvents(groundCheck.blockers)

if (_grounded and touchspring == 0) {
	pos.y_speed = 0
} else if (_grounded and touchspring == 1){
	touchspring = 0
} else {
	pos.y_speed += 0.4
}


//move_and_collide(x_speed, y_speed, collisions);
var motion = pos.getMotion()
var movement = attemptMove(self, collisions, motion.x, motion.y, 4, instance_exists(obj_generator))
if (!movement.x) {
	pos.x_speed = 0
}
if (!movement.y) {
	pos.y_speed = 0
}


var box_or_fake_box_find_cubert = false;
var box_or_fake_box_find_cubert_i = 0;
var box_or_fake_box_find_cubert_j = 0;
for (var i=-1; i<2; i++) {
	for (var j=-1; j<2; j++) {
		if (place_meeting(x+i*room_width, y+j*room_height, obj_cubert)) {
			box_or_fake_box_find_cubert_i = i;
			box_or_fake_box_find_cubert_j = j;
			box_or_fake_box_find_cubert = true;
			break;
		}
	}
	if (box_or_fake_box_find_cubert) { break; }
}

if (box_or_fake_box_find_cubert) { 
	if (obj_cubert.y > y+room_height*box_or_fake_box_find_cubert_j) { x = xprevious; y = yprevious; y_speed = 0; }
}
/*
if (instance_exists(obj_generator)) {
	// Horizontal
	if (x > room_width) {
	    x = 0
	    if (place_meeting(x, y, collisions)) x = room_width
	} else if (x < 0) {
	    x = room_width
	    if (place_meeting(x, y, collisions)) x = 0
	}

	// Vertical
	if (y > room_height) {
	    y = 0
	    if (place_meeting(x, y, collisions)) y = room_height
	} else if (y < 0) {
	    y = room_height
	    if (place_meeting(x, y, collisions)) y = 0
	}
}
*/
if (instance_exists(rider) && rider.y_speed >= 0 && abs(rider.x - x) < 58) {
	//rider.move_and_collide_with_faux(0, -24, rider.collisions, 32, false, false);
	rider.move_and_collide_with_faux(0, 50, rider.collisions, 32, false, false);
	//rider.y -= y_speed;
	//rider.y_speed = y_speed+2;
	//rider.y = bbox_top + 1 - rider.sprite_height/2;
}