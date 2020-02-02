extends interactable
class_name wc

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()
var broken

var asp: AudioStreamPlayer

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	broken = false
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

	asp = AudioStreamPlayer.new()
	asp.set_bus("Soundeffects")
	add_child(asp)
	asp.stream = load("res://items/interactables/wc/Toilette.wav")

func _init(position: Vector2):
	var item = World.Item.Toilet
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)

func breakWc():
	broken = true
	updateIcon(load("res://items/interactables/wc/BrokenWc.png"))

func unbreakWc():
	broken = false
	updateIcon(World.load_texture_for_item(World.Item.Toilet))

func interact_with_player(player):
	if player.holding == World.Item.Bucket && broken == false && self.is_interaction_allowed_again() && player.holdingValue > 0:
		asp.play(0)
		player.holdingValue = 0 
		if rand_range(0,100)>75:
			breakWc()
	if player.holding == World.Item.Wrench:
		unbreakWc()
