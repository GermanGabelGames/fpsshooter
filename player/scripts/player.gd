extends CharacterBody3D


@export var SPEED : float = 5.0
@export var JUMP_VELOCITY : float = 5.0
@export_range(5, 10, 0.1) var CROUCH_SPEED : float = 7.0
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@export var ANIMATIONPLAYER : AnimationPlayer
@export var CROUCH_SHAPECAST : Node3D

@onready var anim_player = $AnimationPlayer
@onready var camera = $CammeraControler/Camera3D
@onready var raycast = $CammeraControler/Camera3D/RayCast3D
@onready var escapemenu = $CammeraControler/Camera3D/hud/escape_menu
@onready var team_pick_menu = $CammeraControler/Camera3D/hud/team_pick
@onready var username_label = $username_label

var damage = 10
var MOUSE_SENSITIVITY = 0.01
var TOGGLE_CROUCH
var _mouse_input : bool = false
var _mouse_rotation : Vector3
var _rotation_input : float
var _tilt_input : float
var _player_rotation : Vector3
var _camera_rotation : Vector3      
var _is_crouching : bool = false
var health = 100
var temp_health

func _enter_tree():
	set_multiplayer_authority(str(name).to_int())
	print(str(name).to_int())

func _input(event):
	if not is_multiplayer_authority(): return
	if event.is_action_pressed("exit"):
		escapemenu.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if event.is_action_pressed("crouch") and TOGGLE_CROUCH == true:
		toggle_crouch()
	if event.is_action_pressed("crouch") and _is_crouching == false and TOGGLE_CROUCH == false:
		crouching.rpc(true)
	if event.is_action_released("crouch") and TOGGLE_CROUCH == false:
		if CROUCH_SHAPECAST.is_colliding() == false:
			crouching.rpc(false)
		elif  CROUCH_SHAPECAST.is_colliding() == true:
			uncrouch_check()

func _unhandled_input(event):
	if not is_multiplayer_authority(): return
	
	_mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if _mouse_input:
		_rotation_input = -event.relative.x
		_tilt_input = -event.relative.y
	
	if event.is_action_pressed("shoot") and anim_player.current_animation != "AssoultFire":
		play_shoots_effects.rpc()

func _update_camera(delta):
	_mouse_rotation.x += _tilt_input * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _rotation_input * delta
	
	_player_rotation = Vector3(0.0,_mouse_rotation.y,0.0)
	_camera_rotation = Vector3(_mouse_rotation.x,0.0,0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(_camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(_player_rotation)
	
	_rotation_input = 0.0
	_tilt_input = 0.0

func _ready():
	if not is_multiplayer_authority(): return
	load_json()
	camera.current = true
	
	CROUCH_SHAPECAST.add_exception($".")
	
	if DisplayServer.get_name() == "headless":
		pass
	else:
		team_pick_menu.show()

func _physics_process(delta):
	if not is_multiplayer_authority(): return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_update_camera(delta)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func toggle_crouch():
	if _is_crouching == true and CROUCH_SHAPECAST.is_colliding() == false:
		crouching.rpc(false)
	elif _is_crouching == false:
		crouching.rpc(true)

func uncrouch_check():
	if CROUCH_SHAPECAST.is_colliding() == false:
		crouching.rpc(false)
	if CROUCH_SHAPECAST.is_colliding() == true:
		await get_tree().create_timer(0.1).timeout
		uncrouch_check()

@rpc("call_local")
func crouching(state : bool):
	match state:
		true:
			SPEED = 2.0
			ANIMATIONPLAYER.play("crouch", 0, CROUCH_SPEED)
		false:
			SPEED = 5.0
			ANIMATIONPLAYER.play("crouch", 0, -CROUCH_SPEED)

func _on_animation_player_animation_started(anim_name):
	if anim_name == "crouch":
		_is_crouching = !_is_crouching

func load_json():
	if FileAccess.file_exists("user://settings_data.json"):
		var file = FileAccess.open("user://settings_data.json", FileAccess.READ)
		var json_string = file.get_as_text()
		file.close()
		var result = JSON.parse_string(json_string)
		if result and result.has("toggle_sneak"):
			TOGGLE_CROUCH = result["toggle_sneak"]
		if result and result.has("mouse_sense"):
			MOUSE_SENSITIVITY = result["mouse_sense"]

@rpc("any_peer")
func receive_damage():
	health -= 40
	print(health)
	if health <= 0:
		print("tot")
		get_tree().quit()

func healthcheck():
	if health <= 0:
		health = 100
		position = Vector3.ZERO

@rpc("call_local")
func play_shoots_effects():
	anim_player.stop()
	anim_player.play("AssoultFire")


func _on_team_1_pressed():
	Global.team = 1
	team_pick_menu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_team_2_pressed():
	Global.team = 2
	team_pick_menu.hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
