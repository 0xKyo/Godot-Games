extends Node2D

const ANIMAL = preload("uid://daanafqeo0wv2")
const MAIN = preload("uid://dir4n0opm4iyp")

@onready var animal_start: Marker2D = $AnimalStart

func _ready() -> void:
	SignalHub.on_animal_died.connect(spawn_animal)
	spawn_animal()

func spawn_animal() -> void:
	var animal: Animal = ANIMAL.instantiate()
	animal.position = animal_start.position
	add_child(animal)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().change_scene_to_packed(MAIN)
