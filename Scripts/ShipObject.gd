extends Area2D

signal hit

export (PackedScene) var Bullets

var current_direction = PI/2
var current_position;

func _ready():
	hide()
	var screensize = get_viewport().size
	current_position = Vector2(screensize.x/2, screensize.y/2)

	$Collision.disabled = true
	start()
	set_process(false)
#	set_process(true) #for test in GameObject
	
func _process(delta):
	if Input.is_action_just_pressed("player_shoot"):
		shoot()
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
	
func turn_left():
	current_direction -= PI/4;
	trim_direction_in_radian()
	set_rotation(current_direction);

func turn_right():
	current_direction += PI/4;
	trim_direction_in_radian()
	set_rotation(current_direction)

func trim_direction_in_radian():
	if current_direction >= 2*PI:
		current_direction = 0;
	elif current_direction <= -2*PI:
		current_direction = 0;

func _on_Ship_body_entered( body ):
	$Collision.disabled = true
	hide()
	emit_signal("hit")
	
func shoot():
	var bullet_obj = Bullets.instance()
	$BulletContainer.add_child(bullet_obj)
	bullet_obj.start_at(get_rotation(), $Muzzle.get_global_position())
	$ShootSound.play()