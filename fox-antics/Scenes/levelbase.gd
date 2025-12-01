extends Node2D

const ENEMY_BULLET = preload("uid://oqqd1aj7rbgi")
const PLAYER_BULLET = preload("uid://clofq3kcus67l")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("test"):
		var b = PLAYER_BULLET.instantiate()
		add_child(b)
		
