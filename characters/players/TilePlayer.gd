extends KinematicBody2D

const World = preload("res://levels/World.gd")

var gravity = 800
onready var velocity:Vector2 = Vector2.ZERO

export var speed = 65

var is_on_ladder = false
var can_jump = false

export (NodePath) onready var drop_item_to

# Do not export, because then it cannot be easily nulled at the beginning
# If this is exported, there is a ghostitem in the players hand that has
# to be discarded before he can pick up any object
var holding

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


	if Input.is_action_pressed("interact"):
		var areas = $InteractableArea.get_overlapping_areas()
		if areas.size() > 0 && areas[0].has_method("interact_with_player"):
			print("Interacting with ", areas[0]);
			areas[0].call("interact_with_player", self)
			
	if Input.is_action_pressed("drop_item"):
		if holding != null:
			var itemtodrop = pickupable.new()
			itemtodrop.texture = load("res://items/interactables/bed/Bedsheet.png")
			itemtodrop.item_type = holding
			# Set itemposition to player position. Otherwise it will spawn
			# at (0,0)
			itemtodrop.position = self.position
			get_node(drop_item_to).add_child(itemtodrop)
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
		var asset = "";
		match item:
			World.Item.Gasoline:
				asset = "gasoline/Gasoline.png"
			World.Item.Bucket:
				asset = "bucket/Bucket.png"
			World.Item.Bedsheet:
				asset = "bed/Bedsheet.png"
		$Holding.texture = load("res://items/interactables/" + asset)


func _physics_process(delta):
	velocity.y += gravity * delta;
	velocity = move_and_slide(velocity, Vector2.UP, true)
