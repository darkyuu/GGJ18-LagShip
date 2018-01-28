extends Node

export (PackedScene) var Right_commands
export (PackedScene) var Left_commands
export (PackedScene) var Shoot_commands
export (PackedScene) var Asteroids
export (PackedScene) var BlackHoles

export (int) var max_command_buffer = 15
export (float) var velocity = 200

export (int) var max_command_frame_counter = 10
var current_command_frame_counter
var list_selected_index = 1
var spawn_patterns = Array()

func _ready():
	randomize()
	set_process(true)
	new_game()
	start_next_level()
	
func _process(delta):
	if current_command_frame_counter == max_command_frame_counter:
		input_from_player()
	else:
		current_command_frame_counter += 1
		
	if Global.player_state == "play" and $AsteroidPool.get_child_count() == 0:
		start_next_level()

func input_from_player():
	if Global.current_command_buffer < max_command_buffer:
		if Input.is_action_just_pressed("ui_right"):
			create_command("right")
		elif Input.is_action_just_pressed("ui_left"):
			create_command("left")
		elif Input.is_action_just_pressed("player_shoot"):
			create_command("shoot")

func create_command(command_string):
	var command_object
	if command_string == "left":
		command_object = Left_commands.instance()
	elif command_string == "right":
		command_object = Right_commands.instance()
	elif command_string == "shoot":
		command_object = Shoot_commands.instance()
	add_child(command_object)
	
	var direction = 0
	command_object.position = $CommandStartPoint.position
	velocity = Global.command_velocity[Global.get_level_for_use_as_index()]
	var base = 5
	velocity -= Global.command_latency_factor[Global.get_level_for_use_as_index()]/base*velocity
	velocity = clamp(velocity, Global.command_minimum_velocity, Global.command_velocity[1])
	print("wave: "+str(Global.level)+" velocity:"+str(velocity))
	command_object.set_linear_velocity(Vector2(velocity, 0).rotated(direction))

	Global.current_command_buffer += 1
	current_command_frame_counter = 0
	
func force_ship_turn_left():
	get_node("Ship").turn_left()
	
func force_ship_turn_right():
	get_node("Ship").turn_right()
	
func force_ship_shoot_laser():
	get_node("Ship").shoot()
	
func _on_SpawnTimer_timeout():
	for i in spawn_patterns: #Global.spawn_patterns[list_selected_index]:
		set_Asteroid_to_spawn_position(i)
		
	Global.player_state = "play"

func new_game():
	current_command_frame_counter = 0
	$DeathSound.stop()
	$BGM.play()
	Global.paused = false
	$GameOverHUD.hide()
	set_process(true)
	
func restart_gameplay():
	Global.level = 0
	clear_remaining_asteroid($AsteroidPool)
	$Ship.start()
	new_game()
	start_next_level()
	
func start_next_level():
	Global.player_state = "wait"
	Global.level += 1
	$GameplayHUD/MessageTimer.wait_time = Global.level_spawn_time[Global.get_level_for_use_as_index()]
	$GameplayHUD.show_messsage("Wave %s" % Global.level)
	var latencyString = str(Global.command_latency_factor[Global.get_level_for_use_as_index()]*100)
	$BarSet/LatencyLabel.text = "Latency\n"+ latencyString
	
#	list_selected_index = randi() % Global.max_spawn_index + 1 
	spawn_patterns.clear()
	spawn_patterns = Global.generate_spawn_pattern()
	for i in spawn_patterns: #Global.spawn_patterns[list_selected_index]:
		set_blackhole_effect_to_spawn_position(i)
	yield($GameplayHUD/MessageTimer, "timeout")
	for a in $BlackHoles.get_children():
		a.queue_free()
	
	$SpawnTimer.wait_time = 0.1
	$SpawnTimer.start()

func set_blackhole_effect_to_spawn_position(position_index):
	var temp_start_position = get_node("ObstacleSpawnPositions/"+str(position_index)).get_position()
	var bh = BlackHoles.instance()
	$BlackHoles.add_child(bh)
	bh.position = temp_start_position
	bh.play()
	
func set_Asteroid_to_spawn_position(position_index):
	var temp_start_position = get_node("ObstacleSpawnPositions/"+str(position_index)).get_position()
	var aim_to_position = Global.aim_to_ship_rotation[position_index]

	var ast = Asteroids.instance()
	$AsteroidPool.add_child(ast)
	ast.position = temp_start_position
	ast.rotation = 0
	ast.set_linear_velocity(Vector2(Global.asteroid_initial_velocity[position_index], 0).rotated(aim_to_position))

func clear_remaining_asteroid(n):
	for a in n.get_children():
		a.queue_free()

func game_over():
	$DeathSound.play()
	$BGM.stop()
	set_process(false)
	Global.paused = true
	$SpawnTimer.stop()
	$GameOverHUD.show()
	
func goto_mainmenu():
	Global.level = 0
	$GameOverHUD.get_tree().change_scene("res://Scenes/MenuScene.tscn")