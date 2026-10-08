
#region Controls (Copy from Step)

var _lr = (keyboard_check(vk_right)||keyboard_check(ord("D"))) - (keyboard_check(vk_left)||keyboard_check(ord("A")))
var _down = (keyboard_check(vk_down) || keyboard_check(ord("S"))) && checkGrounded(self, collisions).valid && !immobile
var _jump = keyboard_check(vk_up) || keyboard_check(ord("W")) || keyboard_check(vk_space)

#endregion

rotation = lerp(rotation, _down ? -90*sign(x_scale) : -0.5*clamp(pos.y_speed, -20, 20)*sign(image_xscale), 0.75);
if (jump_k > 0) { jump_k--; }
var jump_p = jump_k/jump_j_max;
var _xw = clamp(-0.020*bounciness*dsin(360*jump_p)*jump_p, -0.5, 0.5);
var _yh = clamp(0.005*bounciness*dsin(360*jump_p)*jump_p, -0.2, 0.2);
draw_sprite_ext(spr_cubert_2, image_index, x, y, x_scale*(1+_xw), image_yscale*(1+_yh), rotation, c_white, image_alpha*visible);