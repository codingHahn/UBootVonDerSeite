extends KinematicBody2D

var bewegend2 = Vector2(10,0)

func _physics_process(delta):
	bewegend2.x = 80
	move_and_slide(bewegend2)
	if $"../KiBoBackMov2".position.x > 5900:
		$"../KiBoBackMov2".position.x = -200
