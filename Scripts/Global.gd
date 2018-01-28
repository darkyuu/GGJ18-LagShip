extends Node

# game settings
var screen_size = Vector2()
var player_state
var current_scene = null
var new_scene = null
var current_command_buffer = 0
var paused = false
var level = 0
var command_velocity = {1: 1600, 2: 1600, 3: 1400, 4: 1400, 5: 1000,  
						6: 1000, 7: 800, 8: 800, 9: 800, 10: 800}
						
var command_minimum_velocity = 240
						
var command_latency_factor = {1: 0.5, 2: 1.0, 3: 1.5, 4: 2.0, 5: 2.5, 
								6: 3.0, 7: 3.5, 8: 4.0, 9: 4.5, 10: 5.0}
								
var level_spawn_time = {1: 3, 2: 3, 3: 3, 4: 2.5, 5: 2.5, 
								6: 2.5, 7: 2, 8: 2, 9: 2, 10: 2}

var asteroid_initial_velocity = {1: 50, 2: 50, 3: 50, 
								4: 70, 5: 70,  
								6: 30, 7: 30, 8: 30}

var aim_to_ship_rotation = {1: PI/4, 2: PI/2, 3: 3*PI/4,
							4: 0, 5: PI,  
							6: 7*PI/4, 7: 3*PI/2, 8: 5*PI/4}
							

#var max_spawn_index = 4
#var spawn_patterns = {1: [5], 2: [7], 3: [8, 5], 4: [3, 2, 5]}

func _ready():
	screen_size = get_viewport().size
	var root = get_tree().get_root()
	# TODO: change this when adding start screen
	current_scene = root.get_child(root.get_child_count() - 1)
	
func goto_scene(path):
	var s = ResourceLoader.load(path)
	new_scene = s.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	current_scene.queue_free()
	current_scene = new_scene
	
func get_level_for_use_as_index():
	if level > 10:
		return 10
	else:
		return level
		
func generate_spawn_pattern():
	var result = Array()
	var counter = 0
	var max_counter = randi() % 2 + 3
	
	if level == 1 or level == 2:
		max_counter = level
	else:
		max_counter = randi() % 2 + 3
		
	while(counter < max_counter):
		var b = randi() % 8 + 1
		print("generate_spawn_pattern"+str(b)) 
		if result.find(b) == -1:
			print("add"+str(b))
			result.append(b)
			counter += 1

	return result