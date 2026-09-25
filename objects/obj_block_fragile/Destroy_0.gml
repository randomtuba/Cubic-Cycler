for (var i = 0; i < 7; i++) {
	var part = instance_create_layer(x, y, "Instances", obj_break_particle)
	part.direction = random_range(-180,180)
}