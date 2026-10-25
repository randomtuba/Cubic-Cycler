
image_angle += rotspd
direction = gravity_direction
rotspd *= 0.98


if (x < 0 || x > room_width || y < 0 || x > room_height) { instance_destroy(); }
//if (instance_number(object_index) > 320) { instance_destroy(); }  