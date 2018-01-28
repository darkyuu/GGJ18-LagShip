extends AnimatedSprite

func _ready():
	pass

func _on_BlackHole_animation_finished():
	hide()
	queue_free()