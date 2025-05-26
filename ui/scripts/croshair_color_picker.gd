extends ColorPickerButton

func _ready():
	await ready
	var picker = get_popup().get_child(0) as ColorPicker
	picker.deferred_mode = false
	picker.edit_alpha = false
	picker.presets_visible = false
	$".".color = Global.DOT_COLOR
