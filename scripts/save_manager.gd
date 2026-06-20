extends Node

const SAVE_PATH = "user://save.json"

func _ready():
	load_game()

func save_game():
	# FORCE ALL STARS TO INT BEFORE SAVING
	var clean_stars = []

	for star in pickups.stars:
		clean_stars.append(int(star))

	var save_data = {
		"stars": clean_stars,
		"lang": language.lang
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(save_data))
		file.close()


func load_game():
	if !FileAccess.file_exists(SAVE_PATH):
		return

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if !file:
		return

	var json_text = file.get_as_text()
	file.close()

	var data = JSON.parse_string(json_text)

	if typeof(data) != TYPE_DICTIONARY:
		return

	# SAFE STAR LOADING (NO DUPLICATES, NO TYPE ISSUES)
	if data.has("stars"):
		var loaded_stars = []

		for star in data["stars"]:
			loaded_stars.append(int(star))

		pickups.stars = loaded_stars

	if data.has("lang"):
		language.lang = data["lang"]
