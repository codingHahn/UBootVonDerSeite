extends KinematicBody2D

class_name pickupable

# Here Enums get used for the Items. Maybe change that
const World = preload("res://Scripts/World.gd")

export (Texture) onready var icon
export (World.Item) onready var item_type

const GRAVITY = 60
const floorUp = Vector2(0, -1)

var velocity = Vector2()

onready var sprite = Sprite.new()
onready var collision = CollisionShape2D.new()
onready var shape = CircleShape2D.new()

func _ready():
	sprite.texture = icon
	add_child(sprite)
	shape.radius = 10
	collision.set_shape(shape)
	add_child(collision)
	
	self.set_collision_layer(4)
	self.set_collision_mask(1)
	
func _physics_process(delta):
	velocity.y += GRAVITY * delta
	if is_on_floor():
		velocity.y = GRAVITY
	velocity = move_and_slide(velocity, floorUp)
