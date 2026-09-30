ang_xz = 0;//from right (0deg) to out of the screen (90deg), can go full circle ofc
ang_xy = 0;//from right (0deg) to up (90deg), can go full circle ofc
ang_xz2 = 0;
ang_xy2 = 0;
r = 32;

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
	//draw_line(p0[0] + p0u[0], p0[1] + p0u[1], p0[0] + p0d[0], p0[1] + p0d[1]);
	//draw_line(p0[0] - r*dsin(_ang_xz), p0[1], p0[0] + r*dsin(_ang_xz), p0[1]);
	
	//each corner
	var pul = [p0[0] + p0u[0] - _r*dsin(_ang_xz), p0[1] + p0u[1]];
	var pdl = [p0[0] + p0d[0] - _r*dsin(_ang_xz), p0[1] + p0d[1]];
	var pur = [p0[0] + p0u[0] + _r*dsin(_ang_xz), p0[1] + p0u[1]];
	var pdr = [p0[0] + p0d[0] + _r*dsin(_ang_xz), p0[1] + p0d[1]];
	
	//connect 1 to 2, 3 to 4
	draw_line(pul[0], pul[1], pdl[0], pdl[1]);
	draw_line(pur[0], pur[1], pdr[0], pdr[1]);
	
	//connect 1 to 3, 2 to 4
	draw_line(pul[0], pul[1], pur[0], pur[1]);
	draw_line(pdl[0], pdl[1], pdr[0], pdr[1]);
	
	return [pul, pdl, pur, pdr];
}

function draw_tessa_cube(_x = x, _y = y, _ang_xz = ang_xz, _ang_xy = ang_xy, _r = r) {
	var s1 = draw_tessa_square(_x, _y, _ang_xz, _ang_xy, _r);
	var s2 = draw_tessa_square(_x, _y, _ang_xz, _ang_xy+180, _r);
	//connect each corner
	draw_line(s1[0][0], s1[0][1], s2[1][0], s2[1][1]);
	draw_line(s1[1][0], s1[1][1], s2[0][0], s2[0][1]);
	draw_line(s1[2][0], s1[2][1], s2[3][0], s2[3][1]);
	draw_line(s1[3][0], s1[3][1], s2[2][0], s2[2][1]);
}