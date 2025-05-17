extends Button

@onready var settings_menu = $"../../settings"
@onready var escape_menu = $".."
@onready var playerbar = $"../../PlayerList"

func _on_pressed():
	escape_menu.hide()
	playerbar.hide()
	settings_menu.show()
