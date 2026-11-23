if (!audio_is_playing(song)) {
	with (obj_credits_drawer) {
		if (credits_timer > 60 * sec) game_restart()
	}
	song_ended = true
}

if (song_ended && !game_done) {
	song_timer++
	if (song_timer > 3 * sec) {
		song_ended = false
		song_timer = 0
		play_new_song()
	}
} else if (room = rm_winscreen && game_done && !audio_is_playing(song)) {
	song_timer++
	if (song_timer > 4 * sec) {
		song_ended = false
		song_timer = 0
		song = audio_play_sound(mus_isolation_in_b_minor, 100, false, global.music_vol)
	}
}