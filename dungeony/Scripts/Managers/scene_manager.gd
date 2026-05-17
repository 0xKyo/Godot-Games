class_name SceneManager
extends Node

@export var _background_music : AudioStream
@export var _fade: ColorRect
@export var _settings_menu : Menu

func _ready():
	Music.play_track(_background_music)
	_fade.to_clear()

func change_scenes(path: String):
	await _fade.to_black()
	Music.fade_out()
	get_tree().paused = false
	get_tree().change_scene_to_file(path)
