extends RigidBody2D

class_name Animal

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var arrow: Sprite2D = $Arrow
@onready var debug_label: Label = $DebugLabel
@onready var kick_sound: AudioStreamPlayer2D = $KickSound
@onready var stretch_sound: AudioStreamPlayer2D = $StretchSound
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound

enum AnimalState { Ready, Drag, Release }

const DRAG_LIM_MAX: Vector2 = Vector2(0, 60)
const DRAG_LIM_MIN: Vector2 = Vector2(-60, 0)
const IMPULSE_MULT: float = 20.0
const IMPULSE_MAX: float = 1200.0

var  _state: AnimalState = AnimalState.Ready
var _start: Vector2 = Vector2.ZERO
var _drag_start: Vector2 = Vector2.ZERO
var _dragged_vector: Vector2 = Vector2.ZERO
var _arrow_scale_x: float = 0.0

func _unhandled_input(event: InputEvent) -> void:
	if _state == AnimalState.Drag and event.is_action_released("drag"):
		# We need to defer the call to sync with the physical process
		# Else we may have problems
		call_deferred("change_state", AnimalState.Release)

func _ready() -> void:
	# Connect Events
	input_event.connect(_on_input_event)
	visible_on_screen_notifier_2d.screen_exited.connect(_on_screen_exit)
	sleeping_state_changed.connect(_on_sleeping_state_changed)
	body_entered.connect(_on_body_entered)
	
	#Setup the rest of the 
	setup()
	
func setup():
	_arrow_scale_x = arrow.scale.x
	arrow.hide()
	_start = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_state()
	update_debug_label()

func die():
	SignalHub.emit_on_animal_died()
	queue_free()
	
#region debug
func update_debug_label() -> void:
	var ds: String = "ST: %s SL: %s FR: %s\n" % [
		AnimalState.keys()[_state], sleeping, freeze
	]
	ds += "[%.1f, %.1f] " % [_drag_start.x, _drag_start.y]
	ds += "[%.1f, %.1f] " % [_dragged_vector.x, _dragged_vector.y]
	debug_label.text = ds
#endregion

#region state
func update_state() -> void:
	match _state:
		AnimalState.Drag:
			handle_dragging()

func change_state(new_state: AnimalState) -> void:
	if _state == new_state:
		return

	_state = new_state

	match _state:
		AnimalState.Drag:
			start_dragging()
		AnimalState.Release:
			start_release()
			
#endregion

#region drag

func update_arrow() -> void:
	var imp_len: float = calculate_impulse().length()
	var perc: float = clamp(imp_len / IMPULSE_MAX, 0.0, 1.0)
	arrow.scale.x = lerp(_arrow_scale_x, _arrow_scale_x * 2, perc)
	arrow.rotation = (_start - position).angle()

func start_dragging() -> void:
	arrow.show()
	_drag_start = get_global_mouse_position()
	
func handle_dragging() -> void:
	var new_drag_vector: Vector2 = get_global_mouse_position() - _drag_start

	# We clamp it to our drag limits
	new_drag_vector = new_drag_vector.clamp(DRAG_LIM_MIN, DRAG_LIM_MAX)
	
	# Check if it changed to play the sound
	# Update the dragged vector and animal position
	var diff: Vector2 = new_drag_vector - _dragged_vector
	if diff.length() > 0:
		_dragged_vector = new_drag_vector
		position = _start + _dragged_vector
		
		if not stretch_sound.playing:
			stretch_sound.play()
	
	# And we update the arrow
	update_arrow()

#endregion

#region release
func start_release() -> void:
	arrow.hide()
	launch_sound.play()
	freeze = false
	apply_central_impulse(calculate_impulse())
	SignalHub.emit_on_attempt_made()
	
func calculate_impulse() -> Vector2:
	return _dragged_vector * -IMPULSE_MULT
#endregion

#region signals
func _on_sleeping_state_changed() -> void:
	if sleeping:
		for body in get_colliding_bodies():
			if body is Cup:
				body.die()
		call_deferred("die")

func _on_body_entered(body: Node) -> void:
	if body is Cup and not kick_sound.playing:
		kick_sound.play()

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("drag") and _state == AnimalState.Ready:
		change_state(AnimalState.Drag)

func _on_screen_exit():
	print("Screen exit")
	die()

#endregion
