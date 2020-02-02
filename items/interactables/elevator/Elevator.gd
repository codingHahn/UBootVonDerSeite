extends "res://items/interactable.gd"

class_name Elevator

export (NodePath) onready var other

const TILE_NONE = -1
const TILE_ELEVATOR_EMPTY = 38
const TILE_ELEVATOR_FILLED = 39

var holding
var holdingValue

var location: Vector2
var tiles: TileMap
var tileset

func _ready():
	self.tileset = load("res://levels/tiles.tres")
	self.update_texture()
	get_parent().set_cellv(get_parent().world_to_map(position), TILE_ELEVATOR_EMPTY)


func interact_with_player(player):
	print("Player wants to interact ", player)
	if self.is_interaction_allowed_again():
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
	
	self.update_texture()
	get_node(other).set_holding(item, value)
	
func update_texture():
	if self.holding == null:
		get_parent().set_cellv(get_parent().world_to_map(position), TILE_ELEVATOR_EMPTY)
	else:
		get_parent().set_cellv(get_parent().world_to_map(position), TILE_ELEVATOR_FILLED)
	
