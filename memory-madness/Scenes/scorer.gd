extends Node

class_name Scorer

static var SelectionEnabled: bool = true
@onready var sound: AudioStreamPlayer = $Sound
@onready var timer: Timer = $Timer

var _selections: Array[MemoryTile]
var _target_pairs: int = 0
var _moves_made: int = 0
var _pairs_made: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHub.on_tile_selected.connect(on_tile_selected)
	SignalHub.on_game_exit_pressed.connect(func(): timer.stop())

func clear_new_game(target_pairs: int) -> void:
	_selections.clear()
	_target_pairs = target_pairs
	_moves_made = 0
	_pairs_made = 0
	SelectionEnabled = true
	
func check_for_pair(tile1: MemoryTile, tile2: MemoryTile) -> void:
	_moves_made += 1
	if tile1.matches_other_tile(tile2):
		tile1.kill_on_succcess()
		tile2.kill_on_succcess()
		SoundManager.play_sound(sound, SoundManager.SOUND_SUCCESS)
		_pairs_made += 1
	
func process_pair() -> void:
	if _selections.size () != 2:
		return
	
	SelectionEnabled = false
	timer.start()
	check_for_pair(_selections[0], _selections[1])

func check_game_over() -> void:
	if _pairs_made == _target_pairs:
		SelectionEnabled = false
		SignalHub.emit_on_game_over(_moves_made)

func on_tile_selected(tile: MemoryTile) -> void:
	#Check t don't double select the same tile
	if tile in _selections:
		return
	
	#We select the taile and play a sound
	_selections.append(tile)
	SoundManager.play_tile_click(sound)
	
	#Now we check if we need to process pairs
	process_pair()

func _on_timer_timeout() -> void:
	for s in _selections:
		s.reveal(false)
	_selections.clear()
	SelectionEnabled = true
	check_game_over()
	
func get_moves_made_str() -> String:
	return str(_moves_made)
	
func get_pairs_made_str() -> String:
	return "%d/%d" % [_pairs_made, _target_pairs]
