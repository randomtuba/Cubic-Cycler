depth -= 999
enabled = false;
enable_k = 0;


function get_spawn_coords_by_room(_room = room) {
	switch(_room) {
		//tutorial
		//
		//act1
		case rm_start:					return [160, 480];
		case rm_spring_intro:			return [128, 480];
		case rm_pushbox_intro:			return [928, 480];
		case rm_spring_boost:			return [736, 352];
		case rm_spikes:					return [256, 416];
		case rm_pushbox_fall:			return [512, 64];
		case rm_spring_box:				return [128, 480];
		case rm_climb:					return [640, 384];
		case rm_spring_hard:			return [128, 480];
		case rm_fall:					return [480, 64];
		case rm_fragile_blocks:			return [448, 0];
		case rm_doubledown:				return [448, 32];
		case rm_many_buttons:			return [864, 320];
		case rm_awkward:				return [576, 0];
		case rm_pushbox_and_fragile:	return [960, 288];
		//
		default:						return [160, 480];
	}
}

function get_room_thumb(_room = room) {
	switch(_room) {
		//tutorial
		case rm_tut_top_left:			return rmspr_tut_top_left_1;
		case rm_tut_top_right:			return rmspr_tut_top_right_1;
		case rm_tut_bottom_left:		return rmspr_tut_bottom_left_1;
		case rm_tut_bottom_right:		return rmspr_tut_bottom_right_1;
		//act1
		case rm_awkward:				return rmspr_awkward;
		case rm_climb:					return rmspr_climb;
		case rm_doubledown:				return rmspr_doubledown;
		case rm_fall:					return rmspr_fall;
		//
		default:						return -1;
	}
}


function draw_rectangle_thick_outline(x1, y1, x2, y2, thickness, outer = false) {
	if (outer) { x1 -= thickness; y1 -= thickness; x2 += thickness; y2 += thickness; }
	draw_rectangle(x1, y1, x1+thickness, y2, false);
	draw_rectangle(x1, y1, x2, y1+thickness, false);
	draw_rectangle(x2-thickness, y1, x2, y2, false);
	draw_rectangle(x1, y2-thickness, x2, y2, false);
}