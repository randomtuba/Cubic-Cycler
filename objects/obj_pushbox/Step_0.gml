var _grounded = place_meeting(x, y+2, collisions)
var _grounded2 = place_meeting(x, y-2, collisions)

if (_grounded) {
	y_speed = 0
} else if (_grounded2) {
	y_speed = 1
} else {
	y_speed += 0.4
}

x_speed *= 0.9
y_speed *= 0.97

move_and_collide(x_speed, y_speed, collisions);

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

if (instance_exists(rider) && rider.y_speed >= 0) {
	rider.move_and_collide_with_faux(0, 50, rider.collisions);
	//rider.y -= y_speed;
	//rider.y_speed = y_speed+2;
	//rider.y = bbox_top + 1 - rider.sprite_height/2;
}