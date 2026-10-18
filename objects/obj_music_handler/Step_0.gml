if (!audio_is_playing(song)) {
	song_ended = true
}

if (song_ended) {
	song_timer++
	if (song_timer > 3 * sec) {
		song_ended = false
		song_timer = 0
		play_new_song()
	}
}