extends Node

# game settings
var screen_size = Vector2()
var player_state
var current_scene = null
var new_scene = null
var current_command_buffer = 0
var asteroid_velocity = 50
var paused = false
var level = 0


var aim_to_ship_rotation = {1: PI/4, 2: PI/2, 3: 3*PI/4,
							4: 0, 5: PI,  
							6: 7*PI/4, 7: 3*PI/2, 8: 5*PI/4}
							
							
var max_spawn_index = 4
var spawn_patterns = {1: [6, 2, 5], 2: [7, 1, 4], 3: [8, 2, 5], 4: [3, 2, 5]} 

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