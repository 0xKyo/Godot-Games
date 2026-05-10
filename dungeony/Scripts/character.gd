extends CharacterBody3D

@export_category("Locomotion")
@export var _walking_speed : float = 1
@export var _running_speed : float = 2
@export var _acceleration: float = 4
@export var _deceleration: float = 4
@export var _rotation_speed : float = 180
@onready var _movement_speed : float = _walking_speed

@export_category("Jumping")
@export var _min_jump_height : float = 0.5
@export var _max_jump_height : float = 2.5
@export var _air_control : float = 0.5
@export var _air_brake : float = 0.5
@export var _mass : float = 1
@onready var _jump_hold: Timer = $JumpHold

# Object related
@onready var _rig: Node3D = $Rig_Medium
@onready var _animation: AnimationTree = $AnimationTree
@onready var _state_machine : AnimationNodeStateMachinePlayback = _animation["parameters/playback"]

# Calculated values
var _max_jump_velocity: float
var _min_jump_velocity: float
var _gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var _angle_difference : float = 0
var _xz_velocity: Vector3
var _direction : Vector3

func _ready():
	# We get the jump velocity by how hight we want to jump	
	_min_jump_velocity = sqrt(_min_jump_height * _gravity * _mass * 2)
	_max_jump_velocity = sqrt(_max_jump_height * _gravity * _mass * 2)
	
	_rotation_speed = deg_to_rad(_rotation_speed)

func move(direction: Vector3):
	_direction = direction

func walk():
	_movement_speed = _walking_speed

func run():
	_movement_speed = _running_speed
	
func start_jump():
	if is_on_floor():
		_state_machine.travel("Player_Jump_Start")
		_jump_hold.start()
		_jump_hold.paused = false
		
func complete_jump():
	_jump_hold.paused = true

func _apply_jump_velocity():
	_jump_hold.paused = true
	
	# We get how long we pressed the jump button
	var time_pressed: float = min(1 - _jump_hold.time_left, 0.3)
	
	# Now we need to normalize it between 0 and 1 depending on the maximum time which is 0.3
	var hold_amount = time_pressed / 0.3
	
	# And now we apply first the min_jump and whatever else we pressed
	velocity.y = _min_jump_velocity + (_max_jump_velocity - _min_jump_velocity) *  hold_amount
			
func _physics_process(delta: float) -> void:
	_xz_velocity = Vector3(velocity.x, 0, velocity.z)

	if is_on_floor():
		_ground_physics(delta)
	else:
		_air_physics(delta)
		
	# Apply adjusted xz velocity
	velocity.x = _xz_velocity.x
	velocity.z = _xz_velocity.z
	
	move_and_slide()
	
func _ground_physics(delta: float):
	# If the player is getting movement input, face that direction
	if _direction:
		# Figure out the angle in which we want to move and get the difference
		var target_angle : float = atan2(_direction.x, _direction.z)
		_angle_difference = wrapf(target_angle - _rig.rotation.y, -PI, PI)
		
		# Now we slowly rotate in the best direction
		_rig.rotation.y += clamp(_rotation_speed * delta, 0, abs(_angle_difference)) * sign(_angle_difference)
	
	# We need to accelerate and decelerate correctly
	_calculate_velocity(delta, 1, 1)

	_animation.set("parameters/Locomotion/blend_position", _xz_velocity.length() / _running_speed)

func _air_physics(delta: float):
	# Add the gravity.
	velocity.y -= _gravity * _mass * delta
	_calculate_velocity(delta, _air_control, _air_brake)

func _calculate_velocity(delta: float, acelerate_dampen: float, decelerate_dampen: float):
	if _direction:
		# Moving in the same direction as the velocity
		if _direction.dot(velocity) >= 0:
			_xz_velocity = _xz_velocity.move_toward(_direction * _movement_speed, _acceleration * delta * acelerate_dampen)
		# Start turning around
		else:
			_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta * acelerate_dampen)
	# Decelerate
	else:
		_xz_velocity = _xz_velocity.move_toward(Vector3.ZERO, _deceleration * delta * decelerate_dampen)
