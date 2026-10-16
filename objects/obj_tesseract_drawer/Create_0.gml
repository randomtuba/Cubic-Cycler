ang_xz = 0;//from right (0deg) to out of the screen (90deg), can go full circle ofc
ang_xy = 0;//from right (0deg) to up (90deg), can go full circle ofc
//ang_xz2 = 0;
//ang_xy2 = 0;

rad = 32;
r = rad;
r2 = rad*2;
timer = 0;

ang_xz_spd = 4/20;
ang_xy_spd = pi/20;
ang_xz2_spd = 0;
ang_xy2_spd = 0;

spr = spr_cubert;

collected = false;
collect_k = 0;
collect_timer = 0;

mat_4d_transform = matrix_build_identity() //for now

rot_xw = 0;
rot_yz = 0;
rot_xw_spd = 0.0022334; //very different numbers so the rotations are out of phase
rot_yz_spd = 0.0015;

base_tes_coordinates = [ //a tesseract, of edge length 2
 [1,1,1,1],
 [-1,1,1,1],
 [1,-1,1,1],
 [1,1,-1,1],
 [1,1,1,-1],
 [-1,-1,1,1],
 [-1,1,-1,1],
 [-1,1,1,-1],
 [1,-1,-1,1],
 [1,-1,1,-1],
 [1,1,-1,-1],
 [1,-1,-1,-1],
 [-1,1,-1,-1],
 [-1,-1,1,-1],
 [-1,-1,-1,1],
 [-1,-1,-1,-1]
];

edge_indices = []; //will store each tesseract edge as a pair of vertex indices
//precompute this. 32 edges is a lot im not typing it all out

flipcoord = []; //this is a global becaue AAAAAAA

scale = 400; 

for (var vert = 0; vert < array_length(base_tes_coordinates); vert++) {
	for (var j = 0; j < 4; j++) {
		array_copy(flipcoord,0,base_tes_coordinates[vert],0,4); //why is copying an array this annoying
		flipcoord[j] *= -1;
		var othervert = array_find_index(base_tes_coordinates,function(_element, _index) {
			return array_equals(_element,flipcoord);
		});
		if (!array_contains(edge_indices,[othervert,vert])) {
			array_push(edge_indices,[vert,othervert]);
		}
	}
}
  
depth = -1000



camera_pos_4d = [0,0,0,4.5] // looking at it from kata or whatever
camera_pos_3d = [0,0,4.5] //adjust later


function make_dubrot_mat() {
	//makes the transformation matrix correct according to the rot_xw and rot_yz
	mat_4d_transform = [
		cos(rot_xw), 0, 0, -sin(rot_xw),
		0, cos(rot_yz), -sin(rot_yz), 0,
		0, sin(rot_yz), cos(rot_yz), 0,
		sin(rot_xw), 0, 0, cos(rot_xw)
	]
}

function transformed_tessa() {
	var new_tes_coordinates = [];
	for (var i = 0; i < array_length(base_tes_coordinates); i++) {
		array_push(new_tes_coordinates,matrix_transform_vertex(mat_4d_transform,base_tes_coordinates[i][0],base_tes_coordinates[i][1],base_tes_coordinates[i][2],base_tes_coordinates[i][3]));
	}
	return new_tes_coordinates;
}


function project_tessa() {
	//grab the transformed tesseract
	var trans_tes = transformed_tessa();
	//first, project to 3d
	var tes_3d_proj = [];
	for (var verti = 0; verti < array_length(base_tes_coordinates); verti++) {
		var vert = trans_tes[verti];
		var dist = sqrt(power((camera_pos_4d[0]-vert[0]),2) + power((camera_pos_4d[1]-vert[1]),2) + power((camera_pos_4d[2]-vert[2]),2) + power((camera_pos_4d[3]-vert[3]),2));
		array_push(tes_3d_proj,[vert[0]/(dist-vert[3]),vert[1]/(dist-vert[3]),vert[2]/(dist-vert[3])]);
	}
	//now, project to 2d
	var tes_2d_proj = [];
	for (var verti = 0; verti < array_length(base_tes_coordinates); verti++) {
		var vert = tes_3d_proj[verti];
		var dist = sqrt(power((camera_pos_3d[0]-vert[0]),2) + power((camera_pos_3d[1]-vert[1]),2) + power((camera_pos_3d[2]-vert[2]),2));
		array_push(tes_2d_proj,[vert[0]/(dist-vert[2]),vert[1]/(dist-vert[2])]);
	}
	return tes_2d_proj;
}

function draw_tessa() {
	draw_set_color(c_black);
	//get the projected transformed tesseract
	var tes = project_tessa()
	for (var edgi = 0; edgi < array_length(edge_indices); edgi++) {
		var edge = edge_indices[edgi]
		draw_line_width(x+tes[edge[0]][0]*scale, y+tes[edge[0]][1]*scale, x+tes[edge[1]][0]*scale, y+tes[edge[1]][1]*scale, 2);
	}
}