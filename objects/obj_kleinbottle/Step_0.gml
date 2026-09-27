if (array_contains(global.kleinbottles_collected, id)) instance_destroy()

if (image_index == 1) {
	y -= 2
	image_alpha -= 0.02

	if (image_alpha <= 0) {
		array_push(global.kleinbottles_collected, id)
		instance_destroy()
	}
}