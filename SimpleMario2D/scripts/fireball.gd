extends Area2D

var speed = 400

var direction = 1 # 1 = Right, -1 = Left

func _physics_process(delta):
	# Move in the set direction
	position.x += speed * direction * delta




func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free() # Destroy the enemy
		queue_free()      # Destroy the fireball itself
	elif not body.is_in_group("player"):
		# If we hit a wall or floor (but not the player), destroy the fireball
		queue_free() # Replace with function body.
