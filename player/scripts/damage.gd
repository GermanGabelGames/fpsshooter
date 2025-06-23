extends CharacterBody3D

@onready var anim_player = $"../AnimationPlayer"
@onready var raycast = $"../CammeraControler/Camera3D/RayCast3D"

var health = 100

func _unhandled_input(event):
	if not is_multiplayer_authority(): return
	if event.is_action_pressed("shoot") and anim_player.current_animation != "AssoultFire":
		#play_shoots_effects.rpc()
		if raycast.is_colliding():
			var hit_player = raycast.get_collider()
			print("check")
			print(hit_player.get_multiplayer_authority())
			hit_player.receive_damage.rpc_id(hit_player.get_multiplayer_authority())
			print("40 Damage von ", get_multiplayer_authority(), " an ", hit_player.get_multiplayer_authority())

@rpc("any_peer")
func receive_damage():
	health -= 40
	print(health)
	if health <= 0:
		print("tot")
		get_tree().quit()
