extends Node2D

const TILE_NONE = -1
#const TILE_ROOM  = 0 # ??
#const TILE_LEAK = 1 # ??
const TILE_LADDER = 11 # ??
const TILE_LADDER_TOP = 36
const TILE_LADDER_BOTTOM = 37
#const TILE_PLAYER = 3 # ??
const TILE_BACKGROUND = 14
const TILE_HOLE = 16

const BUCKET_SIZE = 50.0

onready var PlayerScene = preload("res://characters/players/TilePlayer.tscn")

export (NodePath) onready var hole_holder

const World = preload("res://levels/World.gd")

export (NodePath) onready var PlayerRoot

export (int) var health = 1000

var max_size = null

func _ready():
	randomize()
	var hole_timer = Timer.new()
	add_child(hole_timer)
	hole_timer.connect("timeout", self, "generate_new_hole")
	hole_timer.set_wait_time(10.0)
	hole_timer.set_one_shot(false)
	hole_timer.start()
	
	place_new_hole(Vector2(640, 102))
	create_bucket(Vector2(280, 248), 36)
	create_bucket(Vector2(668, 120), 0)
	
	var PlayerList = get_node("/root/Global").PlayerList
	
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.prefix = player
		newPlayer.position = get_node("SpawnPoints").get_child(int(player) - 1).position
		newPlayer.drop_item_to = get_node("dropped_items").get_path()
		newPlayer.level = self
		get_node(PlayerRoot).add_child(newPlayer)

func is_bucket_full(bucket):
	return bucket.value >= BUCKET_SIZE
	
func fill_bucket(bucket):
	bucket.value += 1
	var rect = bucket.get_node("Progress")
	rect.set_size(Vector2(bucket.value / BUCKET_SIZE * 32, 4))

func create_bucket(pos, fillsize): # fillsize in litre (10l max)
	var to_drop = pickupable.new(pos, World.Item.Bucket)
	to_drop.value = fillsize
	
	if is_bucket_full(to_drop):
		fillsize = BUCKET_SIZE
		to_drop.value = fillsize

	var rect = ColorRect.new()
	rect.name = "Back"
	rect.set_position(Vector2(-16, 20))
	rect.set_size(Vector2(32, 4))
	rect.color = Color(0.5,0.5,0.5)
	to_drop.add_child(rect)

	rect = ColorRect.new()
	rect.name = "Progress"
	rect.set_position(Vector2(-16, 20))
	rect.set_size(Vector2(fillsize / BUCKET_SIZE * 32, 4))
	rect.color = Color(1,0,0)	
	to_drop.add_child(rect)
	
	get_node("dropped_items").add_child(to_drop)

func generate_new_hole():
	if self.max_size != null:
		var tile_x = rand_range(0, self.max_size.x)
		var tile_y = rand_range(0, self.max_size.y)
		place_new_hole(Vector2(tile_x, tile_y))

func place_new_hole(pos):
	var cell = $Tiles.world_to_map(pos)
	var background_tile = $Tiles.get_cellv(cell)
	var foreground_tile = $ForegroundTiles.get_cellv(cell)
	
	if background_tile == TILE_BACKGROUND && foreground_tile == TILE_NONE:
		var hole = load("res://items/hole/Hole.tscn");
		var instance = hole.instance()
		print(instance)
		instance.call("initialize", cell, $ForegroundTiles)
		instance.position = $Tiles.map_to_world(cell)

		get_node(hole_holder).add_child(instance)

		$ForegroundTiles.set_cellv(cell, TILE_HOLE)


func calculate_health():
	var dripping_holes = 0
	for hole in get_node(hole_holder).get_children():
		var bucket = find_bucket(hole)
		print("found: ")
		print(bucket)
		if bucket != null && !is_bucket_full(bucket):
			fill_bucket(bucket)
		else:
			dripping_holes += 1
	
	print(dripping_holes)
	if health - dripping_holes > 0:
		health -= dripping_holes
	else:
		health = 0
		$"RichTextLabel".show()

func find_bucket(hole):
	for element in get_node("dropped_items").get_children():
		if element is pickupable && element.item_type == World.Item.Bucket:
			if abs(element.position.x - (hole.position.x + 40))<40 && abs(element.position.y - hole.position.y)<160: 
				return element

	return null
	
func _process(_delta):
	if Input.is_action_pressed("stop"):
		get_tree().paused = true
		$"Panel".show()
	
	for player in get_node(PlayerRoot).get_children():
		var tile = $Tiles.get_cellv($Tiles.world_to_map(player.position))
		player.is_on_ladder = tile == TILE_LADDER or tile == TILE_LADDER_TOP or tile == TILE_LADDER_BOTTOM

func _on_Timer_timeout():
	print("Decreased health")
	calculate_health()


func _on_Level_draw():
	pass
