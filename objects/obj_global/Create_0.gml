#macro sec game_get_speed(gamespeed_fps)

// stores the position of the player
global.default_x = 0
global.default_y = 0

// platformer physics quality of life
global.coyote_time = 5
global.input_buffer_time = 5

// stores the map layout and current room
global.level_x = 1
global.level_y = 1
global.level_map = [
["","",""],
["",Room1,room_springtest],
["","",""],
]