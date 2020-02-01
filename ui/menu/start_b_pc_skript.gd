extends Button

export (Array) var PlayerList

func _on_start_button_pc_pressed():
	
	emit_signal("", PlayerList);
	get_tree().change_scene("res://levels/UBoot.tscn")
	

