extends CharacterBody2D

class_name EnemyBase

@export var points: int = 1
@export var speed: float = 30.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D
@onready var hit_box: Area2D = $HitBox

var _gravity: float = 800.0
var _player_ref: Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Get player ref
	_player_ref = get_tree().get_first_node_in_group(Constants.PLAYER_GROUP)
	if _player_ref == null:
		queue_free()
	
	# Set up events
	visible_on_screen_notifier_2d.screen_entered.connect(on_visible_on_screen)
	hit_box.area_entered.connect(on_area_entered)
	
func die() -> void:
	SignalHub.emit_on_create_object(global_position, Constants.ObjectType.PICKUP)
	SignalHub.emit_on_create_object(global_position, Constants.ObjectType.EXPLOSION)
	set_physics_process(false)
	queue_free()
	
func _physics_process(delta: float) -> void:
	if global_position.y > Constants.FALL_OFF_Y:
		queue_free()
	pass
	
func on_visible_on_screen() -> void:
	pass
	
func on_area_entered(area: Area2D) -> void:
	die()
	
func flip_me() -> void:
	animated_sprite_2d.flip_h = _player_ref.global_position.x > global_position.x
