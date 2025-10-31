extends Node

const SCORES_PATH: String = "user://tappy.res"

var _high_score: int = 0
var high_score: int:
	get:
		return _high_score
	set(value):
		if value > _high_score:
			_high_score = value
			save_highscore()

func _ready() -> void:
	load_highscore()

func save_highscore() -> void:
	var hsr: HighScoreResource = HighScoreResource.new()
	hsr.high_score = _high_score
	ResourceSaver.save(hsr, SCORES_PATH)

func load_highscore() -> void:
	if ResourceLoader.exists(SCORES_PATH):
		var hsr: HighScoreResource = load(SCORES_PATH)
		if hsr:
			_high_score = hsr.high_score
