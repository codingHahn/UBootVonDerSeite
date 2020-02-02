extends Area2D
class_name obstacle

const World = preload("res://levels/World.gd")

var obstacle_type
var texture

func _init(position: Vector2, item):
	self.position = position
	self.obstacle_type = item
	texture = Sprite.new()
	texture.texture = load("res://obstacles/car/car.png")
	var sx = World.ItemSize.x / texture.texture.get_size().x
	var sy = World.ItemSize.y / texture.texture.get_size().y
	texture.scale = Vector2(sx, sy)
	add_child(texture)

func _physics_process(_delta):
	print ("Move car")
