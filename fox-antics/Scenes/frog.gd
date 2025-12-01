extends EnemyBase

const JUMP_VELOCITY_R: Vector2 = Vector2(100, -150)
const JUMP_VELOCITY_L: Vector2 = Vector2(-100, -150)
var _seen_player: bool = false
var _can_jump: bool = false
@onready var jump_timer: Timer = $JumpTimer

func _ready():
	super._ready()
	jump_timer.timeout.connect(_on_jump_timer_tiemeout)

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += delta * _gravity
	
	# Check for jumping
	apply_jump()
	move_and_slide()
	
	# Always have the frog facing the player
	flip_me()
	
	# Check when landing to switch to idle and stop it
	if is_on_floor():
		velocity.x = 0
		animated_sprite_2d.play("idle")

func apply_jump() -> void:
	if not is_on_floor() or not _can_jump:
		return
		
	if not _seen_player:
		return
	
	velocity = JUMP_VELOCITY_R if animated_sprite_2d.flip_h else JUMP_VELOCITY_L
	_can_jump = false
	start_timer()
	animated_sprite_2d.play("jump")
	
func start_timer() -> void:
	#Start timer with a random wait time 
	jump_timer.wait_time = randf_range(2.0, 3.0)
	jump_timer.start()

func on_visible_on_screen() -> void:
	if not _seen_player:
		_seen_player = true
		start_timer()

func _on_jump_timer_tiemeout() ->void:
	_can_jump = true
