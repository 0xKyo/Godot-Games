extends CharacterBody2D

class_name Player

const JUMP = preload("uid://c0esc5pejr7pa")
const DAMAGE = preload("uid://cb87hnh5qv2q4")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel
@onready var shooter: Shooter = $Shooter
@onready var sound: AudioStreamPlayer2D = $Sound
@onready var hurt_timer: Timer = $HurtTimer
@onready var animation_tree: AnimationTree = $AnimationTree

const GRAVITY: float = 690.0
const JUMP_SPEED: float  = -270.0
const RUN_SPEED: float  = 120.0
const MAX_FALL: float = 350.0
const HURT_JUMP_VELOCITY: Vector2 = Vector2(0, -130)

var _invincible: bool = false
var _is_hurt: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func  _unhandled_input(event: InputEvent) -> void:
	if event.is_action("shoot"):
		var dir: Vector2 = Vector2.LEFT if sprite_2d.flip_h else Vector2.RIGHT
		shooter.shoot(dir)

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	get_input()

	velocity.y = clamp(velocity.y, JUMP_SPEED, MAX_FALL)
	move_and_slide()
	update_debug_label()
	fallen_off()

func get_input() -> void:
	if _is_hurt:
		return
		
	# Jump check
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		play_effect(JUMP)
		velocity.y = JUMP_SPEED

	velocity.x = RUN_SPEED * Input.get_axis("left", "right")

	# Check to flip the sprite
	if not is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0

func fallen_off() -> void:
	if global_position.y > Constants.FALL_OFF_Y:
		queue_free()
		
func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)
	
func update_debug_label() -> void:
	var ds: String = ""
	ds += "Floor:%s \n" % [is_on_floor()]
	ds += "State:%s \n" % [ animation_tree.get("parameters/playback").get_current_node()]
	ds += "V:%.1f,%.1f \n" % [velocity.x, velocity.y]
	ds += "P:%.1f,%.1f \n" % [global_position.x, global_position.y]
	debug_label.text = ds

func apply_hurt_jump() -> void:
	_is_hurt = true
	velocity = HURT_JUMP_VELOCITY
	hurt_timer.start()
	play_effect(DAMAGE)

func play_effect(effect: AudioStream) -> void:
	sound.stop()
	sound.stream = effect
	sound.play()
	

func go_invincible() -> void:
	if _invincible:
		return
	_invincible = true
	var tween: Tween = create_tween()
	for i in range(3):
		tween.tween_property(sprite_2d, "modulate", Color("#ffffff", 0), 0.5)
		tween.tween_property(sprite_2d, "modulate", Color("#ffffff", 1.0), 0.5)
	tween.tween_property(self, "_invincible", false, 0)
	
func apply_hit() -> void:
	if _invincible:
		return
	go_invincible()
	apply_hurt_jump()

func _on_hitbox_area_entered(area: Area2D) -> void:
	call_deferred("apply_hit")

func _on_hurt_timer_timeout() -> void:
	_is_hurt = false
