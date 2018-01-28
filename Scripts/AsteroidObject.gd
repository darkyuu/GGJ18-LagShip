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
	$Collision.disabled = true
	sleeping = true
	
	$ExplosionSpriteEffect.visible = true;
	$ExplosionSpriteEffect.play()
	$ExplosionSound.play()

func _on_ExplosionSpriteEffect_animation_finished():
	queue_free()

