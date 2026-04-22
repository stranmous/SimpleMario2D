extends CanvasLayer

@onready var label_2: Label = $Label2

func _ready() -> void:
	$BtnJump.grab_focus()

func _process(delta):
	# Keep coin count updated
	label_2.text = "Coins: " + str(GameData.coins)
	
	# Optional: Disable jump button if already bought
	if GameData.has_double_jump:
		$BtnJump.disabled = true
		$BtnJump.text = "Jump Owned"

# --- SIGNALS ---
# Connect the "pressed" signals of your buttons here!

func _on_btn_jump_pressed():
	GameData.purchase_item("double_jump")

func _on_btn_ammo_pressed():
	GameData.purchase_item("throwable")

func _on_btn_close_pressed():
	# UNPAUSE the game and delete menu
	get_tree().paused = false
	queue_free()
