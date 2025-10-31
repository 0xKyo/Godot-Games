extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)

func switch_scene() -> void:
	get_tree().change_scene_to_packed(GameManager.next_scene)

func _on_animation_finished(anim_name: StringName):
	queue_free()
