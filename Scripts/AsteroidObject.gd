extends RigidBody2D

var velocity = Vector2()
var rotation_speed
var extents = Vector2()

func _ready():
	add_to_group("asteroids")
	$ExplosionSpriteEffect.visible = false;

func _process(delta):
	if Global.paused == true:
		sleeping = true
	
func explode_itself():
	$Sprite.visible = false
	$ExplosionSpriteEffect.visible = true;
	$ExplosionSpriteEffect.play()
#	var exlp = explosion.instance()
#	add_child(exlp)
#	exlp.set_position(get_global_mouse_position())
#	exlp.play()
	$ExplosionSound.play()

func _on_ExplosionSpriteEffect_animation_finished():
	queue_free()

