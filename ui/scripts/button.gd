extends Button

const PORT = 4242

var enet_pear = ENetMultiplayerPeer.new()

func _on_pressed():
	get_tree().change_scene_to_file("res://node.tscn")
	startclient()

func startclient():
	enet_pear.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_pear
