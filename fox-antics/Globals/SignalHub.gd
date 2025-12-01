extends Node

signal on_create_bullet(pos: Vector2, dir: Vector2, speed: float, obj: Constants.ObjectType)

signal on_create_object(pos: Vector2, float, obj: Constants.ObjectType)

func emit_on_create_bullet(pos: Vector2, dir: Vector2, speed:float, obj: Constants.ObjectType) -> void:
	on_create_bullet.emit(pos, dir, speed, obj)	

func emit_on_create_object(pos: Vector2, obj: Constants.ObjectType) -> void:
	on_create_object.emit(pos,obj)	
