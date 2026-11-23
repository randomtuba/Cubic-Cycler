song = audio_play_sound(mus_ccdemo, 100, true)
song_timer = 0
song_ended = false
game_done = false

function play_new_song() {
	audio_stop_sound(song)
	var rand = irandom_range(1,1000)
	if (rand > 0 && rand < 143) {
		song = audio_play_sound(mus_ambiescence, 100, false, global.music_vol)
		return
	} else if (rand > 142 && rand < 286) {
		song = audio_play_sound(mus_cubic_chambers, 100, false, global.music_vol)
		return
	} else if (rand > 285 && rand < 429) {
		song = audio_play_sound(mus_ad_nauseum, 100, false, global.music_vol)
		return
	} else if (rand > 428 && rand < 572) {
		song = audio_play_sound(mus_ponderbeat, 100, false, global.music_vol)
		return
	} else if (rand > 571 && rand < 715) {
		song = audio_play_sound(mus_tuff_stuff, 100, false, global.music_vol)
		return
	} else if (rand > 714 && rand < 858) {
		song = audio_play_sound(mus_chimera_11, 100, false, global.music_vol)
		return
	} else if (rand > 857 && rand < 1000) {
		song = audio_play_sound(mus_wrapitup, 100, false, global.music_vol)
		return
	} else {
		song = audio_play_sound(mus_ponderlust, 100, false, global.music_vol)
		return
	}
}