var _no_back = (room == rm_mainmenu || room == rm_controls);

if (_no_back || !global.use_background) {
	draw_set_colour(_no_back ? c_black : make_colour_rgb(131, 175, 178));
	draw_rectangle(0, 0, room_width-1, room_height-1, false);
} else {
	if (view_current == 0) {
		draw_sprite_tiled_ext(
			spr_background, // Sprite
			0, // Frame
			0, // X
			0, // Y
			global.background_scale, // X Scale
			global.background_scale, // Y Scale
			c_white, // Color
			1 // Alpha
		)
	}
}

draw_set_color(c_white);

global.camera_3d_progress = lerp(global.camera_3d_progress, global.camera_3d_for_act3, 0.05);
if (global.camera_3d_progress != camera_3d_progress_prev) { update_camera_3d(); }
camera_3d_progress_prev = global.camera_3d_progress;


if (global.camera_3d_progress > 0 || keyboard_check_pressed(ord("E"))) {
	var tile_layer_id = layer_tilemap_get_id("Tiles_1");
	for (var tx=0; tx<tilemap_get_width(tile_layer_id); tx++) {
		for (var ty=0; ty<tilemap_get_height(tile_layer_id); ty++) {
			var tile_data = tilemap_get(tile_layer_id, tx, ty);
			var tile_index = tile_get_index(tile_data);
			//var coll = collision_rectangle(tx*32, (ty-5*camera_3d_depth_ratio*0.8)*32, (tx+1)*32, (ty-3*camera_3d_depth_ratio*0.8)*32+4, [obj_checkpoint, obj_spring, obj_spikes], false, true);
			//var coll2 = collision_rectangle(tx*32, (ty+1-5*camera_3d_depth_ratio*0.8)*32, (tx+1)*32, (ty+1-3*camera_3d_depth_ratio*0.8)*32+4, [obj_checkpoint, obj_spring, obj_spikes], false, true);
			if ((0 < tile_index  && tile_index  <= 12) || tile_index == 49 || tile_index == 53/* || (coll != noone && coll2 == noone && coll.image_angle = 0)*/) {
				//draw_circle(tx*32, ty*32, 5, true);
				draw_sprite_ext(spr_block_top_only, 0, tx*32, (ty-2*global.camera_3d_progress*camera_3d_depth_ratio*2*0.8)*32, 1, 2*global.camera_3d_progress*camera_3d_depth_ratio*0.8, 0, c_white, 1);
				draw_sprite_ext(spr_block_top_only, 0, tx*32, (ty-2*global.camera_3d_progress*camera_3d_depth_ratio*0.8)*32, 1, 2*global.camera_3d_progress*camera_3d_depth_ratio*0.8, 0, c_white, 1);
			}
		}
	}
	
	
	if (instance_exists(obj_cubert)) {
		var _cub = instance_nearest(x, y, obj_cubert);
		var depth_count_3d = floor(room_height/global.cam_size[1]);
		//draw_set_color(c_lime);
		//draw_set_alpha(0.4);
		global.camera_3d_cubert_depth_k = lerp(global.camera_3d_cubert_depth_k, global.camera_3d_cubert_depth, 0.3);
		for (var i=0; i<depth_count_3d; i++) {
			if (i*global.cam_size[1] < _cub.pos.point.getY() && _cub.pos.point.getY()  < (i+1)*global.cam_size[1]) {
				global.camera_3d_cubert_depth = i;
				camera_set_view_pos(view_camera[7], 0, i*global.cam_size[1]);
			}
			//my id is i
			//white screen id is k
			//distance between i and k -> the bigger it is, the closer is to black
			//var d = clamp(abs(i-global.camera_3d_cubert_depth_k), 0, 2)
			//draw_set_alpha(d*0.4);
			//if (i == global.camera_3d_cubert_depth_k) { continue; } 
			//draw_rectangle(0, i*global.cam_size[1], room_width, (i+1)*global.cam_size[1], false);
		}
		//draw_set_alpha(1);
		//draw_set_color(c_white);
	}
}

if (keyboard_check_pressed(vk_f2)) { room_goto(rm3_test); }



//disabled to set elsewhere
//for (var i=0; i<4; i++) {
//	view_visible[i+1] = (should_screenwrap())
//}
