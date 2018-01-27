extends RigidBody2D

signal explode

var velocity = Vector2()
var rotation_speed
var extents = Vector2()

func _ready():
	pass

func _process(delta):
	if Global.paused == true:
		sleeping = true;	