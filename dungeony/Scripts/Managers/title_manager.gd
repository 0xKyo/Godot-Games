extends SceneManager

@onready var _menu_buttons: VBoxContainer = $MarginContainer/MenuButtons

func _ready():
	super._ready()
	_menu_buttons.open()

func _on_new_game_pressed() -> void:
	await _fade.to_black()
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_continue_pressed() -> void:
	print("Continue Pressed")


func _on_settings_pressed() -> void:
	print("Settings Pressed")


func _on_credits_pressed() -> void:
	print("Credits Pressed")


func _on_exit_pressed() -> void:
	print("Exit Pressed")
	
