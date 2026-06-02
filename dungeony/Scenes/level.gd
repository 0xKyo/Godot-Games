class_name Level
extends Node3D

@export var _number : int
@onready var _transitions: Array[Node] = $Transitions.get_children()

func get_entrance(transition_index: int) -> Vector3:
	return _transitions[transition_index].entrance.global_position
	
func get_forward_direction(transition_id: int) -> float:
	return _transitions[transition_id].rotation.y
	
func activate_transitions(activate: bool = true) -> void:
	for transition in _transitions:
		transition.activate()
