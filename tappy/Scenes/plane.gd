extends CharacterBody2D

class_name Tappy

@onready var engine_sound: AudioStreamPlayer2D = $EngineSound
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

const JUMP_POWER: float = -350
var _gravity: float = ProjectSettings.get("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	fly(delta)
	move_and_slide()

	if is_on_floor():
		die()

func fly(delta: float) -> void:
	velocity.y += _gravity * delta
	
	# Override the Y velocty when we jump
	if Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_POWER
		animation_player.play("fly")

func die() -> void:
	engine_sound.stop()
	SignalHub.on_plane_died.emit()
	animated_sprite_2d.stop()
	set_physics_process(false)
