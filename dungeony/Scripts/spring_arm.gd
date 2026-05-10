extends SpringArm3D

@export var _rotation_speed : float = 1
@export var _min_x_rotation: float = -PI/3
@export var _max_y_rotation: float = PI/3

func look(direction: Vector2):
	#vertical y rotation
	var invert_x: int = (-1 if File.settings.camera_invert_x else 1)
	rotation.x += direction.y * get_process_delta_time() * _rotation_speed * invert_x
	rotation.x = clampf(rotation.x, _min_x_rotation, _max_y_rotation)
	
	#horizontal x rotation
	var invert_y: int = (-1 if File.settings.camera_invert_y else 1)
	rotation.y += direction.x * get_process_delta_time() * _rotation_speed * invert_y
