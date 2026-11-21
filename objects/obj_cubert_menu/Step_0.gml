gravity = 0.4
vspeed *= 0.99

if (y > room_height+100) {
	y = -100
}

hspeed += (mouse_x - x)*0.001;
x = clamp(x, 0, room_width)

//x = lerp(x, room_width/2 + ((mouse_x-room_width/2)*0.3), 0.2)
