extends Button

var startcmd = OS.get_cmdline_args()

func _ready():
	print(startcmd)
	if DisplayServer.get_name() == "headless":
		print("server")
		get_tree().change_scene_to_file("res://node.tscn")
	else:
		print("client")

func _on_pressed():
	get_tree().change_scene_to_file("res://node.tscn")
