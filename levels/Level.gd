extends Node2D

const TILE_NONE = -1
const TILE_ROOM  = 0
const TILE_LEAK = 1
const TILE_LADDER = 2
const TILE_PLAYER = 3
const TILE_BACKGROUND = -1 # TODO add Tile

onready var PlayerScene = preload("res://characters/players/TilePlayer.tscn")

func _ready():
	var hole_timer = Timer.new()
	add_child(hole_timer)
	hole_timer.connect("timeout", self, "generate_new_hole")
	hole_timer.set_wait_time(1.0)
	hole_timer.set_one_shot(false)
	hole_timer.start()
	
	var PlayerList = get_node("/root/Global").PlayerList
	
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.prefix = player
		newPlayer.position = get_node("SpawnPoints").get_child(int(player) - 1).position
		newPlayer.drop_item_to = $Tiles.get_path()
		add_child(newPlayer)
	
func generate_new_hole():
	var scene_size = get_viewport().size
	var tile_x = rand_range(0, scene_size.x)
	var tile_y = rand_range(0, scene_size.y)
	
	var cell = $Tiles.world_to_map(Vector2(tile_x, tile_y))
	var tile = $Tiles.get_cellv(cell)
	
	if tile == TILE_BACKGROUND:
		print(cell)
		var hole = load("res://items/hole/Hole.tscn");
		var instance = hole.instance()
		instance.position = $Tiles.map_to_world(cell)
		print(instance)
		add_child(instance)
		pass
	
	pass


func _process(_delta):
	var tile = $Tiles.get_cellv($Tiles.world_to_map($Player.position))
	$Player.is_on_ladder = tile == TILE_LADDER
