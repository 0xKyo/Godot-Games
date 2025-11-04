extends Area2D

@onready var collision: CollisionShape2D = $Collision
@onready var splash_sound: AudioStreamPlayer2D = $SplashSound

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	splash_sound.position = body.position
	splash_sound.play()
