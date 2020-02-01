extends Button

func _ready():
	pass

func _on_START_pressed():
	get_tree().change_scene("res://ui/menu/select_player.tscn")
