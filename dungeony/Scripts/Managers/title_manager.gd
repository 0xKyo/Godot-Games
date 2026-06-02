class_name TitleManager
extends SceneManager

@onready var _continue: Button = $MarginContainer/MenuButtons/Continue
@onready var _menu_buttons: Menu = $MarginContainer/MenuButtons

func _ready():
	if File.save_file_exists():
		_continue.disabled = false
		_continue.grab_focus()
		
	super._ready()
	_fade.to_clear()
	_menu_buttons.open()

func _on_new_game_pressed() -> void:
	File.new_game()
	change_scenes("res://Scenes/game.tscn")

func _on_continue_pressed() -> void:
	File.load_game()
	change_scenes("res://Scenes/game.tscn")

func _on_settings_pressed() -> void:
	_settings_menu.open(_menu_buttons)

func _on_credits_pressed() -> void:
	print("Credits Pressed")

func _on_exit_pressed() -> void:
	await _fade.to_black()
	get_tree().quit()
	
