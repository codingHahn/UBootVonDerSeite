extends interactable
class_name wc

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _init(position: Vector2):
	var item = World.Item.Toilet
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)

func interact_with_player(player):
	if player.holding == World.Item.Bucket:
		player.holdingValue = 0
