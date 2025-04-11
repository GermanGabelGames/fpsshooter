extends Control

@onready var user = $GamerTag

func _on_button_pressed():
	request_user_data("test")
	print("Client ID:", multiplayer.get_unique_id())


@rpc("reliable")
func request_user_data(username: String):
	rpc_id( multiplayer.get_unique_id(), "get_user_data_rpc", username)

@rpc("reliable")
func receive_user_data(data: Dictionary):
	print("Daten erhalten:", data)
