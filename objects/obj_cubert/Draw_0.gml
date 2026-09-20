
#region Controls (Copy from Step)

var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
var _down = (keyboard_check(vk_down) || keyboard_check(ord("S"))) && !(place_meeting(x, y+2, collisions) || faux_place_meeting(0, 2, collisions))
var _jump = keyboard_check(vk_up) || keyboard_check(ord("W"))

#endregion


rotation = lerp(rotation, _down ? -90*sign(image_xscale) : -0.5*clamp(y_speed, -20, 20)*sign(image_xscale), 0.75);
if (jump_k > 0) { jump_k--; }
var _xw = clamp(-0.5, -0.020*bounciness*dsin(360*jump_k/jump_j_max)*jump_k/jump_j_max, 0.5);
var _yh = clamp(-0.2, 0.005*bounciness*dsin(360*jump_k/jump_j_max)*jump_k/jump_j_max, 0.2);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*(1+_xw), image_yscale*(1+_yh), rotation, c_white, image_alpha*visible);