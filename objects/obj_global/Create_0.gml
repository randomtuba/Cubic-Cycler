#region Macros

#macro sec game_get_speed(gamespeed_fps)

#macro COLLISION_UPDATE_LISTENERS [obj_cubert, obj_pushbox, obj_moving_platform]
#macro FREELY_MOVABLE_OBJECTS [obj_cubert, obj_pushbox]
#macro HAVE_CONTACT_BEHAVIOUR [obj_spring, obj_button, obj_button_cubert, obj_checkpoint, obj_generator, obj_spikes, obj_spikeball]
#macro HAVE_GROUNDED_BEHAVIOUR [obj_conveyor, obj_moving_platform]
#macro HAVE_BLOCKER_BEHAVIOUR [obj_pushbox, obj_block_fragile]

#endregion Macros

randomize()

depth += 100;

#region Variables

global.debug = true;

global.use_background = true
global.background_scale = 2

// stores the position of the player
global.default_x = 0
global.default_y = 0

// platformer physics quality of life
global.coyote_time = 5
global.input_buffer_time = 5

// Conveyors and Tractor Beams
global.conveyor_speed = 5
global.tractor_strength = 0.5

// stores the map layout and current room
global.level_x = 0
global.level_y = 0

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

// stores current act
global.act = 0

global.generators_destroyed_map = []

//fill it with falses at the start of the game
_map = get_level_map();
for (var i=0; i<array_length(_map); i++) {
	array_push(global.generators_destroyed_map, []);
	for (var j=0; j<array_length(_map[0]); j++) {
		array_push(global.generators_destroyed_map[i], false);
	}
}

global.kleinbottles_collected = []

// stores checkpoint data
global.checkpoint_id = -1
global.checkpoint_x = room_width/2
global.checkpoint_y = room_height/2
global.checkpoint_room = rm_tut_top_left
global.checkpoint_level_x = 0
global.checkpoint_level_y = 0

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
		if is_on {
			array_push(collisions, self)
		}
	}
	with obj_door {
		if !is_open {
			array_push(collisions, self)
		}
	}
	if (include_cubert) {
		with obj_cubert {
			array_push(collisions, self)
		}
	}
	
	return collisions
}

#endregion Functions
