extends Control

var _attempts = -1

@onready var attempts_label: Label = $MarginContainer/VBoxContainer/AttemptsLabel
@onready var vb_game_over: VBoxContainer = $MarginContainer/VBGameOver
@onready var level_label: Label = $MarginContainer/VBoxContainer/LevelLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "Level %s" % ScoreManager.level_selected
	
	_attempts += 1
	attempts_label.text = "Attempts %s" % _attempts
	
	SignalHub.on_attempt_made.connect(on_attempt_made)
	SignalHub.on_cup_destroyed.connect(on_cup_destroyed)

func on_attempt_made() :
	_attempts += 1
	attempts_label.text = "Attempts %s" % _attempts
	
func on_cup_destroyed(remaining_cups: int):
	if remaining_cups == 0:
		vb_game_over.show()
		ScoreManager.set_score_for_level(
			ScoreManager.level_selected, _attempts
		)
