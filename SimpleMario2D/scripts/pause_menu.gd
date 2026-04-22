extends CanvasLayer

@onready var overlay: Control = $Overlay
@onready var resume: Button = $Overlay/VBoxContainer/Resume
@onready var quit: Button = $Overlay/VBoxContainer/Quit


func _ready():
	overlay.visible = false 

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	
	overlay.visible = is_paused

	if is_paused:
		resume.grab_focus()



func _on_resume_pressed() -> void:
	toggle_pause()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn") # Replace with function body.
