extends Node

const Player = preload("res://player/player.tscn")
const PORT = 4242
const maxplayers = 10

var enet_pear = ENetMultiplayerPeer.new()
var startcmd = OS.get_cmdline_args()

func _ready():
	print(startcmd)
	if DisplayServer.get_name() == "headless":
		print("server")
		serverstart()
	else:
		print("client")
		startclient()

func add_player(peer_id):
	var player = Player.instantiate()
	player.name = str(peer_id)
	add_child(player)
	print("player connected")
	print(peer_id)
	
func serverstart():
	enet_pear.create_server(PORT, maxplayers)
	multiplayer.multiplayer_peer = enet_pear
	multiplayer.peer_connected.connect(add_player)
	print("Server started")

func startclient():
	enet_pear.create_client("localhost", PORT)
	multiplayer.multiplayer_peer = enet_pear
