extends Node

# game settings
var screensize = Vector2()
var player_state = ["idle", "move"]
var current_scene = null
var new_scene = null

func _ready():
	screensize = get_viewport().size
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
	
func new_game():
	goto_scene("res://scritps/GameplayScene.tscn")
	
	
	