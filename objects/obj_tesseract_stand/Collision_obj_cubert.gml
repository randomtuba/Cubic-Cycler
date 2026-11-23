// if a tesseract hasn't been placed already AND cubert has enough tesseracts collected to place another,
// place down the tesseract
if (!global.tesseracts[1][stand_number]
	&& array_length(array_filter(global.tesseracts[1], function(_val){return _val})) < array_length(global.tesseracts[0])) {
	global.tesseracts[1][stand_number] = true
	checkpoint_write_file()
}