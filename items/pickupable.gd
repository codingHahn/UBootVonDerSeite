extends interactable

class_name pickupable

const GRAVITY = 60
const floorUp = Vector2(0, -1)

var velocity = Vector2()

onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()

func _ready():
	shape.radius = 10
	collision.set_shape(shape)
	add_child(collision)
	
	self.set_collision_layer(5)
	self.set_collision_mask(3)

func _physics_process(delta):
	velocity = Vector2(0,0)
	velocity.y += GRAVITY * delta
	var overlapping_bodies = get_overlapping_bodies()
	if !overlapping_bodies.empty():
		if overlapping_bodies.pop_front().is_in_group("uboot"):
			velocity = Vector2(0,0)
	
	position += velocity

func interact_with_player(player):
	# Call interact_with_player from class interactable first,
	# because we destroy this object here.
	.interact_with_player(player)
	self.queue_free()
