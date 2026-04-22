extends Panel

signal closed
@onready var display_toggle: CheckButton = $DisplayToggle
var music_bus_id
var sfx_bus_id


func _ready() -> void:
	music_bus_id = AudioServer.get_bus_index("Music")
	sfx_bus_id = AudioServer.get_bus_index("SFX")
	# connect the Back button's pressed to the local method
	$Back.connect("pressed", Callable(self, "_on_Back_pressed"))
	hide()

func show_options() -> void:
	show()
	$DisplayToggle.grab_focus()

func _on_Back_pressed() -> void:
	emit_signal("closed")
	hide()


func _on_display_toggle_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED) # Replace with function body.


func _on_music_slider_value_changed(value: float) -> void:
	var db_m = linear_to_db(value)
	AudioServer.set_bus_volume_db(music_bus_id, db_m)


func _on_sfx_slider_value_changed(value: float) -> void:
	var db_s = linear_to_db(value)
	AudioServer.set_bus_volume_db(sfx_bus_id, db_s)
