extends Node

func _ready():
	set_process(true)
	
func _process(delta):
	pass
	
func new_game():
	$HUD.get_tree().change_scene("res://Scenes/GameplayScene.tscn")



