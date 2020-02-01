extends KinematicBody2D

var bewegend = Vector2(10,0)

func _physics_process(delta):
	bewegend.x = -50
	move_and_slide(bewegend)
