extends Container

@onready var healthbar = $healthbar
@onready var shieldtext = $"../Label"

var health = 100
var shield = 0
var temp_health

func _ready():
	healthbar.value = 100

func _input(event):
	if event.is_action_pressed("heal"):
		heal()
	if event.is_action_pressed("damage"):
		damage()

func heal():
	health += 10
	if health > 100:
		healthbar.value = 100
		temp_health = health
		temp_health -= 100
		shieldtext.text = str(temp_health)
	if health >= 150:
		healthbar.value = 100
		shieldtext.text = str("50")
		health = 150
	else:
		healthbar.value = health

func damage():
	health -= 10
	dead_check()
	if health >= 100:
		healthbar.value = 100
		temp_health = health
		temp_health -= 100
		shieldtext.text = str(temp_health)
	if health >= 150:
		healthbar.value = 100
		shieldtext.text = str("50")
		health = 150
	else:
		healthbar.value = health

func dead_check():
	if health <= 0:
		get_tree().change_scene_to_file("res://ui/tot.tscn")
