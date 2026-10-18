if (should_screenwrap()) { image_alpha = 0.25 } else { image_alpha = 0 }

image_xscale = global.cam_size[0] / 64
image_yscale = global.cam_size[1] / 64

x = camera_get_view_x(view_camera[0]);
y = camera_get_view_y(view_camera[0]);