extends Panel

signal Player2_ready

func _ready():
	$"player_image".hide()
	connect("Player2_ready", $"/root/Global", "_player2_ready")
	
func _input(event):
	if event.is_action_pressed("player_2_interact"):
		$"player_image".show()
		$"Join_Player2_Text".hide()
		emit_signal("Player2_ready")
