innerText = "";
innerSpr = -1;
pause_menu_func = function(_hover){
	image_alpha = 0;
	if (global.gamepad) {
		//innerText = "GAMEPAD";
		innerSpr = controller_xboxone;
	} else {
		innerSpr = keyboard_outline;
		//innerText = "KEYBOARD & MOUSE";
	}
};