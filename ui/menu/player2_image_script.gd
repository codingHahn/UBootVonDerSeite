extends Panel

signal Player2_ready

func _ready():
	$"Player_2/Sprite".hide()
	connect("Player2_ready", $"/root/Global", "_player2_ready")
	
func _input(event):
	if event.is_action_pressed("player_2_interact"):
		$"Player_2/Sprite".show()
		$Keys_and_text_p2.show()
		$"Join_Player2_Text".hide()
		emit_signal("Player2_ready")
