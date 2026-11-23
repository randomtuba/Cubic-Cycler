function checkpoint_read_file(_savefile = global.savefile) {
	var _path = game_save_id + "checkpoint"+string(_savefile)+".json";

	if (!file_exists(_path)) return false;

	var _file = file_text_open_read(_path);
	var _json = file_text_read_string(_file);
	file_text_close(_file);

	var _data = json_parse(_json);
	global.actsaved = variable_struct_exists(_data, "act") ? _data.act : 0;
	global.checkpoint_id = variable_struct_exists(_data, "id") ? _data.id : -1;
	global.checkpoint_room = variable_struct_exists(_data, "room") ? _data.room : rm_tut_top_left;
	global.checkpoint_level_x = variable_struct_exists(_data, "level_x") ? _data.level_x : 0;
	global.checkpoint_level_y = variable_struct_exists(_data, "level_y") ? _data.level_y : 0;
	global.checkpoint_x = variable_struct_exists(_data, "x") ? _data.x : 0;
	global.checkpoint_y = variable_struct_exists(_data, "y") ? _data.y : 0;
	global.checkpoint_level_gravity = variable_struct_exists(_data, "gravity") ? _data.gravity : 270;

	// held here until checkpoint_restore_progress() is called
	global.checkpoint_progress = {
		generators: variable_struct_exists(_data, "generators") ? _data.generators : undefined,
		explored: variable_struct_exists(_data, "explored") ? _data.explored : undefined,
		kleinbottles: variable_struct_exists(_data, "kleinbottles") ? _data.kleinbottles : undefined,
		tesseracts: variable_struct_exists(_data, "tesseracts") ? _data.tesseracts : undefined
	};

	return true;
}

// load act progress
function checkpoint_restore_progress() {
	if (!variable_global_exists("checkpoint_progress")) return
	var _p = global.checkpoint_progress
	if (!is_undefined(_p.generators)) global.generators_destroyed_map = _p.generators
	if (!is_undefined(_p.explored)) global.room_explored_map = _p.explored
	if (!is_undefined(_p.kleinbottles)) global.kleinbottles_collected = _p.kleinbottles
	if (!is_undefined(_p.tesseracts)) global.tesseracts = _p.tesseracts
}

// wipes all progress on the creation of a new game
function checkpoint_reset_progress() {
	global.generators_destroyed_map = []
	for (var i = 0; i < array_length(global.tutorial_map); i++) {
		array_push(global.generators_destroyed_map, array_create(array_length(global.tutorial_map[0]), false))
	}
	global.room_explored_map = []
	for (var i = 0; i < array_length(global.act2_map); i++) {
		array_push(global.room_explored_map, array_create(array_length(global.act2_map[0]), false))
	}
	global.kleinbottles_collected = []
	global.tesseracts = [[],[false,false,false,false]]
}