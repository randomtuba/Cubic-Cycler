innerSpr = spr_menubacking_minimap_screen;
pause_menu_func = function(_hover){
	if (image_alpha > 0.98) { innerSpr = spr_menubacking_minimap_screen_2; }
	else { innerSpr = spr_menubacking_minimap_screen; }
};
global.map_holder_pausemenu_obj = self;