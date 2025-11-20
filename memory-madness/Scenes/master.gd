extends Control

@onready var music: AudioStreamPlayer = $Music
@onready var game: Control = $Game
@onready var main: Control = $Main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_MAIN_MENU)
	show_game(false)
	
	SignalHub.on_level_selected.connect(on_level_selected)
	SignalHub.on_game_exit_pressed.connect(on_game_exit)

func show_game(showGame: bool) -> void:
	game.visible = showGame
	main.visible = !showGame

func on_level_selected(_level_num: int) -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_IN_GAME)
	show_game(true)
	
func on_game_exit() -> void:
	SoundManager.play_sound(music, SoundManager.SOUND_MAIN_MENU)
	show_game(false)
	
