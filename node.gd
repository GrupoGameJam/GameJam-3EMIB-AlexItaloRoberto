extends Node

# Configuration
const TARGET_FOLDERS = ["res://scripts", "res://scenes"]
const OUTPUT_PATH = "res://game_translations.csv"
const DEFAULT_LOCALE = "pt" # Brazilian Portuguese default column

var extracted_strings = {}

func _ready() -> void:
	print("--- Starting Full Project Text Sweep ---")
	
	for folder in TARGET_FOLDERS:
		scan_directory(folder)
		
	write_to_csv()
	print("--- Sweep Complete! ---")

func scan_directory(path: String) -> void:
	var dir = DirAccess.open(path)
	if not dir:
		print("Warning: Could not open directory: ", path)
		return
		
	dir.list_dir_begin()
	var file_name = dir.get_next()
	
	while file_name != "":
		if dir.current_is_dir():
			# Recursively scan subfolders if they exist
			if file_name != "." and file_name != "..":
				scan_directory(path.path_join(file_name))
		else:
			var file_path = path.path_join(file_name)
			if file_name.ends_with(".gd") or file_name.ends_with(".tscn"):
				parse_file(file_path)
				
		file_name = dir.get_next()

func parse_file(file_path: String) -> void:
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		return
		
	# Regex pattern to catch anything inside double quotes
	var regex = RegEx.new()
	regex.compile('"([^"\\n\\\\\\r]*)"') 
	
	while not file.eof_reached():
		var line = file.get_line()
		var matches = regex.search_all(line)
		
		for m in matches:
			var text_val = m.get_string(1).strip_edges()
			if is_valid_dialogue(text_val):
				extracted_strings[text_val] = true
				
	file.close()

func is_valid_dialogue(text: String) -> bool:
	# Filter out empty entries, technical file tags, layout formats, numbers, and engine paths
	if text.length() <= 1: return false
	if text.begins_with("res://") or text.begins_with("uid://"): return false
	if text.contains("node_paths") or text.contains("type=") or text.contains("parent="): return false
	if text == "value" or text == "name" or text == "script" or text == "text": return false
	return true

func write_to_csv() -> void:
	var csv = FileAccess.open(OUTPUT_PATH, FileAccess.WRITE)
	if not csv:
		print("Error: Could not create output CSV file.")
		return
		
	# Row 1: Column A is blank, Column B is the native Brazilian Portuguese localization tracker
	csv.store_csv_line(["", DEFAULT_LOCALE])
	
	# Populate the rows using the extracted string as BOTH the lookup key and the source text
	for string_key in extracted_strings.keys():
		csv.store_csv_line([string_key, string_key])
		
	csv.close()
	print("Successfully generated true localized spreadsheet at: ", OUTPUT_PATH)
