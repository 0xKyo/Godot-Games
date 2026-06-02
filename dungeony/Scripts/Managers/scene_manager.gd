class_name SceneManager
extends Node

@export var _background_music : AudioStream
@export var _fade: ColorRect

@warning_ignore("unused_private_class_variable")
@export var _settings_menu : Menu

func _ready():
	Music.play_track(_background_music)

func change_scenes(path: String):
	await _fade.to_black()
	Music.fade_out()
	get_tree().paused = false
	get_tree().change_scene_to_file(path)
