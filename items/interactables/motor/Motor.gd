extends interactable
class_name motor

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()
var broken
var steerUp
var steerDown
var broken_asp: AudioStreamPlayer

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	broken = false
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)


func _init(position: Vector2, broken_asp: AudioStreamPlayer):
	name = "motor"
	var item = World.Item.Motor
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)
	self.broken_asp = broken_asp

func breakMotor():
	print("MOTOR BROKEN")
	broken = true
	updateIcon(load("res://items/interactables/motor/motorBroken.png"))
	self.broken_asp.play(0)

func unbreakMotor():
	broken = false
	updateIcon(World.load_texture_for_item(World.Item.Motor))
	self.broken_asp.stop()

func interact_with_player(player):
	if player.holding == World.Item.Wrench:
		unbreakMotor()
