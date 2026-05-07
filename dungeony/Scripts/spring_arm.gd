extends SpringArm3D

@export var _rotation_speed : float = 1

func look(direction: Vector2):
	rotation.x += -direction.y * get_process_delta_time() * _rotation_speed
	rotation.x = clampf(rotation.x, -PI/3, PI/3)
	
	rotation.y += -direction.x * get_process_delta_time() * _rotation_speed
