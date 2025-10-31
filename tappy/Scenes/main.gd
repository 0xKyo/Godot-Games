extends Control

const GAME = preload("uid://rqa6xe2fs2sb")
@onready var highscore_text: Label = $MarginContainer/HighscoreText

func _ready()->void:
	get_tree().paused = false
	highscore_text.text = "%04d" % ScoreManager.high_score
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		GameManager.load_game_scene()
