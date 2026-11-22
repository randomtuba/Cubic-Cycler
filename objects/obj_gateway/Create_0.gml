depth = 10
active = false
timer = 0


function apply_interaction(obj) {    

	global.checkpoint_id       = 1;
	global.checkpoint_x        = obj.pos.point.getX();
	global.checkpoint_y        = obj.pos.point.getY();
	global.checkpoint_room = room
	global.checkpoint_level_x = global.level_x
	global.checkpoint_level_y = global.level_y
	global.checkpoint_level_gravity = -90;

	checkpoint_write_file();
}