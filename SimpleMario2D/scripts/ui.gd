extends CanvasLayer

@onready var coins_label: Label = %CoinsLabel

func _ready():
	# 1. Load the saved count immediately when the level loads
	update_coin_display()

func _process(delta: float) -> void:
	GameData.coin_collected.connect(update_coin_display)

func update_coin_display():
	# Get the value directly from the Global script
	coins_label.text = "     Coins: " + str(GameData.coins)
