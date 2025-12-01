extends Node2D

const OBJECT_SCENES: Dictionary[Constants.ObjectType, PackedScene] = {
	Constants.ObjectType.BULLET_PLAYER: preload("uid://clofq3kcus67l"),
	Constants.ObjectType.BULLET_ENEMY: preload("uid://oqqd1aj7rbgi"),
	Constants.ObjectType.EXPLOSION: preload("uid://dq61a8dybcjnj"),
	Constants.ObjectType.PICKUP: preload("uid://y70vpugefwc8")
}

func _enter_tree() -> void:
	# Create a bullet on a signal
	SignalHub.on_create_bullet.connect(func(pos: Vector2, dir: Vector2, speed:float, obj: Constants.ObjectType):
		if not OBJECT_SCENES.has(obj):
			return
			
		var nb: Bullet = OBJECT_SCENES[obj].instantiate()
		nb.setup(pos, dir, speed)
		call_deferred("add_child", nb)
	)
	
	# Create a object on a signal
	SignalHub.on_create_object.connect(func(pos: Vector2, obj: Constants.ObjectType):
		if not OBJECT_SCENES.has(obj):
			return
			
		var new_obj: Node2D = OBJECT_SCENES[obj].instantiate()
		new_obj.global_position = pos
		call_deferred("add_child", new_obj)
	)
