extends "res://items/interactable.gd"

class_name Elevator

export (NodePath) onready var other

const TILE_NONE = -1

var holding
var holdingValue

var location: Vector2
var tiles: TileMap

func initialize(location: Vector2, tiles: TileMap):
	self.location = location
	self.tiles = tiles


func interact_with_player(player):
	print("Player wants to interact ", player)
	if holding == null:
		var value = player.get_item_value()
		var item = player.take_item()
		set_holding(item, value)
	elif player.can_pickup():
		player.set_holding(holding, holdingValue)
		self.set_holding(null, null)


func set_holding(item, value):
	if holding == item:
		return

	holding = item
	holdingValue = value
	
	if item == null:
		$Door.texture = load("res://items/interactables/elevator/empty.png")
	else:
		$Door.texture = load("res://items/interactables/elevator/filled.png")

	print(get_node(other))
	get_node(other).set_holding(item, value)
