extends CanvasLayer

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func show_messsage(message_string):
	$MessageLabel.text = message_string
	$MessageLabel.show()
	$MessageTimer.start()
	

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
	$MessageLabel.text = ''
