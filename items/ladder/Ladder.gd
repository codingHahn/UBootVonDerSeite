extends Area2D



func _on_Ladder_body_entered(body):
	if body.name == "Player":
		body.ladder_on = true


func _on_Ladder_body_exited(body):
	if body.name == "Player":
		body.ladder_on = false
