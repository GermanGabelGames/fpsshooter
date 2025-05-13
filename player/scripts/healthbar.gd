extends Container

@onready var bar = $healthbar

func _ready():
	bar.value = 30
