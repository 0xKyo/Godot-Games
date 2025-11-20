extends Control

@onready var moves_label: Label = $NinePatchRect/VB/MovesLabel

func _ready() -> void:
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_game_exit_pressed.connect(on_game_exit_pressed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_game_over(moves_made: int) -> void:
	moves_label.text = "You took %d moves" % moves_made
	show()

func on_game_exit_pressed() -> void:
	hide()
