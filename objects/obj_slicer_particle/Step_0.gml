if (x != clamp(x, 0, room_width) || y != clamp(y, 0, room_height)) { instance_destroy() }
image_angle += rotspd
direction = gravity_direction
rotspd *= 0.98