
#region Controls (Copy from Step)

var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
var _down = (keyboard_check(vk_down) || keyboard_check(ord("S"))) && !(place_meeting(x, y+2, collisions) || faux_place_meeting(0, 2, collisions))
var _jump = keyboard_check(vk_up) || keyboard_check(ord("W"))

#endregion


rotation = lerp(rotation, _down ? -90*sign(image_xscale) : -0.5*clamp(y_speed, -20, 20)*sign(image_xscale), 0.75);
jump_k = lerp(jump_k, 0, 0.9);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale*(1+5*jump_k), image_yscale, rotation, c_white, image_alpha*visible);