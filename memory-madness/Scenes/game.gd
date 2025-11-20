extends Control

const MEMORY_TILE = preload("uid://cc8rj0l0i1qqi")
@onready var grid_container: GridContainer = $HB/GridContainer
@onready var sound: AudioStreamPlayer = $Sound
@onready var scorer: Scorer = $Scorer
@onready var moves_label: Label = $HB/MC/VB/HB/MovesLabel
@onready var pairs_label: Label = $HB/MC/VB/HB2/PairsLabel

func _enter_tree() -> void:
	SignalHub.on_level_selected.connect(on_level_selected)
	
func add_memory_tile(image: Texture2D, frame: Texture2D) -> void:
	var mt: MemoryTile = MEMORY_TILE.instantiate()
	grid_container.add_child(mt)
	mt.setup(image, frame)
	
func on_level_selected(level_num: int) -> void:
	var lds: LevelDataSelector = LevelDataSelector.get_level_select(level_num)
	
	var fi: Texture2D = ImageManager.get_random_frame_image()
	grid_container.columns = lds.get_num_cols()
	
	for im in lds.get_selected_images():
		add_memory_tile(im, fi)
		
	scorer.clear_new_game(lds.get_target_pairs())

func _on_exit_button_pressed() -> void:
	for t in grid_container.get_children():
		t.queue_free()
	
	SoundManager.play_button_click(sound)
	SignalHub.emit_on_game_exit_pressed()
	
func _process(delta: float) -> void:
	moves_label.text = scorer.get_moves_made_str()
	pairs_label.text = scorer.get_pairs_made_str()
