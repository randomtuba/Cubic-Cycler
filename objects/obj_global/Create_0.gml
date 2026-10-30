#region Macros

#macro sec game_get_speed(gamespeed_fps)

#macro COLLISION_UPDATE_LISTENERS [obj_cubert, obj_pushbox, obj_moving_platform]
#macro FREELY_MOVABLE_OBJECTS [obj_cubert, obj_pushbox]
#macro HAVE_CONTACT_BEHAVIOUR [obj_spring, obj_button, obj_button_cubert, obj_checkpoint, obj_generator, obj_spikes, obj_spikeball, obj_spike_low]
#macro HAVE_GROUNDED_BEHAVIOUR [obj_conveyor, obj_moving_platform]
#macro HAVE_BLOCKER_BEHAVIOUR [obj_pushbox, obj_block_fragile]

#endregion Macros

randomize()

depth += 100;
timer = 0;

#region Variables

global.debug = true;
global.minimap = true;
global.gamepad = false;

global.camera_follows_player_for_act2 = false;
global.cam_size = [1024, 640];
global.pedestal = noone;
global.camera_3d_for_act3 = false;
global.camera_3d_progress = 0;
global.camera_3d_cubert_depth = 0;
global.camera_3d_cubert_depth_k = 0;
camera_3d_progress_prev = 0;
camera_3d_depth_ratio = 0.25;

global.use_background = true
global.background_scale = 2

// stores the position of the player
global.default_x = 0
global.default_y = 0
global.actsaved = 0
// platformer physics quality of life
global.coyote_time = 5
global.input_buffer_time = 5

// Conveyors and Tractor Beams
global.conveyor_speed = 5
global.tractor_strength = 0.5

// stores the map layout and current room
global.level_x = 0
global.level_y = 0

// is screen wrap active for act 2?
global.pedestal_active = true

global.tutorial_map = [
	[rm_tut_top_left, rm_tut_top_right],
	[rm_tut_bottom_left, rm_tut_bottom_right],
]

global.act1_map = [
	[rm_tesseract_1, rm_pushbox_and_fragile, rm_many_buttons, rm_spikes],
	[rm_spring_boost, rm_pushbox_intro, rm_start, rm_spring_intro],
	[rm_climb, rm_pushbox_fall, rm_spring_box, rm_spring_hard],
	[rm_fall, rm_fragile_blocks, rm_doubledown, rm_awkward],
]

global.act2_map = [
	[rm2_camera_intro, rm2_dubious],
	[rm2_dubious, rm2_central],
]

// stores current act
global.act = 0

global.generators_destroyed_map = []

//fill it with falses at the start of the game
var _map = get_level_map();
for (var i=0; i<array_length(_map); i++) {
	array_push(global.generators_destroyed_map, []);
	for (var j=0; j<array_length(_map[0]); j++) {
		array_push(global.generators_destroyed_map[i], false);
	}
}

global.kleinbottles_collected = []

// stores checkpoint data
if (!checkpoint_read_file()) {
    global.checkpoint_id = -1
	global.checkpoint_x = room_width/2
	global.checkpoint_y = room_height/2
	global.checkpoint_room = rm_tut_top_left
	global.checkpoint_level_x = 0
	global.checkpoint_level_y = 0
}


#endregion Variables

#region Enums

enum MovingPlatformType {
	Bounce,
	Stationary
}

enum Direction {
	Up,
	Down,
	Left,
	Right,
	Yolo,
	None
}


#endregion Enums

#region Functions

function update_camera_3d() {
	var depth_count_3d = floor(room_height / global.cam_size[1]); //1, 2, 3, ...
	var y_increase_due_depth = sprite_get_height(spr_block_top_only)*camera_3d_depth_ratio;
	var p = global.camera_3d_progress;
	
	//var view_vertical_off = global.cam_size[1] + 8*floor(depth_count_3d*y_increase_due_depth*p/8)
	window_set_size(global.cam_size[0], global.cam_size[1] + p*(depth_count_3d-1)*y_increase_due_depth);//+ 8*floor((depth_count_3d-1)*y_increase_due_depth*p/8)
		
	view_enabled = true;
	
	for (var i=0; i<depth_count_3d; i++) {
		camera_set_view_pos(view_camera[i], 0, i*global.cam_size[1]);
		camera_set_view_size(view_camera[i], global.cam_size[0], global.cam_size[1]);
		view_visible[i] = true;
		view_xport[i] = 0;
		view_yport[i] = p*i*y_increase_due_depth//4 * 8 * floor (i * y_increase_due_depth * p / 8);
		view_wport[i] = global.cam_size[0];
		view_hport[i] = global.cam_size[1] + p*i*y_increase_due_depth;
	}
	for (var i=depth_count_3d; i<7; i++) { view_visible[i] = false; }
		
	//set this as whichever one cubert is in (instant)
	//if (!instant_interpolate_collision) {
	//	camera_set_view_pos(view_camera[7], x_off, y_off);
	//	camera_set_view_size(view_camera[7], camera_size[0], camera_size[1]);
	//}
}

