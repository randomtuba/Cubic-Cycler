song = audio_play_sound(mus_ccdemo, 100, true)
song_timer = 0
song_ended = false
game_done = false

function play_new_song() {
	audio_stop_sound(song)
	var rand = irandom_range(1,1000)
	if (rand > 0 && rand < 126) {
		song = audio_play_sound(mus_ambiescence, 100, false, global.music_vol)
		return
	} else if (rand > 125 && rand < 251) {
		song = audio_play_sound(mus_cubic_chambers, 100, false, global.music_vol)
		return
	} else if (rand > 250 && rand < 376) {
		song = audio_play_sound(mus_ad_nauseum, 100, false, global.music_vol)
		return
	} else if (rand > 375 && rand < 501) {
		song = audio_play_sound(mus_ponderbeat, 100, false, global.music_vol)
		return
	} else if (rand > 500 && rand < 626) {
		song = audio_play_sound(mus_tuff_stuff, 100, false, global.music_vol)
		return
	} else if (rand > 625 && rand < 751) {
		song = audio_play_sound(mus_chimera_11, 100, false, global.music_vol)
		return
	} else if (rand > 750 && rand < 876) {
		song = audio_play_sound(mus_wrapitup, 100, false, global.music_vol)
		return
	} else if (rand > 875 && rand < 1000) {
		song = audio_play_sound(mus_cycling_forever, 100, false, global.music_vol)
		return
	} else {
		song = audio_play_sound(mus_ponderlust, 100, false, global.music_vol)
		return
	}
}