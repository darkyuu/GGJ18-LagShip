extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageLabel.start()

func show_namelagship():
	show_message("Lag Ship")

func _on_StartButton_pressed():
	print("_on_StartButton_pressed")
	emit_signal("start_game")