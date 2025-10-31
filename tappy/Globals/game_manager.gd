extends Node

const GAME = preload("uid://rqa6xe2fs2sb")
const MAIN = preload("uid://dvhgtnvkrjgoa")
const SIMPLE_TRANSITION = preload("uid://dwklcfaigyllc")
const COMPLEX_TRANSITION = preload("uid://to12jjicp5uo")

var next_scene: PackedScene

func add_complex() -> void:
	var ct = COMPLEX_TRANSITION.instantiate()
	add_child(ct)
	
func load_game_scene() -> void:
	next_scene = GAME
	add_complex()
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	
func load_main_scene() -> void:
	next_scene = MAIN
	add_complex()
	get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
