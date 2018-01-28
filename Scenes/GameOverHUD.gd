extends CanvasLayer

signal restart_game
signal menu_game


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageLabel.start()

func show_gameover():
	show_message("GAME OVER")

func _on_RestartButton_pressed():
	emit_signal("restart_game")

func _on_MenuButton_pressed():
	emit_signal("menu_game")
