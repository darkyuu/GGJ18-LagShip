extends Area2D

signal call_right
signal call_left
signal call_shoot

func _ready():
	add_to_group("commands")
	set_process(true)

func _process(delta):
	pass

func _on_CommandExecutePoint_body_entered( body ):
	if body.get_name().find("TurnRightCommand") != -1:
		emit_signal("call_right")
	elif body.get_name().find("TurnLeftCommand") != -1:
		emit_signal("call_left")
	else:
		emit_signal("call_shoot")
	Global.current_command_buffer -= 1
	body.queue_free()