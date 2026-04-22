extends CharacterBody2D

var HEALTH = 100
const SPEED = 100.0
const JUMP_VELOCITY = -300.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


@onready var animated_sprite = $AnimatedSprite2D

### NEW: VARIABLES FOR UPGRADES ###
# IMPORTANT: Change this path if your fireball was saved somewhere else!
const FIREBALL_SCENE = preload("res://scenes/fireball.tscn")
# Variables for double jump tracking
var jump_count = 0
var max_jumps = 1
###################################


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- UPDATED JUMP LOGIC ---
	
	### NEW: Update max jumps based on global purchase ###
	if GameData.has_double_jump:
		max_jumps = 2
	else:
		max_jumps = 1

	# Reset jump count when landing
	if is_on_floor():
		jump_count = 0
		
	# Handle Jump (Modified to support double jump)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			# Standard first jump
			velocity.y = JUMP_VELOCITY
			jump_count = 1
		elif jump_count < max_jumps and jump_count > 0:
			# Double jump (only if in air AND have jumps left)
			velocity.y = JUMP_VELOCITY
			jump_count += 1
	# --------------------------

	# --- NEW SHOOTING INPUT ---
	### NEW: Check for shoot input based on Input Map settings ###
	if Input.is_action_just_pressed("shoot"):
		if GameData.throwable_ammo > 0:
			shoot_fireball()
			GameData.throwable_ammo -= 1
			print("Fired! Ammo left: ", GameData.throwable_ammo)
		else:
			print("Click! Out of ammo.")
	# --------------------------


	# Get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

### NEW FUNCTION: SHOOTING LOGIC ###
func shoot_fireball():
	var fireball = FIREBALL_SCENE.instantiate()
	
	# Determine direction first
	var dir = 1
	if animated_sprite.flip_h == true: 
		dir = -1
	fireball.direction = dir

	# --- NEW SPAWN POSITION ---
	# Start at player's center
	fireball.position = global_position 
	# Add an offset: move it 30 pixels in the direction it's facing
	# Adjust '30' to be bigger if your player sprite is wide.
	fireball.position.x += 30 * dir 
	# --------------------------

	get_tree().current_scene.add_child(fireball)
