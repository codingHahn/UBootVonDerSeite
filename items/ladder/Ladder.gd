extends Area2D



func _on_Ladder_body_entered(body : KinematicBody2D):
	if body.is_in_group("players"):
		body.ladder_on = true


func _on_Ladder_body_exited(body : KinematicBody2D):
	if body.is_in_group("players"):
		body.ladder_on = false
