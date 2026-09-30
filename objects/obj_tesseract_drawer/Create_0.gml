ang_xz = 0;//from right (0deg) to out of the screen (90deg), can go full circle ofc
ang_xy = 0;//from right (0deg) to up (90deg), can go full circle ofc
ang_xz2 = 0;
ang_xy2 = 0;

rad = 32;
r = rad;
r2 = rad*2;
timer = 0;

ang_xz_spd = 4/20;
ang_xy_spd = pi/20;
ang_xz2_spd = 0;
ang_xy2_spd = 0;


function get_tessa_point(_ang_xz = ang_xz, _ang_xy = ang_xy, _r = r) {
	return [_r*dcos(_ang_xy)*dcos(_ang_xz), -_r*dsin(_ang_xy)];//if there's z it would take +r*dsin(ang_xz)
}

function draw_tessa_point(_x = x, _y = y, _ang_xz = ang_xz, _ang_xy = ang_xy, _r = r) {
	var p = get_tessa_point(_ang_xz, _ang_xy, _r);
	draw_point(_x+p[0], _y+p[1]);
	return p;
}

function draw_tessa_square(_x = x, _y = y, _ang_xz = ang_xz, _ang_xy = ang_xy, _r = r) {
	var p0 = get_tessa_point(_ang_xz, _ang_xy, _r);
	p0[0] += _x;
	p0[1] += _y;
	var p0u = get_tessa_point(_ang_xz, _ang_xy+90, _r);
	var p0d = get_tessa_point(_ang_xz, _ang_xy-90, _r);
	
	//middle cross
	//draw_line_width(p0[0] + p0u[0], p0[1] + p0u[1], p0[0] + p0d[0], p0[1] + p0d[1], 3);
	//draw_line_width(p0[0] - r*dsin(_ang_xz), p0[1], p0[0] + r*dsin(_ang_xz), p0[1], 3);
	
	//each corner
	var pul = [p0[0] + p0u[0] - _r*dsin(_ang_xz), p0[1] + p0u[1]];
	var pdl = [p0[0] + p0d[0] - _r*dsin(_ang_xz), p0[1] + p0d[1]];
	var pur = [p0[0] + p0u[0] + _r*dsin(_ang_xz), p0[1] + p0u[1]];
	var pdr = [p0[0] + p0d[0] + _r*dsin(_ang_xz), p0[1] + p0d[1]];
	
	//connect 1 to 2, 3 to 4
	draw_line_width(pul[0], pul[1], pdl[0], pdl[1], 3);
	draw_line_width(pur[0], pur[1], pdr[0], pdr[1], 3);
	
	//connect 1 to 3, 2 to 4
	draw_line_width(pul[0], pul[1], pur[0], pur[1], 3);
	draw_line_width(pdl[0], pdl[1], pdr[0], pdr[1], 3);
	
	return [pul, pdl, pur, pdr];
}

function draw_tessa_cube(_x = x, _y = y, _ang_xz = ang_xz, _ang_xy = ang_xy, _r = r) {
	var s1 = draw_tessa_square(_x, _y, _ang_xz, _ang_xy, _r);
	var s2 = draw_tessa_square(_x, _y, _ang_xz, _ang_xy+180, _r);
	
	//connect each corner
	draw_line_width(s1[0][0], s1[0][1], s2[1][0], s2[1][1], 3);
	draw_line_width(s1[1][0], s1[1][1], s2[0][0], s2[0][1], 3);
	draw_line_width(s1[2][0], s1[2][1], s2[3][0], s2[3][1], 3);
	draw_line_width(s1[3][0], s1[3][1], s2[2][0], s2[2][1], 3);
	
	return array_concat(s1, s2);
}

function draw_tesseract() {
	var t1 = draw_tessa_cube();
	var t2 = draw_tessa_cube(x, y, ang_xz2, ang_xy2, r2);
	
	//make color slightly lighter in the lines connecting the two cubes?
	//var _c = draw_get_color();
	//var _r = color_get_red(draw_get_color());
	//var _g = color_get_green(draw_get_color());
	//var _b = color_get_blue(draw_get_color());
	//draw_set_color(make_colour_rgb(_r+80, _g+80, _b+80));
	
	for (var i=0; i<array_length(t1); i++) {
		draw_line_width(t1[i][0], t1[i][1], t2[i][0], t2[i][1], 3);
	}
	
	draw_set_color(_c);
}