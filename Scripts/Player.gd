extends KinematicBody2D

const World = preload("res://Scripts/World.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const gravity = 10
var holding = null
var velocity = Vector2()
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
	
	
	
	if Input.is_action_pressed("interact"):
		var areas = $Area2D.get_overlapping_areas()
		if areas.size() > 0 && areas[0].has_method("interact_with_player"):
			areas[0].call("interact_with_player", self)
			print(areas[0])
			
	if Input.is_action_pressed("drop_item"):
		self.set_holding(null)
		
func can_pickup():
	return holding == null
		
func set_holding(item):
	holding = item
	
	if item == null:
		$Holding.texture = null
		return
	
	var name = "";
	match item:
		World.Item.Gasoline:
			name = "Gasoline.png"
		World.Item.Bucket:
			name = "Bucket.png"
	
	
	$Holding.texture = load("res://Assets/Sprites/" + name)


