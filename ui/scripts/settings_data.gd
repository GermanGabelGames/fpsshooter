extends Control

var toggle_sneak = false
var color_json
var color_load

func _ready():
	load_json()

func _on_check_box_toggled(toggled_on):
	print(toggled_on)
	toggle_sneak = toggled_on
	save_json()


func save_json():
	var data = {
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
		elif result and result.has("color"):
			color_load = result["color"]

func _on_color_picker_button_color_changed(color):
	color_json = color
	save_json()
