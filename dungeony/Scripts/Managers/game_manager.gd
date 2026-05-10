extends SceneManager

@onready var _pause_menu: VBoxContainer = $UI/PauseMenu

func toggle_pause():
	get_tree().paused = !get_tree().paused
	if get_tree().paused:
		_pause_menu.open()
	else:
		_pause_menu.close()

func _on_exit_pressed() -> void:
	await _fade.to_black()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/title.tscn")
