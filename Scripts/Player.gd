extends KinematicBody2D

const World = preload("res://Scripts/World.gd")

const gravity = 10
const floorUp = Vector2(0, -1)
export var speed = 200

# Do not export, because then it cannot be easily nulled at the beginning
# If this is exported, there is a ghostitem in the players hand that has
# to be discarded before he can pick up any object
var holding

var velocity = Vector2()

func _ready():
	self.add_to_group("players")


func _physics_process(delta):
	var movement_direction = 0;
	
	velocity.y += gravity
	if is_on_floor():
		velocity.y = gravity
		if Input.is_action_pressed('jump'):
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
			
	if Input.is_action_pressed("drop_item"):
		self.set_holding(null)
		
func can_pickup():
	return holding == null
		
func take_item():
	var item = self.holding
	self.set_holding(null)
	return item
	
func take_item_if_eq(item):
	var holding = self.holding
	if holding == item:
		self.set_holding(null)
		return holding
	else:
		return null
		
func set_holding(item):
	holding = item
	
	if item == null:
		$Holding.texture = null
	else:
		var name = "";
		match item:
			World.Item.Gasoline:
				name = "Gasoline.png"
			World.Item.Bucket:
				name = "Bucket.png"
			World.Item.Bedsheet:
				name = "Bedsheet.png"
		
		$Holding.texture = load("res://Assets/Sprites/" + name)


