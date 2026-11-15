song = audio_play_sound(mus_ccdemo, 100, true)
song_timer = 0
song_ended = false

function play_new_song() {
	audio_stop_sound(song)
	var rand = irandom_range(1,7)
	switch (rand) {
		case 1:	song = audio_play_sound(mus_ambiescence, 100, false, global.music_vol)		break
		case 2:	song = audio_play_sound(mus_cubic_chambers, 100, false, global.music_vol)	break
		case 3:	song = audio_play_sound(mus_ad_nauseum, 100, false, global.music_vol)		break
		case 4:	song = audio_play_sound(mus_nowwithdrums, 100, false, global.music_vol)		break
		case 5:	song = audio_play_sound(mus_tuff_stuff, 100, false, global.music_vol)		break
		case 6:	song = audio_play_sound(mus_chimera_11, 100, false, global.music_vol)		break
		case 7:	song = audio_play_sound(mus_wrapitup, 100, false, global.music_vol)			break
	}
}