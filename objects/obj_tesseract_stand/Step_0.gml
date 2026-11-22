if (global.tesseracts[1][stand_number] && !created_tessa) {
	instance_create_layer(x + 32, y - 64, "Instances", obj_tesseract_drawer)
	created_tessa = true
}