extends Control

@onready var text_edit = $"."
@onready var error_label = $tomutch
@onready var toless = $toless

const MAX_CHARACTERS = 20
const FEHLER_CHARACTERS = 19
const TOLESS_CHARACTERS = 0

func _ready():
	error_label.visible = false
	toless.visible = false

func _process(delta):
	if text_edit.text.length() > MAX_CHARACTERS:
		text_edit.text = text_edit.text.substr(0, MAX_CHARACTERS)

	if text_edit.text.length() > FEHLER_CHARACTERS:
		error_label.visible = true
	else:
		error_label.visible = false

	if text_edit.text.length() <= TOLESS_CHARACTERS:
		toless.visible = true
	else:
		toless.visible = false
