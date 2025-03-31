extends CenterContainer

@export var DOT_RADIUS : float = 1.0
@export var DOT_COLOR : Color = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()

func _draw():
	draw_circle(Vector2(0,0),DOT_RADIUS,DOT_COLOR)
	draw_line(Vector2(8,0),Vector2(16,0),DOT_COLOR,2)
	draw_line(Vector2(-8,0),Vector2(-16,0),DOT_COLOR,2)
	draw_line(Vector2(0,8),Vector2(0,16),DOT_COLOR,2)
	draw_line(Vector2(0,-8),Vector2(0,-16),DOT_COLOR,2)


func _on_color_picker_button_color_changed(color):
	DOT_COLOR = color
