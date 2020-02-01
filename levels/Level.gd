extends Node2D

const TILE_NONE = -1
const TILE_ROOM  = 0
const TILE_LEAK = 1
const TILE_LADDER = 2
const TILE_PLAYER = 3


func _ready():
	pass


func _process(_delta):
	var tile = $Tiles.get_cellv($Tiles.world_to_map($Player.position))
	$Player.is_on_ladder = tile == TILE_LADDER
