extends Panel

signal Player4_ready

func _ready():
	$"player_image".hide()
	connect("Player4_ready", $"/root/Global", "_player4_ready")
	
func _input(event):
	if event.is_action_pressed("player_4_interact"):
		$"player_image".show()
		$"Join_Player4_Text".hide()
		emit_signal("Player4_ready")
