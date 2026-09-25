// once touched by cubert, the fragile block begins breaking on its own
if (is_breaking) break_timer -= 1

// high image index means it gets more cracked
if (break_timer > sec * 0.75) {
	image_index = 0
} else if (break_timer > sec * 0.5) {
	image_index = 1
} else if (break_timer > sec * 0.25) {
	image_index = 2
} else if (break_timer > 0) {
	image_index = 3
} else {
	instance_destroy()
}