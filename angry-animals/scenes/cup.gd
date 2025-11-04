extends StaticBody2D

class_name Cup

static var num_cups: int = 0
@onready var vanish_sound: AudioStreamPlayer2D = $VanishSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	num_cups += 1

func die() -> void:
	vanish_sound.play()
	animation_player.play("vanish")
	animation_player.animation_finished.connect(_on_animation_finish)

func _on_animation_finish(anim_sname: StringName):
	num_cups -= 1
	SignalHub.emit_on_cup_destroyed(num_cups)
	queue_free()
