function checkpoint_write_file() {
    var _data = {
		act: global.act,
        id: global.checkpoint_id,
        room: global.checkpoint_room,
        level_x: global.checkpoint_level_x,
        level_y: global.checkpoint_level_y,
        x: global.checkpoint_x,
        y: global.checkpoint_y
    };

    var _json = json_stringify(_data);
    var _path = game_save_id + "checkpoint.json";

    var _file = file_text_open_write(_path);

	show_debug_message(game_save_id + "checkpoint.json");
	show_debug_message(string(file_exists(game_save_id + "checkpoint.json")));
    file_text_write_string(_file, _json); 
    file_text_close(_file);
}