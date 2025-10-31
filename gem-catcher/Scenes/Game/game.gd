extends Node2D

const GEM = preload("res://Scenes/Gem/gem.tscn")
const EXPLODE = preload("uid://dsb4xleejwahp")
const MARGIN: float = 20.0

@onready var timer: Timer = $Timer
@onready var paddle: Area2D = $Paddle
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var score_label: Label = $ScoreLabel

#Private
var _score: int = 0

func _ready() -> void:
	spawn_gem()
	
func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_pos: float = randf_range(get_viewport_rect().position.x + MARGIN, get_viewport_rect().end.x - MARGIN)
	new_gem.position = Vector2(x_pos, -50.0)
	new_gem.gem_off_screen.connect(_on_gem_off_screen)
	add_child(new_gem)
	
func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 1
	score_label.text = "%03d" % _score
	score_sound.position = area.position
	score_sound.play()

func _on_timer_timeout() -> void:
	spawn_gem()

func _on_gem_off_screen() -> void:
	print("End Game")
	stop_all()

func stop_all() -> void:
	sound.stop()
	sound.stream = EXPLODE
	sound.play()
	
	timer.stop()
	for child in get_children():
		if child is Gem:
			child.set_process(false)

	paddle.set_process(false)
