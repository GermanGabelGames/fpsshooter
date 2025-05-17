extends Control

@onready var escapemenu = $".."

func _on_play_pressed():
	escapemenu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_quit_pressed():
	get_tree().quit()
