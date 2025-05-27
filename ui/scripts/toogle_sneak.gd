extends CheckBox

var toggle_sneak

func _ready():
	load_json()
	#$".".toggle_mode = toggle_sneak

func _process(delta):
	pass

func load_json():
	if FileAccess.file_exists("user://settings_data.json"):
		var file = FileAccess.open("user://settings_data.json", FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_string)
		if result and result.has("toggle_sneak"):
			toggle_sneak = result["toggle_sneak"]
