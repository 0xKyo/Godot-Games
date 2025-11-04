extends TextureButton

@export var level_number: String = "1"
@onready var level_label: Label = $MC/VBoxContainer/LevelLabel
@onready var score_label: Label = $MC/VBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_label.text = "%s" % level_number
	score_label.text = str(ScoreManager.get_level_best(level_number))

func _process(delta: float) -> void:
	pass

func _on_mouse_entered() -> void:
	scale = Vector2(1.1, 1.1)


func _on_mouse_exited() -> void:
	scale = Vector2(1.0, 1.0)


func _on_pressed() -> void:
	ScoreManager.level_selected = level_number
	get_tree().change_scene_to_file("res://levels/level_%s.tscn" % level_number)
