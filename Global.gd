extends Node

var MOUSE_SENSITIVITY = 0.1
var TOGGLE_CROUCH = false
var DOT_COLOR := Color(1, 1, 1)
var username = "Player"
var team

# Called when the node enters the scene tree for the first time.
func _ready():
	load_json()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func load_json():
	if FileAccess.file_exists("user://settings_data.json"):
		var file = FileAccess.open("user://settings_data.json", FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_string)
		if result and result.has("toggle_sneak"):
			TOGGLE_CROUCH = result["toggle_sneak"]
		if result and result.has("mouse_sense"):
			MOUSE_SENSITIVITY = result["mouse_sense"]
		if result and result.has("color_json"):
				var c = result["color_json"]
				DOT_COLOR = Color(c["r"], c["g"], c["b"], c["a"])
