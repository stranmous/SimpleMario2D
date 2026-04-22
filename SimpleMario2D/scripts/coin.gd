extends Area2D

@onready var sfx: AudioStreamPlayer2D = $SFX


func _on_body_entered(body):
	if body.is_in_group("player"):
		GameData.add_coins()
		# Create a temporary sound player at the scene root
		var p := AudioStreamPlayer2D.new()
		p.stream = sfx.stream
		p.global_position = global_position
		get_tree().current_scene.add_child(p)
		p.play()

		# Remove the coin instantly
		queue_free()

		# Clean up the temporary audio after it finishes
		var length := p.stream.get_length() if p.stream else 0.2
		get_tree().create_timer(length).timeout.connect(func(): p.queue_free())
