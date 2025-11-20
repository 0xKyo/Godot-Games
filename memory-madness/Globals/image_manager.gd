extends Node

const FRAME_IMAGES: Array[Texture2D] = [
	preload("uid://djiid52et2mgs"),
	preload("uid://u2onw2kk2i4a"),
	preload("uid://b4s2abjgahhtg"),
	preload("uid://bxymyan3uumym")
]

var _image_list: Array[Texture2D]

func _enter_tree() -> void:
	var ifl: ResourceList = load("res://Resources/image_resources_list.tres")
	for file in ifl.file_names:
		_image_list.append(load(file))

func get_random_frame_image() -> Texture2D:
	return FRAME_IMAGES.pick_random()

func get_random_item_image() -> Texture2D:
	return _image_list.pick_random()
	
func get_image(index: int) -> Texture2D:
	return _image_list[index]

func shuffle_images() -> void:
	_image_list.shuffle()
