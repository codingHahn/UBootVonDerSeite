extends KinematicBody2D

var bewegend5rl = Vector2(10,0)

func _physics_process(delta):
	bewegend5rl.x = -80
	move_and_slide(bewegend5rl)
	if $"../KiBoBackMov2".position.x < -300:
		$"../KiBoBackMov2".position.x = 5900
