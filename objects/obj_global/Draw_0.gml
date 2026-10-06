var _no_back = (room == rm_mainmenu || room == rm_controls);
draw_set_colour(_no_back ? c_black : make_colour_rgb(131, 175, 178));
draw_rectangle(0, 0, room_width-1, room_height-1, false);
draw_set_color(c_white);

for (var i=0; i<4; i++) { view_visible[i+1] = (instance_exists(obj_generator)) }

if (keyboard_check_pressed(vk_f3)) { global.debug = !global.debug; }