// main vars
x_speed = 0
y_speed = 0
rotation = 0;
//collision_map = layer_tilemap_get_id("Tiles_1")
collisions = []; update_collisions();

// lose state
lose_state = false
lose_timer = 0

// quality of life vars
coyote_time = 0
jump_buffer = 0

// cool effects
jump_k = 0;

// create visual warp cuberts
main_cubert = self;
is_main_cubert = true;
main_cubert_off_i = [0, 0];
non_main_cuberts = [];
alarm[0] = 1;

function restart() {
	if (global.checkpoint_id == -1) {
		room_goto(rm_game)
		global.level_x = 1
		global.level_y = 1
		x = 64
		y = 480
	} else {
		room_goto(global.checkpoint_room)
		global.level_x = global.checkpoint_level_x
		global.level_y = global.checkpoint_level_y
		x = global.checkpoint_x
		y = global.checkpoint_y
	}
}

function update_collisions() {
	collisions = [layer_tilemap_get_id("Tiles_1"), obj_block_fragile, obj_pushbox];
}

function room_index_bounded(_i = global.level_x, _j = global.default_y) {
	return (_j >= 0) && (_j < array_length(global.level_map)) &&
		(_i >= 0) && (_i < array_length(global.level_map[0])) &&
		global.level_map[_j][_i] != -1
}


function faux_place_meeting(_xoff, _yoff, _collisions) {
	var _touch = false;
	for (var i=0; i<array_length(non_main_cuberts); i++) {
		var q = non_main_cuberts[i];
		if (place_meeting(q.x+_xoff, q.y+_yoff, _collisions)) { _touch = true; break; }
		var _i = q.main_cubert_off_i[0];
		var _j = q.main_cubert_off_i[1];
		if (global.generators_destroyed_map[global.level_x][global.level_y] == true && !room_index_bounded(global.level_x-_i, global.level_y-_j)) {
			var _x = q.x+_xoff - abs(sprite_width/2)*_i;
			var _y = q.y+_yoff - abs(sprite_height/2)*_j;
			//draw_circle(_x, _y, 5, false); //was for debugging 
			if (2 <= _x && _x <= room_width-2 && 2 <= _y && _y <= room_height-2) { _touch = true; }
		}
	}
	//if room invalid left && my right faux cubert
	return _touch;
}


function move_and_collide_with_faux(x_speed, y_speed, _collisions, _iter = 32, reset_speeds_if_cant = true) {
	//check any of the 9 cuberts can move
	var _can_both = !place_meeting(x+x_speed, y+y_speed, _collisions) && !faux_place_meeting(x_speed, y_speed, _collisions)
	var _can_ud = !place_meeting(x, y+y_speed, _collisions) && !faux_place_meeting(0, y_speed, _collisions)
	var _can_lr = !place_meeting(x+x_speed, y, _collisions) && !faux_place_meeting(x_speed, 0, _collisions)
	
	//todo: make the 9 able to increment break timer
	if (array_contains(_collisions, obj_block_fragile)) {
		var _fragile_list = ds_list_create();
		var _fragile_count = collision_rectangle_list(x+x_speed-sprite_width/2, y+y_speed-sprite_height/2, x+x_speed+sprite_width/2, y+y_speed+sprite_height/2, obj_block_fragile, false, true, _fragile_list, false);
		for (var i=0; i<_fragile_count; i++) { _fragile_list[|i].break_timer-=1; }
		
		
		ds_list_destroy(_fragile_list);
	}
	
	//push box conditions
	if (array_contains(_collisions, obj_pushbox)) {
		var _pushbox_list = ds_list_create();
		var _pushbox_count = collision_rectangle_list(x+x_speed-sprite_width/2, y+y_speed-sprite_height/2, x+x_speed+sprite_width/2, y+y_speed+sprite_height/2, obj_pushbox, false, true, _pushbox_list, false);
		
		for (var i=0; i<_pushbox_count; i++) {
			var _box = _pushbox_list[|i];
			if (abs(y - _box.y) < 24) { _box.x_speed = x_speed / 2 }
			if (abs(x - _box.x) < 30 && y < _box.y) { _box.rider = self; _box.alarm[0] = 2; }
		}
		
		ds_list_destroy(_pushbox_list);
		
		for (var i=0; i<array_length(non_main_cuberts); i++) {
			var q = non_main_cuberts[i];
			var _faux_pushbox_list = ds_list_create();
			var _faux_pushbox_count = collision_rectangle_list(q.x+x_speed-sprite_width/2, q.y+y_speed-sprite_height/2, q.x+x_speed+sprite_width/2, q.y+y_speed+sprite_height/2, obj_pushbox, false, true, _pushbox_list, false);
			
			for (var j=0; j<_faux_pushbox_count; j++) {
				var _box = _faux_pushbox_list[|j];
				if (abs(q.y - _box.y) < 24) { _box.x_speed = x_speed / 2 }
				if (abs(q.x - _box.x) < 30 && q.y < _box.y) { _box.rider = self; _box.alarm[0] = 2; }
			}
			
			ds_list_destroy(_faux_pushbox_list);
			
		}
	}
	
	//slowly decrease percent of x_speed and y_speed until it's possible to fit
	while (_iter > 0 && (!_can_ud  || !_can_lr || (_can_lr && _can_ud && !_can_both))) {
		if (!_can_lr) { x_speed *= (_iter-1)/_iter; }
		if (!_can_ud || (_can_lr && _can_ud && !_can_both)) { y_speed *= (_iter-1)/_iter; }
		_can_both = !place_meeting(x+x_speed, y+y_speed, _collisions) && !faux_place_meeting(x_speed, y_speed, _collisions)
		_can_ud = !place_meeting(x, y+y_speed, _collisions) && !faux_place_meeting(0, y_speed, _collisions)
		_can_lr = !place_meeting(x+x_speed, y, _collisions) && !faux_place_meeting(x_speed, 0, _collisions)
		_iter--;
	}
	x += _can_lr * x_speed;
	y += _can_ud * y_speed;
	
	//clear velocity when hitting something
	if (reset_speeds_if_cant) {
		if (!_can_lr) { self.x_speed = 0 }
		if (!_can_ud) { if (self.y_speed > 1 && abs(self.jump_k) < 0.2) { self.jump_k = self.y_speed; } self.y_speed = 0}
	}
}