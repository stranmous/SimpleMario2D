extends Node2D

const SPEED = 45
var direction = 1

@onready var impact: AudioStreamPlayer2D = $impact
@onready var ray_cast_up: RayCast2D = $RayCastUp
@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite_2d.flip_h = true
	
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite_2d.flip_h = false
	
	if ray_cast_up.is_colliding():
		var p := AudioStreamPlayer2D.new()
		p.stream = impact.stream
		p.global_position = global_position
		get_tree().current_scene.add_child(p)
		p.play()
		
		queue_free()
		
		var length := p.stream.get_length() if p.stream else 0.2
		get_tree().create_timer(length).timeout.connect(func(): p.queue_free())
	
	position.x += direction * SPEED * delta
	
