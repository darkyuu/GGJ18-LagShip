extends RigidBody2D

signal explode

var velocity = Vector2()
var rotation_speed
var extents = Vector2()

func _ready():
	pass
#	randomize()
#
#	add_to_group("asteroids");
#	set_process(true);


func _process(delta):
	pass
#	velocity = velocity.clamped(300)
#	set_rotation(get_rotation() + rotation_speed * delta)
#	set
#
#	this.MoveAndSlide(velocity * delta);





#func init(init_position, init_velocity):
#	if init_velocity.length()  > 0:
#        velocity = init_velocity
#	else:
#		velocity = Vector2(random_range(300 , 1000)).rotated(random_range(0, 2*PI))
#
#
#	rotation_speed = random_range(-1.5, 1.5);


#	extents = get_node("Sprite").get_texture().get_size()/2
#	set_position(init_position)