extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const gravity = 10
var velocity = Vector2()
var interaction_target = null
const floorUp = Vector2(0, -1)
export var speed = 200
onready var anim_Player = $AnimationPlayer

func _ready():
	pass


func _physics_process(delta):
	
	var movement_direction = 0;
	
	velocity.y += gravity
	
	
	if is_on_floor():
		velocity.y = gravity
		if Input.is_action_pressed('jump'):
			anim_Player.play("Scale")
			velocity.y = -300
	
	if Input.is_action_pressed("ui_left"):
		movement_direction -= speed
	
	if Input.is_action_pressed("ui_right"):
		movement_direction += speed
		
	velocity.x = movement_direction
		
	velocity = move_and_slide(velocity, floorUp)
	
	
	
	if Input.is_action_pressed("interact") && interaction_target != null:
		interaction_target.interact_with_player(self);
		

func on_button(body):
	print("entered ", body)
	self.interaction_target = body
	pass # Replace with function body.


