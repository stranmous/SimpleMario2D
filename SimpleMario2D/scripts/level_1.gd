extends Node2D

@onready var progress_bar: ProgressBar = $UI/PlayerInfoBox/ProgressBar
@onready var player: CharacterBody2D = $player
@onready var finish: Area2D = $Finish


var total_level_distance : float
var highest_progress_reached : float = 0.0

func _ready():
	# global_position includes both X and Y automatically
	total_level_distance = player.global_position.distance_to(finish.global_position)
	
	# Setup Progress Bar
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	progress_bar.value = 0

func _process(delta):
	if total_level_distance == 0: return

	var distance_to_exit = player.global_position.distance_to(finish.global_position)
	
	var current_progress = 1.0 - (distance_to_exit / total_level_distance)
	
	if current_progress > highest_progress_reached:
		highest_progress_reached = current_progress

	progress_bar.value = clamp(highest_progress_reached * 100, 0, 100)
