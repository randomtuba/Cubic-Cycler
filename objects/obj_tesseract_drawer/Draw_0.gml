timer++;

r = rad + (1.2*rad*dsin(timer/5) + 0.2*rad*cos(timer/200))*0.5;
r2 = 1.3*rad +( - rad*dcos(timer/4) + 0.4*rad*dcos(timer/160))*0.5;

ang_xz += ang_xz_spd;
ang_xy += ang_xy_spd;
ang_xz2 += ang_xz2_spd;
ang_xy2 += ang_xy2_spd;
ang_xz2_spd += angle_difference(ang_xz, ang_xz2)*0.001;
ang_xy2_spd += angle_difference(ang_xy, ang_xy2)*0.001;
ang_xz2_spd *= 0.99;
ang_xy2_spd *= 0.99;


if (keyboard_check(vk_f3)) {//debug
	draw_set_color(c_red);
	draw_line_width(x, y, x+r*dcos(ang_xy)*dcos(ang_xz), y-r*dsin(ang_xy), 2);
}

draw_set_color(c_black);
draw_tesseract();

if (keyboard_check(vk_f3)) {//debug
	draw_set_colour(c_yellow);
	draw_tessa_square();

	draw_set_color(c_white);
	draw_point(x, y);
	draw_tessa_point();

	var lr = keyboard_check(ord("L")) - keyboard_check(ord("J"));
	var ud = keyboard_check(ord("I")) - keyboard_check(ord("K"));
	ang_xz += lr;
	ang_xy += ud;

	var lr2 = keyboard_check(ord("H")) - keyboard_check(ord("F"));
	var ud2 = keyboard_check(ord("T")) - keyboard_check(ord("G"));
	ang_xz2 += lr2;
	ang_xy2 += ud2;
}
draw_set_color(c_white);