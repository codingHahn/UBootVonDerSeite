extends Control

var fast_mode = false

func _ready():
	if fast_mode:
		get_tree().change_scene("res://levels/Game.tscn")
	pass
