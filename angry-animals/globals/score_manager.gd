extends Node

const SCORES_PATH = "user://animals.tres"
var _level_scores: LevelScoreResource

var level_selected: String = "1":
	get:
		return level_selected
	set(value):
		level_selected = value

func _ready() -> void:
	load_scores()
	
func load_scores() -> void:
	if ResourceLoader.exists(SCORES_PATH) == true:
		_level_scores = load(SCORES_PATH)
	# Check if we loaded something
	if not _level_scores:
		_level_scores = LevelScoreResource.new()

func save_scores() -> void:
	ResourceSaver.save(_level_scores, SCORES_PATH)
	
func get_level_best(level: String) -> int:
	return _level_scores.get_level_best(level)

func set_score_for_level(level: String, score: int) -> void:
	_level_scores.update_level_score(level, score)
	save_scores()
