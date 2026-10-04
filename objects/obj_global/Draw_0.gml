draw_set_colour(make_colour_rgb(131, 175, 178));
draw_rectangle(0, 0, room_width-1, room_height-1, false);
draw_set_color(c_white);

for (var i=0; i<4; i++) { view_visible[i+1] = (instance_exists(obj_generator)) }