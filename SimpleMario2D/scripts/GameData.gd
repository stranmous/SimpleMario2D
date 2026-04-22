extends Node

var coins = 0
var has_double_jump: bool = false
var throwable_ammo: int = 10


signal coin_collected

func add_coins():
	coins += 1
	coin_collected.emit()

func reset_coins():
	coins = 0

func purchase_item(item_name: String) -> bool:
	if item_name == "double_jump":
		if coins >= 30 and not has_double_jump:
			coins -= 30
			has_double_jump = true
			return true
			
	elif item_name == "throwable":
		if coins >= 15:
			coins -= 15
			throwable_ammo += 5
			return true
			
	return false
