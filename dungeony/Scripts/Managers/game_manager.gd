class_name GameManager
extends SceneManager

@onready var _player = $Player
@onready var _pause_menu: Menu = $UI/PauseMenu
@onready var _current_level: Level
@onready var _character: CharacterBody3D = $Barbarian

func _ready():
	load_level()
	super._ready()
	
func load_level():
	if _current_level:
		File.save_game()
		await _fade.to_black()
		_current_level.queue_free()

	# load the next level
	_current_level = load("res://Scenes/Levels/" + File.progress.current_level + ".tscn").instantiate()
	add_child(_current_level)
	
	_character.position = _current_level.get_entrance(File.progress.transition_id)
	_player.face_direction(_current_level.get_forward_direction(File.progress.transition_id))

	# We need to wait one frame to activate transitions
	await _fade.to_clear()
	_current_level.activate_transitions()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		_pause_menu.open()
	else:
		_pause_menu.close()

func _on_exit_pressed() -> void:
	change_scenes("res://Scenes/title.tscn")

func _on_settings_pressed() -> void:
	_settings_menu.open(_pause_menu)
