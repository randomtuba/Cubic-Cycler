var _grounded = place_meeting(x, y + 2, collisions)

var _grounded2 = place_meeting(x, y - 2, collisions)

if (_grounded and touchspring == 0) {
	y_speed = 0
} else if (_grounded and touchspring == 1){
	touchspring = 0
} else if (_grounded2) {
	y_speed = 1
} else {
	y_speed += 0.4
}

x_speed *= 0.9
y_speed *= 0.97

//conveyer should move block - zach
var _conveyor = instance_place(x, y + 2, obj_conveyor);

if (_conveyor != noone) {
    x_speed += _conveyor.points_right ? 0.5 : -0.5;
}

move_and_collide(x_speed, y_speed, collisions);

//x_this_frame += x_speed
//y_this_frame += y_speed
//move_and_collide_with_faux(x_this_frame, y_this_frame, collisions)
//x_this_frame = 0
//y_this_frame = 0

if (place_meeting(x, y, obj_cubert)) { 
	if (obj_cubert.y < y) {x = xprevious; y = yprevious; y_speed = 0;}
}
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

if (instance_exists(rider) && rider.y_speed >= 0 && abs(rider.x - x) < 58) {
	rider.move_and_collide_with_faux(0, 50, rider.collisions, 32, false, false);
	//rider.y -= y_speed;
	//rider.y_speed = y_speed+2;
	//rider.y = bbox_top + 1 - rider.sprite_height/2;
}
#region Tractor Beams

if (touching_up_tractor && !touching_down_tractor) {
	y_speed -= global.tractor_strength
} else if (touching_down_tractor && !touching_up_tractor) {
	y_speed += global.tractor_strength
}

if (touching_right_tractor && !touching_left_tractor) {
	x_speed += global.tractor_strength
} else if (touching_left_tractor && !touching_right_tractor) {
	x_speed -= global.tractor_strength
}

touching_up_tractor = false
touching_down_tractor = false
touching_right_tractor = false
touching_left_tractor = false