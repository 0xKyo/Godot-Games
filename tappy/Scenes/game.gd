extends Node2D

const PIPES = preload("uid://d0upfvhh12lem")

@onready var upper_point: Marker2D = $UpperPoint
@onready var lower_point: Marker2D = $LowerPoint
@onready var pipes_holder: Node = $PipesHolder

@onready var game: Node2D = $"."
@onready var spawn_timer: Timer = $SpawnTimer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.timeout.connect(spawn_pipes)

func _enter_tree() -> void:
	SignalHub.on_plane_died.connect(_on_plane_died)

func spawn_pipes() -> void:
	var pipes = PIPES.instantiate()
	var y_pos : float = randf_range(upper_point.position.y, lower_point.position.y)
	pipes.position = Vector2(upper_point.position.x, y_pos)
	pipes_holder.add_child(pipes)

func _on_plane_died() -> void:
	get_tree().paused = true
