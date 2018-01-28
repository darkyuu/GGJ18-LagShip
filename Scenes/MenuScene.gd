extends Node

func _ready():
	set_process(true)
	$BGM.play()
	
func _process(delta):
	pass
	
func new_game():
	$BGM.stop()
	$HUD.get_tree().change_scene("res://Scenes/GameplayScene.tscn")



