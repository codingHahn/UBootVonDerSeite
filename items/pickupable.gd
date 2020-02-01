extends interactable

class_name pickupable

const GRAVITY = 60
const floorUp = Vector2(0, -1)

var velocity = Vector2()

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()

func _init(position: Vector2, item):
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)

func _ready():
	shape.radius = World.ItemSize.length() / 2
	collision.set_shape(shape)
	add_child(collision)
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _physics_process(delta):
	velocity = Vector2(0,0)
	velocity.y += GRAVITY * delta
	var overlapping_bodies = get_overlapping_bodies()
	if !overlapping_bodies.empty():
		velocity = Vector2(0,0)
	
	position += velocity

func interact_with_player(player):
	# Call interact_with_player from class interactable first,
	# because we destroy this object here.
	if player.can_pickup():
		player.set_holding(item_type)
		self.queue_free()
