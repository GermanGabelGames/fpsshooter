extends Node

var network = ENetMultiplayerPeer.new()
var ip = "85.215.61.20"
var port = 4242

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	multiplayer.set_multiplayer_peer(network)
	
	multiplayer.connect("connection_failed", Callable(self, "_OnConnectionFailed"))
	multiplayer.connect("connection_succeeded", Callable(self, "_OnConnectionSucceeded"))

func _OnConnectionFailed():
	print("Failed to connect")

func _OnConnectionSucceeded():
	print("Connected!")
