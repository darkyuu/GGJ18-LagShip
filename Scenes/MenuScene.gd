extends Node

func _ready():
	set_process(true)

func new_game():
	$HUD.get_tree().change_scene("res://GameplayScene.tscn")



