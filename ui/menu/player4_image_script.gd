extends Panel

signal Player4_ready

func _ready():
	$"Player_4/Sprite".hide()
	connect("Player4_ready", $"/root/Global", "_player4_ready")
	
func _input(event):
	if event.is_action_pressed("player_4_interact"):
		$"Player_4/Sprite".show()
		$Keys_and_text_p4.show()
		$"Join_Player4_Text".hide()
		emit_signal("Player4_ready")
