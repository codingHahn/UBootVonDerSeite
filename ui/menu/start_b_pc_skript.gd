extends Button

func _ready():
	self.grab_focus()

func _on_start_button_pc_pressed():
	get_tree().change_scene("res://levels/Game.tscn")
