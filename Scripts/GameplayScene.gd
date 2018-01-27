extends Node

export (PackedScene) var Right_commands
export (PackedScene) var Left_commands
export (PackedScene) var Asteroids

export (int) var max_command_buffer = 15
export (float) var velocity = 200

export (int) var max_command_frame_counter = 45
var current_command_frame_counter

func _ready():
	set_process(true)
	new_game()
	
func _process(delta):
	if current_command_frame_counter == max_command_frame_counter:
		input_from_player()
	else:
		current_command_frame_counter += 1
		
func input_from_player():
	if Global.current_command_buffer < max_command_buffer:
		if Input.is_action_just_pressed("ui_right"):
			create_command("right")
		if Input.is_action_just_pressed("ui_left"):
			create_command("left")

func create_command(command_string):
	var command_object
	if(command_string == "left"):
		command_object = Left_commands.instance()
	else:
		command_object = Right_commands.instance()
	add_child(command_object)
	
	var direction = 0
	command_object.position = $CommandStartPoint.position
	command_object.set_linear_velocity(Vector2(velocity, 0).rotated(direction))
		
	Global.current_command_buffer += 1
	current_command_frame_counter = 0
	
func force_ship_turn_left():
	get_node("Ship").turn_left()
	
func force_ship_turn_right():
	get_node("Ship").turn_right()
	
func _on_AsteroidTimer_timeout():
	var temp_index = randi() % 8 + 1
	var temp_start_position = get_node("ObstacleSpawnPositions/"+str(temp_index)).get_position()
	var aim_to_position = Global.aim_to_ship_rotation[temp_index]
		
	var ast = Asteroids.instance()
	add_child(ast)
	ast.position = temp_start_position
	ast.rotation = 0
	ast.set_linear_velocity(Vector2(Global.asteroid_velocity, 0).rotated(aim_to_position))

func new_game():
	current_command_frame_counter = 0
	$AsteroidTimer.start()
	$BGM.play()
	
# goto_scene("res://scenes/GameplayScene.tscn")

func game_over():
	$DeathSound.play()
	$BGM.stop()
	print("Game Over")
	set_process(false)
	Global.paused = true
	$AsteroidTimer.stop();
	
#	$GameplayHUD.show_game_over()
