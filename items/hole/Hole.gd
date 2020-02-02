extends "res://items/interactable.gd"

const TILE_NONE = -1

var location: Vector2
var tiles: TileMap

func initialize(location: Vector2, tiles: TileMap):
	self.location = location
	self.tiles = tiles

func interact_with_player(player):
	print("Player wants to interact ", player)
	var item = player.take_item_if_eq(World.Item.Bedsheet);
	if item != null:
		$Water.texture = load("res://items/hole/abgedichtetesloch.jpeg")
		$Animation.stop(true)
		tiles.set_cellv(location, TILE_NONE)
		get_parent().queue_free()
