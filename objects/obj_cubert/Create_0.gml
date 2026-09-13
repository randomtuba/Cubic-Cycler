x_speed = 0
y_speed = 0
image_speed = 0
collision_map = layer_tilemap_get_id("Tiles_1")
lose_state = false
lose_timer = 0

if (x == 64 && y == 480) {
	player_copy = 0
}

if (y > 640) {
	player_copy = 1 + ((x - 544) / 64)
}