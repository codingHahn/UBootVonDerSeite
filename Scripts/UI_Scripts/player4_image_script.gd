extends Panel

func _ready():
	$"player_image".hide()
	
func _input(event):
	if event.is_action_pressed("player_4_interact"):
		$"player_image".show()
