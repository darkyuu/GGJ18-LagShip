extends Area2D

signal hit
signal turnLeft
signal turnRight

var current_direction = -PI/2
var current_state = "idle"
var current_position;

func _ready():
	hide()
	var screensize = get_viewport().size
	current_position = Vector2(screensize.x/2, screensize.y/2)
	
	$Collision.disabled = true
	start()
	set_process(false)
	
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		current_direction += PI/4;
		trim_direction_in_radian()
		set_rotation(current_direction)
	if Input.is_action_just_pressed("ui_left"):
		current_direction -= PI/4
		trim_direction_in_radian()
		set_rotation(current_direction)

func start():
	set_position(current_position)
	set_rotation(current_direction)
	show()
	$Collision.disabled = false
	
func _on_Ship_turnLeft():
	current_direction -= PI/4;
	trim_direction_in_radian()
	set_rotation(current_direction);

func _on_Ship_turnRight():
	current_direction += PI/4;
	trim_direction_in_radian()
	set_rotation(current_direction)

func trim_direction_in_radian():
	if current_direction >= 2*PI:
		current_direction = 0;
	elif current_direction <= -2*PI:
		current_direction = 0;
		