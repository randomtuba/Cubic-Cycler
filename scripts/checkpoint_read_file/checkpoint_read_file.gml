function checkpoint_read_file() {
    var _path = game_save_id + "checkpoint.json";

    if (!file_exists(_path)) return false;
	
    var _file = file_text_open_read(_path);
    var _json = file_text_read_string(_file);  
    file_text_close(_file);
	

    var _data = json_parse(_json);
	global.actsaved = _data.act;
    global.checkpoint_id = _data.id;
    global.checkpoint_room = _data.room;
    global.checkpoint_level_x = _data.level_x;
    global.checkpoint_level_y = _data.level_y;
    global.checkpoint_x = _data.x;
    global.checkpoint_y = _data.y;
	
	
	show_debug_message("check");

	
	show_debug_message($"read_id={global.checkpoint_id}, act={global.actsaved}, room={global.checkpoint_room}, lx={global.checkpoint_level_x}, ly={global.checkpoint_level_y}, x={global.checkpoint_x}, y={global.checkpoint_y}");
    return true;
}