function update_camera(camera_size = [1024, 640], follow_allowed = false, follow_object = noone, follow_interpolate = 1, instant_interpolate_collision = false) {
	//camera_size[] is how much the camera can see of the room, regardless of room size
	//x_off and y_off are target positions for camera
	view_enabled = true;
	view_visible[0] = true;
	view_visible[7] = false;
	
	var x_off = 0;
	var y_off = 0;
	if (follow_allowed) {
		if (!instance_exists(follow_object)) { follow_object = instance_nearest(x, y, obj_cubert); }
		if (instance_exists(follow_object)) {
			var _x = follow_object.x;
			var _y = follow_object.y;
			if (follow_object.object_index == obj_pedestal) {
				_x = follow_object.camera_x_coord_left;
				_y = follow_object.camera_y_coord_top;
			}
			x_off = clamp(_x - camera_size[0]/2, 0, room_width - camera_size[0]);
			y_off = clamp(_y - camera_size[1]/2, 0, room_height - camera_size[1]);
			
			if (instant_interpolate_collision) {
				camera_set_view_pos(view_camera[7], x_off, y_off);
				camera_set_view_size(view_camera[7], camera_size[0], camera_size[1]);
			}
			
			x_off = lerp(camera_get_view_x(view_camera[0]), x_off, follow_interpolate);
			y_off = lerp(camera_get_view_y(view_camera[0]), y_off, follow_interpolate);
		}
	}
	
	camera_set_view_pos(view_camera[0], x_off, y_off);
	camera_set_view_size(view_camera[0], camera_size[0], camera_size[1]);
	if (!instant_interpolate_collision) {
		camera_set_view_pos(view_camera[7], x_off, y_off);
		camera_set_view_size(view_camera[7], camera_size[0], camera_size[1]);
	}
	view_xport[0] = 0;
	view_yport[0] = 0;
	view_wport[0] = camera_size[0];
	view_hport[0] = camera_size[1];
	
	//commented so now we only use camera0
	//if (!follow_allowed) {
	//	var c=0;
	//	for (var i=-1; i<2; i++) {
	//		for (var j=-1; j<2; j++) {
	//			if ((i!=0 && j!=0) || (i==0 && j==0)) { continue; }
	//			c++;
	//			view_visible[c] = true;
	//			camera_set_view_pos(view_camera[c], x_off + i*camera_size[0], y_off + j*camera_size[1]);
	//			camera_set_view_size(view_camera[c], camera_size[0], camera_size[1]);
	//			view_wport[c] = camera_size[0];
	//			view_hport[c] = camera_size[1];
	//			view_xport[c] = 0;
	//			view_yport[c] = 0;
	//		}
	//	}
	//} else {
	//	for (var c=2; c<9; c++) { view_visible[c] = false; }
		
	//}
}



function send_collision_updates() {
	for (i = 0; i < array_length(COLLISION_UPDATE_LISTENERS); i++) {
		with (COLLISION_UPDATE_LISTENERS[i]) {
			update_collisions()
		}
	}
}

function get_active_collisions(include_cubert = false) {
	// Always active
	var collisions = [
		layer_tilemap_get_id("Tiles_1"),
		obj_block_fragile,
		obj_pushbox,
		obj_conveyor,
		obj_moving_platform
	];
	with obj_switch_block {
		if is_on { array_push(collisions, self) }
	}
	with obj_generator_number_switch {
		if is_on { array_push(collisions, self) }
	}
	if (include_cubert) {
		with obj_cubert { array_push(collisions, self) }
	}
	
	return collisions
}

#endregion Functions
