extends Node2D

@onready var progress_bar: ProgressBar = $UI/PlayerInfoBox/ProgressBar
@onready var player: CharacterBody2D = $player
@onready var finish: Area2D = $Finish


var total_level_distance : float
var highest_progress_reached : float = 0.0 # Stores our "high score" for progress

func _ready():
# 1. Calculate the full straight-line distance from Start to End (Hypotenuse)
	# global_position includes both X and Y automatically
	total_level_distance = player.global_position.distance_to(finish.global_position)
	
	# Setup Progress Bar
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	progress_bar.value = 0

func _process(delta):
	if total_level_distance == 0: return

	# 2. Calculate how far the player is CURRENTLY from the exit
	var distance_to_exit = player.global_position.distance_to(finish.global_position)
	
	# 3. Calculate the raw percentage
	# Logic: If total is 100m, and we are 20m from exit, we have traveled 80%.
	# (1.0 - (20 / 100)) = 0.8
	var current_progress = 1.0 - (distance_to_exit / total_level_distance)
	
	# 4. THE RATCHET: Only update if we have beaten our previous best
	if current_progress > highest_progress_reached:
		highest_progress_reached = current_progress

	# 5. Update the bar using the "highest" value, not the current value
	# clamp ensures we don't go below 0 or above 100
	progress_bar.value = clamp(highest_progress_reached * 100, 0, 100)
