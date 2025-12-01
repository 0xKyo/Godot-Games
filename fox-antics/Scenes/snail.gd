extends EnemyBase

@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var debug_label: Label = $DebugLabel

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += delta * _gravity
	velocity.x = speed if animated_sprite_2d.flip_h == true else -speed
	
	move_and_slide()
	flip_me()
	update_debug_label()

func flip_me() -> void:
	if is_on_wall() or not ray_cast_2d.is_colliding():
		animated_sprite_2d.flip_h = !animated_sprite_2d.flip_h
		ray_cast_2d.position.x = -ray_cast_2d.position.x

func update_debug_label() -> void:
	var ds: String = ""
	ds += "Raycast:%s \n" % [ray_cast_2d.is_colliding()]	
	debug_label.text = ds
