extends Resource

class_name ResourceList

@export var file_names: Array[String]

func add_file(fn: String) -> void:
	if not fn.ends_with(".import"):
		file_names.append(fn)
