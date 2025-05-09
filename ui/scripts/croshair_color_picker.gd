extends ColorPickerButton

var DOT_COLOR := Color(1, 1, 1)

func _ready():
	load_json()
	await ready
	var picker = get_popup().get_child(0) as ColorPicker
	picker.deferred_mode = false
	picker.edit_alpha = false
	picker.presets_visible = false
	$".".color = DOT_COLOR

func load_json():
	if FileAccess.file_exists("user://settings_data.json"):
		var file = FileAccess.open("user://settings_data.json", FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_string)
		if result:
			if result.has("color_json"):
				var c = result["color_json"]
				DOT_COLOR = Color(c["r"], c["g"], c["b"], c["a"])
