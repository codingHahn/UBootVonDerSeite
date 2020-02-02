extends Button

export var fast_mode = false

func _ready():
	self.grab_focus()
	if (fast_mode):
		get_tree().change_scene("res://levels/Game.tscn")
	pass

func _on_START_pressed():
	get_tree().change_scene("res://ui/menu/select_player.tscn")
