extends Button

func _ready():
	pass

func _process(_delta):
	pass


func _on_pressed():
	get_tree().change_scene_to_file("res://ui/menu.tscn")
