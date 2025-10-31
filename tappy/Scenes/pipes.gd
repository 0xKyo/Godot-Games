extends Node2D

const SPEED: float = 120.0

@onready var laser: Area2D = $Laser
@onready var lower: Area2D = $Lower
@onready var upper: Area2D = $Upper

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lower.body_entered.connect(on_pipe_entered)
	upper.body_entered.connect(on_pipe_entered)
	laser.body_entered.connect(_on_laser_entered)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= SPEED * delta
	pass

func on_screen_exited() -> void:
	set_process(false)
	queue_free()
	
func on_pipe_entered(body: Node2D) -> void:
	if body is Tappy:
		body.die()

func _on_laser_entered(body: Node2D) -> void:
	if body is Tappy:
		SignalHub.on_point_scored.emit()
