extends Button

func _ready():
	self.grab_focus()

func _on_GO_BACK_pressed():
	get_tree().change_scene("res://ui/menu/start_screen.tscn")
