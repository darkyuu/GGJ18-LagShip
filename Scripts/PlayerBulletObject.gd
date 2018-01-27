extends Area2D

export (int) var speed = 1000
var velocity = Vector2()

func _ready():
	set_process(true)

func _process(delta):
	set_position(get_position() + velocity * delta)

func start_at(direction, position):
	set_rotation(direction)
	set_position(position)
	velocity = Vector2(speed, 0).rotated(direction - PI/2)

func _on_PlayerBullet_body_entered(area):
	if area.is_in_group("asteroids"):
		queue_free()
		area.explode_itself()