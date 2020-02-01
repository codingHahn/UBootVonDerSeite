extends Button

var fast_mode = false

func _ready():
	if (fast_mode):
		_on_START_pressed()
	pass

func _on_START_pressed():
	get_tree().change_scene("res://ui/menu/select_player.tscn")
