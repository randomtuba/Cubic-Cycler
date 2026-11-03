// main vars
depth = -999
pos = new Position(x, y, 0.90, 0.99, self)
global.checkpoint_level_gravity = 0;
rotation = 0;
x_scale = 0.5;
collisions = []; update_collisions();
immobile = false

// lose state
lose_state = false
lose_timer = 0

// quality of life vars
coyote_time = 0
jump_buffer = 0
jump_cooldown = 0
springyspring = 0
springxspring = 0

// Landing "bouncy" vfx
jump_k = 0;
jump_j_max = sec;
bounciness = 10;
was_grounded = false

checkpoint_read_file();

function restart() {
	
	checkpoint_read_file();
	show_debug_message("===== CUBERT DEATH =====");
	show_debug_message("X: " + string(x));
	show_debug_message("Y: " + string(y));
	show_debug_message("RESTART CALLED");
	show_debug_message("checkpoint_id = " + string(global.checkpoint_id));
		show_debug_message("Room: " + string(global.checkpoint_room));
		show_debug_message("Level X: " + string(global.checkpoint_level_x));
		show_debug_message("Level Y: " + string(global.checkpoint_level_y));
		show_debug_message("Player X: " + string(global.checkpoint_x));
		show_debug_message("Player Y: " + string(global.checkpoint_y));
		show_debug_message("Gravity: " + string(global.checkpoint_level_gravity));
	if (global.checkpoint_id == -1) {
		if (global.act == 1) {
			room_goto(rm_start)
			global.level_x = 2
			global.level_y = 1
			pos.setPos(64, 480)
			
		} else if (global.act == 2) {
			
			room_goto(rm2_camera_intro)
			global.level_x = 0
			global.level_y = 0
			pos.setPos(64, 480)
			
		} else {
			
			room_goto(rm_tut_top_left)
			global.level_x = 0
			global.level_y = 0
			pos.setPos(128, 480)
		}
	} else {
		if (global.actsaved != global.act) {
			actPlus()
		}	
		
		room_goto(global.checkpoint_room)
		global.level_x = global.checkpoint_level_x
		global.level_y = global.checkpoint_level_y
		if(global.act == 2){
			pos.setPos(global.checkpoint_x, global.checkpoint_y,false);
		}
		else{
			pos.setPos(global.checkpoint_x, global.checkpoint_y)
			}
		gravity_direction = global.checkpoint_level_gravity;
		//update_camera(global.cam_size, true, self, 1, true);
	}
	pos.x_speed = 0
	pos.y_speed = 0
	
}

function update_collisions() {
	with (obj_global) { other.collisions = get_active_collisions() }
}

function room_index_bounded(_i = global.level_x, _j = global.level_y) {
	var _map = get_level_map();
	//return true
	return (_j >= 0) && (_j < array_length(_map)) &&
		(_i >= 0) && (_i < array_length(_map[0])) &&
		_map[_j][_i] != -1
}


	
