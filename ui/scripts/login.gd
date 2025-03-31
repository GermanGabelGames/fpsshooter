extends Node

@rpc("reliable")
func request_player_data(player_name: String):
	rpc_id(1, "request_player_data", player_name)
