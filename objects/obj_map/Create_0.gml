depth -= 999



function get_spawn_coords_by_room(_room = room) {
	switch(_room) {
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
		default:						return [160, 480];
	}
}