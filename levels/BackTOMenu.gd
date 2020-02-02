extends Button


func _on_BackTOMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://ui/menu/start_screen.tscn")
