extends Node2D

const TILE_NONE = -1
const TILE_ROOM  = 0
const TILE_LEAK = 1
const TILE_LADDER = 2
const TILE_PLAYER = 3
const TILE_BACKGROUND = -1 # TODO add Tile

onready var PlayerScene = preload("res://characters/players/TilePlayer.tscn")
export (NodePath) onready var hole_holder
export (NodePath) onready var PlayerRoot

export (int) var health = 1000

var max_size = null

func _ready():
	var hole_timer = Timer.new()
	add_child(hole_timer)
	hole_timer.connect("timeout", self, "generate_new_hole")
	hole_timer.set_wait_time(10.0)
	hole_timer.set_one_shot(false)
	hole_timer.start()
	
	var PlayerList = get_node("/root/Global").PlayerList
	
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.prefix = player
		newPlayer.position = get_node("SpawnPoints").get_child(int(player) - 1).position
		newPlayer.drop_item_to = $Tiles.get_path()
		get_node(PlayerRoot).add_child(newPlayer)
	
func generate_new_hole():
	if self.max_size != null:
		var tile_x = rand_range(0, self.max_size.x)
		var tile_y = rand_range(0, self.max_size.y)
		
		var cell = $Tiles.world_to_map(Vector2(tile_x, tile_y))
		var tile = $Tiles.get_cellv(cell)
		
		if tile == TILE_BACKGROUND:
			var hole = load("res://items/hole/Hole.tscn");
			var instance = hole.instance()
			instance.position = $Tiles.map_to_world(cell)
			get_node(hole_holder).add_child(instance)

func calculate_health():
	var count_holes = get_node(hole_holder).get_child_count()
	print(count_holes)
	if health - count_holes > 0:
		health -= count_holes
	else:
		health = 0
		$"RichTextLabel".show()
	
	
func _process(_delta):
	for player in get_node(PlayerRoot).get_children():
		var tile = $Tiles.get_cellv($Tiles.world_to_map(player.position))
		player.is_on_ladder = tile == TILE_LADDER



func _on_Timer_timeout():
	print("Decreased health")
	calculate_health()
