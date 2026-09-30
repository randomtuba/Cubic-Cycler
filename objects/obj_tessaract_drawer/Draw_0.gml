draw_set_color(c_red);
draw_line_width(x, y, x+r*dcos(ang_xy)*dcos(ang_xz), y-r*dsin(ang_xy), 2);

draw_set_color(c_lime);
draw_tessa_cube();
draw_tessa_cube(x, y, ang_xz2, ang_xy2, r*2);

draw_set_colour(c_yellow);
draw_tessa_square();

draw_set_color(c_white);
draw_point(x, y);//if z, it would be depth
draw_tessa_point();


var lr = keyboard_check(ord("L")) - keyboard_check(ord("J"));
var ud = keyboard_check(ord("I")) - keyboard_check(ord("K"));
ang_xz += lr;
ang_xy += ud;

var lr2 = keyboard_check(ord("H")) - keyboard_check(ord("F"));
var ud2 = keyboard_check(ord("T")) - keyboard_check(ord("G"));
ang_xz2 += lr2;
ang_xy2 += ud2;