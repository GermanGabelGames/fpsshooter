extends Control

var toggle_sneak = false
var color_json := Color(1, 1, 1)
var color_load := Color(1, 1, 1)
var mouse_sense = 2.5

func _ready():
	load_json()

func _on_check_box_toggled(toggled_on):
	print(toggled_on)
	toggle_sneak = toggled_on
	save_json()


func save_json():
	var data = {
	"mouse_sense": mouse_sense,
	"toggle_sneak": toggle_sneak,
	"color_json": {
		"r": color_json.r,
		"g": color_json.g,
		"b": color_json.b,
		"a": color_json.a
		}
	}
	var file = FileAccess.open("user://settings_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	file.close()

func load_json():
	if FileAccess.file_exists("user://settings_data.json"):
		var file = FileAccess.open("user://settings_data.json", FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_string)
		if result and result.has("toggle_sneak"):
			toggle_sneak = result["toggle_sneak"]
		if result and result.has("color"):
			color_load = result["color"]
		if result and result.has("mouse_sense"):
			mouse_sense = result["mouse_sense"]

func _on_color_picker_button_color_changed(color):
	color_json = color
	save_json()


func _on_sense_value_changed(value):
	mouse_sense = value
	save_json()
