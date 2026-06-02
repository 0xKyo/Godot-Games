class_name SaveFile
extends Node

const SETTINGS_PATH : String = "user://settings.tres"
const PROGRESS_PATH : String = "user://progress.res"

var settings : Settings
var progress : Progress

func _ready():
	if ResourceLoader.exists(SETTINGS_PATH):
		settings = ResourceLoader.load(SETTINGS_PATH)
	else:
		settings = Settings.new()
		ResourceSaver.save(settings, SETTINGS_PATH)

func save_settings():
	ResourceSaver.save(settings, SETTINGS_PATH)

func save_file_exists() -> bool:
	return ResourceLoader.exists(PROGRESS_PATH)
	progress = Progress.new()
	
func new_game():
	progress = Progress.new()
	
func save_game():
	ResourceSaver.save(progress, PROGRESS_PATH)

func load_game():
	progress = ResourceLoader.load(PROGRESS_PATH)
