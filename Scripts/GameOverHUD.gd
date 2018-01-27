extends CanvasLayer

signal restart_game
signal back_to_main_menu

func _ready():
	pass
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func show():
	$restartBtn.show()
	$backtomainBtn.show()
	$gameOver.show()
	
func hide():
	$restartBtn.hide()
	$backtomainBtn.hide()
	$gameOver.hide()

func _on_restartBtn_pressed():
	print("_on_restartBtn_pressed")
	emit_signal("restart_game")

func _on_backtomainBtn_pressed():
	emit_signal("back_to_main_menu")
