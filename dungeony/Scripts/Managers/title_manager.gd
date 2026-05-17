class_name TitleManager
extends SceneManager

@onready var _menu_buttons: Menu = $MarginContainer/MenuButtons

func _ready():
	super._ready()
	_menu_buttons.open()

func _on_new_game_pressed() -> void:
	change_scenes("res://Scenes/game.tscn")

func _on_continue_pressed() -> void:
	print("Continue Pressed")

func _on_settings_pressed() -> void:
	_settings_menu.open(_menu_buttons)

func _on_credits_pressed() -> void:
	print("Credits Pressed")

func _on_exit_pressed() -> void:
	print("Exit Pressed")
	
