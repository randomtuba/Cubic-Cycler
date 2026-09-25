// Apply spring velocity
//if (abs(y-other.y) < 24) { }
x_speed = sign(x-other.x)*15;

// Reduce drag temporarily
x_drag = 0.95
alarm[1] = sec/3