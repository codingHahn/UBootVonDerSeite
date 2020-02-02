extends interactable
class_name fire

const GRAVITY = 120
onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()
var currentLevel
var fireLevel
var counter
var anim

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _init(position: Vector2):
	var item = World.Item.Fire
	self.position = position
	self.item_type = item
	counter = 0
	anim = 0
	fireLevel = 1
	updateIconState()

func updateIconState():
	if fireLevel ==  1:
		updateIcon(load("res://items/interactables/fire/fireSmall" + str(anim) + ".png"))
	else:
		if fireLevel == 2:
			updateIcon(load("res://items/interactables/fire/fireMed" + str(anim) + ".png"))
		else:
			updateIcon(load("res://items/interactables/fire/fireLarge" + str(anim) + ".png"))

func interact_with_player(player):
	if player.holding == World.Item.Bucket:
		var redLevel = player.holdingValue / 12
		fireLevel -= redLevel
		player.holdingValue = 0
		
	if fireLevel <= 0:
		extinguish()

func extinguish():
	get_parent().remove_child(self)

func _physics_process(_delta):
	var velocity = Vector2(0,0)
	velocity.y += GRAVITY * _delta
	var overlapping_bodies = get_overlapping_bodies()
	if !overlapping_bodies.empty():
		velocity = Vector2(0,0)
	
	position += velocity
	
	counter += _delta
	if counter > 25:
		fireLevel += 1
		if fireLevel > 3: 
			fireLevel = 3
			var posX = -World.ItemSize.x
			if randi() % 2 == 0:
				posX = World.ItemSize.x
			currentLevel.create_fire(Vector2(position.x - posX, position.y))
		counter = 0
		updateIconState()
	if int(counter*10) % 5 == 0:
		anim = (anim+1) % 2
		updateIconState()
