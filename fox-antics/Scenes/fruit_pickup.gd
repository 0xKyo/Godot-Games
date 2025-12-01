extends Area2D

@export var points: int = 2
@onready var anim: AnimatedSprite2D = $Anim
@onready var sound: AudioStreamPlayer2D = $Sound

func _ready() -> void:
	# Pick up a random animation
	var ln: Array[String] = []
	for anim_name in anim.sprite_frames.get_animation_names():
		ln.push_back(anim_name)
	anim.animation = ln.pick_random()
	anim.play()


func _on_area_entered(area: Area2D) -> void:
	hide()
	set_deferred("monitoring", false)
	sound.play()

func _on_sound_finished() -> void:
	queue_free()
