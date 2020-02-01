extends Panel

signal Player3_ready

func _ready():
	$"Player_3/Sprite".hide()
	connect("Player3_ready", $"/root/Global", "_player3_ready")
	
func _input(event):
	if event.is_action_pressed("player_3_interact"):
		$"Player_3/Sprite".show()
		$"Join_Player3_Text".hide()
		emit_signal("Player3_ready")
