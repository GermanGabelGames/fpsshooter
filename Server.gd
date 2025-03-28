extends Node

var network = ENetMultiplayerPeer.new()
var ip = "85.215.61.20"
var port = 4242

func _ready():
	ConnectToServer()

func ConnectToServer():
	print("Versuche, eine Verbindung zu ", ip, " auf Port ", port, " herzustellen.")
	var result = network.create_client(ip, port)
	
	if result == OK:
		print("Verbindung erfolgreich gestartet!")
		multiplayer.set_multiplayer_peer(network)
		
		# Verbindungssignale
		network.connect("peer_connected", Callable(self, "_OnConnectionSucceeded"))
		network.connect("peer_disconnected", Callable(self, "_OnConnectionFailed"))
	else:
		print("Fehler beim Starten der Verbindung: ", result)

func _OnConnectionFailed():
	print("Verbindung fehlgeschlagen oder Verbindung wurde getrennt.")

func _OnConnectionSucceeded():
	print("Erfolgreich verbunden!")
