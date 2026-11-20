gravity = 0.4
vspeed *= 0.99

if (y > room_height+100) {
	randomize();
	var i = irandom_range(0, 40);
	if (i == 0) { image_index = 4+irandom_range(0, 2); } else { image_index = 0 }
	y = -100
}

hspeed += (mouse_x - x)*0.001;
x = clamp(x, 0, room_width)

//x = lerp(x, room_width/2 + ((mouse_x-room_width/2)*0.3), 0.2)
