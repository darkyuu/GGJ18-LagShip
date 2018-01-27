extends Area2D

signal call_right
signal call_left

func _ready():
	set_process(true)

func _process(delta):
	pass

func _on_CommandExecutePoint_body_entered( body ):
	print("*"+body.get_name())
	if body.get_name().find("TurnRightCommand") != -1:
		emit_signal("call_right")
	else:
		emit_signal("call_left")
	Global.current_command_buffer -= 1
	body.queue_free()
#	print("current_command_buffer: "+str(Global.current_command_buffer))
