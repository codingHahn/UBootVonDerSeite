extends Button

func _on_return_from_player_select_pressed():
	$"/root/Global"._resetPlayerList()
	get_tree().change_scene("res://ui/menu/start_screen.tscn")
