extends Button

@onready var settings = $".."
@onready var escape_menu = $"../../escape_menu"
@onready var playerbar = $"../../PlayerList"

func _ready():
	pass

func _process(_delta):
	pass

func _on_pressed():
	settings.hide()
	escape_menu.show()
	playerbar.show()
