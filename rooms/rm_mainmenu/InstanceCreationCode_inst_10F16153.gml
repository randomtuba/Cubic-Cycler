innerText = "GAMEPAD";
pause_menu_func = function(_hover){
	if (global.gamepad) {
		innerText = "GAMEPAD";
	} else {
		innerText = "KEYBOARD & MOUSE";
	}
};