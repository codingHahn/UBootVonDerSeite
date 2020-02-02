extends interactable
class_name wheel

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()
var broken
var isUp
var currentLevel

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	broken = false
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _init(position: Vector2, isUp_):
	var item = World.Item.Wheel
	isUp = isUp_
	self.position = position
	self.item_type = item
	unbreakWheel()

func breakWheel():
	broken = true
	if isUp:
		updateIcon(load("res://items/interactables/wheel/wheelUpBroken.png"))
	else:
		updateIcon(load("res://items/interactables/wheel/wheelDownBroken.png"))

func unbreakWheel():
	broken = false
	if isUp:
		updateIcon(load("res://items/interactables/wheel/wheelUp.png"))
	else:
		updateIcon(load("res://items/interactables/wheel/wheelDown.png"))

func interact_with_player(player):
	if player.holding == null:
		if isUp:
			currentLevel.steerUp()
		else:
			currentLevel.steerDown()
		if rand_range(0,100)>98:
			breakWheel()
	if player.holding == World.Item.Wrench:
		unbreakWheel()
