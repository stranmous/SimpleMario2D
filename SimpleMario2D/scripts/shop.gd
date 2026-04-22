extends Area2D

# CRITICAL: Update path to where you saved ShopMenu.tscn in Step 5
const SHOP_UI_SCENE = preload("res://scenes/shop_menu.tscn") 

@onready var interact_prompt: Label = $InteractPrompt
var player_in_range = false

func _process(delta):
	# If near shop AND pressing Interact button
	if player_in_range and Input.is_action_just_pressed("interact"):
		open_shop()

func open_shop():
	var shop_instance = SHOP_UI_SCENE.instantiate()
	# Add menu to screen and PAUSE game
	get_tree().current_scene.add_child(shop_instance)
	get_tree().paused = true
	interact_prompt.visible = false

# --- SIGNALS ---
# Connect body_entered and body_exited to this script!

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		interact_prompt.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		interact_prompt.visible = false
