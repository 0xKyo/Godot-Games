class_name Transition
extends Area3D

@export var _connects_to : String
@export var _transition_id: int

@onready var entrance: Marker3D = $Entrance

func activate() -> void:
	monitoring = true
	
func _on_body_entered(_body: Node3D) -> void:
	File.progress.transition_id = _transition_id
	File.progress.current_level = _connects_to
	$/root/Game.load_level()
