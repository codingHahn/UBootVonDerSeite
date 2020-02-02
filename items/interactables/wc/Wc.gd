extends interactable
class_name wc

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()
var broken

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	broken = false
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _init(position: Vector2):
	var item = World.Item.Toilet
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)

func breakWc():
	broken = true
	self.icon = load("res://items/interactables/wc/BrokenWc.png")

func unbreakWc():
	broken = false
	self.icon = World.load_texture_for_item(World.Item.Toilet)

func interact_with_player(player):
	if player.holding == World.Item.Bucket && broken == false:
		player.holdingValue = 0
		if randi()%101>85:
			breakWc()
	if player.holding == World.Item.Wrench:
		unbreakWc()
