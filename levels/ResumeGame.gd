extends Button

func _on_ResumeGame_pressed():
	get_parent().hide()
	get_tree().paused = false
