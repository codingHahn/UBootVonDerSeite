extends KinematicBody2D

var gravity = 800
onready var velocity:Vector2 = Vector2.ZERO

export var speed = 65

var is_on_ladder = false
var can_jump = false

func _ready():
	pass
	
	
func _process(_delta):
	velocity.x = 0
	if is_on_ladder:
		gravity = 0
		velocity.y = 0
	else:
		gravity = 800

	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		$Sprite.flip_h = false
	if Input.is_action_pressed("ui_up") and (is_on_floor() or is_on_ladder):
		velocity.y = -speed * 2
	if Input.is_action_pressed("ui_down") and is_on_ladder:
		velocity.y = speed
	
	if velocity.x == 0:
		$Animation.play("idle")
	else:
		$Animation.play("walk")


func _physics_process(delta):
	velocity.y += gravity * delta;
	velocity = move_and_slide(velocity, Vector2.UP, true)
