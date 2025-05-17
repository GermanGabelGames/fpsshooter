extends CenterContainer

@export var DOT_RADIUS : float = 1.0
@export var DOT_COLOR := Color(1, 1, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	load_json()
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _draw():
	draw_circle(Vector2(0,0),DOT_RADIUS,DOT_COLOR)
	draw_line(Vector2(8,0),Vector2(16,0),DOT_COLOR,2)
	draw_line(Vector2(-8,0),Vector2(-16,0),DOT_COLOR,2)
	draw_line(Vector2(0,8),Vector2(0,16),DOT_COLOR,2)
	draw_line(Vector2(0,-8),Vector2(0,-16),DOT_COLOR,2)

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


func _on_back_pressed():
	load_json()
	queue_redraw()
