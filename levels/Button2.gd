extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

#func _process(delta):
#	pass


func _on_Button2_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://ui/menu/start_screen.tscn")
