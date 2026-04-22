extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var button_2: Button = $MainButtons/Button2

var buttons := []

func _process(delta) -> void:
	pass

func _ready():
	main_buttons.visible = true
	# connect Options.closed signal to this node's method
	options.connect("closed", Callable(self, "_on_options_closed"))
	# connect the main Options button
	button_2.connect("pressed", Callable(self, "_on_options_pressed"))
	
	for c in main_buttons.get_children():
		if c is Button:
			buttons.append(c)
			c.mouse_filter = Control.MOUSE_FILTER_IGNORE
			c.focus_mode = Control.FOCUS_ALL

	if buttons.size() == 0:
		push_warning("No Button nodes under %s" % main_buttons.get_path())
		return

	buttons[0].grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventAction and event.pressed and not event.echo:
		if event.action == "move_up":
			_focus_next(-1)
			get_tree().set_input_as_handled()

		elif event.action == "move_down":
			_focus_next(1)
			get_tree().set_input_as_handled()

		elif event.action == "enter":
			var focused = get_viewport().gui_get_focus_owner()
			if focused and focused is Button:
				focused.press()
				get_tree().set_input_as_handled()




func _focus_next(direction: int) -> void:
	if buttons.size() == 0:
		return

	var focused = get_viewport().gui_get_focus_owner()
	var idx = buttons.find(focused)

	if idx == -1:
		idx = 0 if direction > 0 else buttons.size() - 1
	else:
		idx = (idx + direction) % buttons.size()
		if idx < 0:
			idx += buttons.size()

	buttons[idx].grab_focus()


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/Level1.tscn")


func _on_button_2_pressed():
	main_buttons.visible = false
	options.show_options()


func _on_button_3_pressed():
	get_tree().quit()


func _on_back_pressed() -> void:
	_ready()
