song = audio_play_sound(mus_ccdemo, 100, true)
song_timer = 0
song_ended = false

function play_new_song() {
	audio_stop_sound(song)
	var rand = floor(random_range(1,6))
	switch (rand) {
		case 1:
			song = audio_play_sound(mus_ambiescence, 100, false)
			break
		case 2:
			song = audio_play_sound(mus_cubic_chambers, 100, false)
			break
		case 3:
			song = audio_play_sound(mus_framing_device, 100, false)
			break
		case 4:
			song = audio_play_sound(mus_nowwithdrums, 100, false)
			break
		case 5:
			song = audio_play_sound(mus_tuff_stuff, 100, false)
			break
	}
}