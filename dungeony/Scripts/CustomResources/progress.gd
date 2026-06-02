class_name Progress
extends Resource

@export var player_name : String
@export var current_health: int
@export var current_level: String
@export var transition_id: int

func _init():
	current_level = "dungeon1"
	player_name = "Guy"
	current_health = 100
	transition_id = 0
	
#var level_completed : Array[bool]
