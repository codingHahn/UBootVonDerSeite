extends KinematicBody2D

var bewegend = Vector2(10,0)

func _physics_process(delta):
	bewegend.x = -200
	move_and_slide(bewegend)
	if $"../KiBoBack1".position.x < -150:
		$"../KiBoBack1".position.x = 2800
