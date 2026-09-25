#macro sec game_get_speed(gamespeed_fps)
randomize()

depth += 100;

// fullscreen option
fullscreen = false

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
global.level_x = 2
global.level_y = 1
global.level_map = [
[-1, -1, -1, rm_spikes],
[rm_spring_boost, rm_pushbox_intro, rm_start, rm_spring_intro],
[rm_climb, rm_pushbox_fall, rm_spring_box, rm_spring_hard],
[-1, rm_fragile_blocks, rm_doubledown, rm_awkward],
]
// rm_awkward

global.generators_destroyed_map = []

//fill it with falses at the start of the game
for (var i=0; i<array_length(global.level_map); i++) {
	array_push(global.generators_destroyed_map, []);
	for (var j=0; j<array_length(global.level_map[0]); j++) {
		array_push(global.generators_destroyed_map[i], false);
	}
}

// stores checkpoint data
global.checkpoint_id = -1
global.checkpoint_x = room_width/2
global.checkpoint_y = room_height/2
global.checkpoint_room = rm_template
global.checkpoint_level_x = 2
global.checkpoint_level_y = 1