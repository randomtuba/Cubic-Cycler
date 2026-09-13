//main vars
x_speed = 0
y_speed = 0
image_speed = 0
collision_map = layer_tilemap_get_id("Tiles_1")

//cool effects
jump_k = 0;


//create visual warp cuberts
main_cubert = self;
is_main_cubert = true;
main_cubert_offset = [0, 0];
non_main_cuberts = [];
alarm[0] = 1;