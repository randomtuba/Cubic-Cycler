if (is_on && get_destroyed_generator_count() >= 12) {
	is_on = false;
	fix_sprite();
}