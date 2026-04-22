extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(body):
	print('NOOB')
	Engine.time_scale = 0.3
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	GameData.reset_coins()
	get_tree().current_scene.queue_free()
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
