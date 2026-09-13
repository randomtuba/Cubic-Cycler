// Apply spring velocity
if (x > other.x) {
	x_speed = 15
} else {
	x_speed = -15
}

// Reduce drag temporarily
x_drag = 0.95
alarm[1] = sec/3