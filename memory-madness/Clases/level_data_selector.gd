extends Object

class_name LevelDataSelector

const LEVELS_DATA: LevelsDataResource = preload("uid://cf0dd6yo436cg")

#region static
static func get_level_setting(level: int) -> LevelSettingResource:
	return LEVELS_DATA.get_level_data(level)

static func get_level_select(level_numer: int) -> LevelDataSelector:
	# First we get the level setting resource. This is the X/Y size of the level
	var l_setting: LevelSettingResource = get_level_setting(level_numer)
	
	# Early return in case something failed
	if l_setting == null:
		return
	
	# Now we shuffle all our images. Remember our image manager contains all of our images
	ImageManager.shuffle_images()
	
	# Now we are going to get the pairs of images we need for that level
	var selected_images : Array[Texture2D]
	for i in range(l_setting.get_target_pairs()):
		selected_images.append(ImageManager.get_image(i))
		selected_images.append(ImageManager.get_image(i))

	# And now we need to shuffle the selected iamges
	selected_images.shuffle()
	
	return LevelDataSelector.new(l_setting, selected_images)
#endregion

var _selected_images: Array[Texture2D]
var _level_settings: LevelSettingResource

func _init(level_setting: LevelSettingResource, selected_images: Array[Texture2D]) -> void:
	_selected_images = selected_images
	_level_settings = level_setting
	
func get_selected_images() -> Array[Texture2D]:
	return _selected_images
	
func get_target_pairs() -> int:
	return _level_settings.get_target_pairs()
	
func get_num_cols() -> int:
	return _level_settings.get_cols()
