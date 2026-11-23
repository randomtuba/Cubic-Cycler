function checkpoint_write_file(_savefile = global.savefile) {
	global.actsaved = global.act;

	var _data = {
		act: global.act,
		id: global.checkpoint_id,
		room: global.checkpoint_room,
		level_x: global.checkpoint_level_x,
		level_y: global.checkpoint_level_y,
		x: global.checkpoint_x,
		y: global.checkpoint_y,
		gravity: global.checkpoint_level_gravity,
		generators: global.generators_destroyed_map,
		explored: global.room_explored_map,
		kleinbottles: global.kleinbottles_collected,
		tesseracts: global.tesseracts,
		savefile: _savefile
	};

	var _json = json_stringify(_data);
	var _path = game_save_id + "checkpoint"+string(_savefile)+".json";

	var _file = file_text_open_write(_path);
	file_text_write_string(_file, _json);
	file_text_close(_file);
}