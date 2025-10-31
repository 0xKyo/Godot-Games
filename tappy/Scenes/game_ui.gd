extends Control

const GAME_OVER = preload("uid://wjnyhwhbyrd")

@onready var press_space_label: Label = $MarginContainer/PressSpaceLabel
@onready var game_over_label: Label = $MarginContainer/GameOverLabel
@onready var timer: Timer = $Timer
@onready var score_label: Label = $MarginContainer/ScoreLabel
@onready var sound: AudioStreamPlayer2D = $Sound

var _can_press: bool = false
var _score: int = 0

func _ready() -> void:
	_score = 0
	
func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)
	SignalHub.on_point_scored.connect(_on_point_scored)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		GameManager.load_main_scene()
	elif _can_press and event.is_action_pressed("jump"):
		GameManager.load_main_scene()

func _on_plane_died() -> void:
	# Play game over sound
	sound.stop()
	sound.stream = GAME_OVER
	sound.play()
	
	# Show game over and then press start
	game_over_label.show()
	timer.timeout.connect(_on_timeout)
	timer.start()

func _on_timeout() -> void:
	_can_press = true
	timer.timeout.disconnect(_on_timeout)
	game_over_label.hide()
	press_space_label.show()

func _on_point_scored() -> void:
	sound.play()
	_score += 1
	score_label.text = "%04d" % _score
	ScoreManager.high_score = _score
