class_name Settings
extends Resource

var camera_invert_x : bool
var camera_invert_y : bool
var volume : float

func _init():
	camera_invert_x = false
	camera_invert_y = false
	volume = 0.5
