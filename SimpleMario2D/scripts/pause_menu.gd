extends CanvasLayer

# Reference the "Overlay" control node to show/hide the menu visually
@onready var overlay: Control = $Overlay
@onready var resume: Button = $Overlay/VBoxContainer/Resume
@onready var quit: Button = $Overlay/VBoxContainer/Quit


func _ready():
	# Hide the menu at the start of the game
	overlay.visible = false 

func _input(event):
	# Check if the user pressed the "ui_cancel" (usually Escape) 
	# or a custom "pause" action you created
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	# Toggle the pause state
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	
	# Show/Hide the menu visuals
	overlay.visible = is_paused
	
	# Optional: Focus the resume button for keyboard/gamepad support
	if is_paused:
		resume.grab_focus()



func _on_resume_pressed() -> void:
	toggle_pause()


func _on_quit_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn") # Replace with function body.
