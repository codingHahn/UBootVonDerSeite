extends Button



func _on_RestartGame_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://levels/Game.tscn")
