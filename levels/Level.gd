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

onready var PlayerScene = preload("res://characters/players/TilePlayer.tscn")

export (NodePath) onready var hole_holder

const World = preload("res://levels/World.gd")

export (NodePath) onready var PlayerRoot

export (int) var health = 1000

var currentMotor

var max_size = null

func _ready():
	var PlayerList = get_node("/root/Global").PlayerList
	randomize()
	
	var hole_timer = Timer.new()
	add_child(hole_timer)
	hole_timer.connect("timeout", self, "generate_new_hole")
	hole_timer.set_wait_time((8.0 / PlayerList.size()) + 2)
	hole_timer.set_one_shot(false)
	hole_timer.start()
		
	create_bucket(Vector2(280, 248), 36)
	create_bucket(Vector2(768, 120), 0)
	create_toilet(Vector2(768, 414))
	create_wrench(Vector2(140, 414))
	create_motor(Vector2(40, 396))
	
	# test code
	place_new_hole(Vector2(740, 102))
	create_obstacle()
		
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.prefix = player
		newPlayer.position = get_node("SpawnPoints").get_child(int(player) - 1).position
		newPlayer.drop_item_to = get_node("dropped_items").get_path()
		newPlayer.level = self
		get_node(PlayerRoot).add_child(newPlayer)

func create_bucket(pos, fillsize):
	var to_drop = bucket.new(pos, fillsize)
	get_node("dropped_items").add_child(to_drop)

func create_obstacle():
	if(currentMotor.broken == false):
		var to_drop = obstacle.new(Vector2(1800, (randi() % 1000) - 300), World.ObstacleType.Car)
		to_drop.currentMotor = currentMotor
		to_drop.currentLevel = self
		get_node("obstacles").add_child(to_drop)

func create_toilet(pos):
	var to_drop = wc.new(pos)
	get_node("dropped_items").add_child(to_drop)

func create_motor(pos):
	currentMotor = motor.new(pos)
	get_node("dropped_items").add_child(currentMotor)

func create_wrench(pos):
	var to_drop = pickupable.new(pos, World.Item.Wrench)
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
		if bucket != null && !bucket.is_bucket_full():
			bucket.fill_bucket()
		else:
			dripping_holes += 1
	
	print(dripping_holes)
	if health - dripping_holes > 0:
		health -= dripping_holes
	else:
		health = 0
		$"gameoverPanel".show()
		$"gameoverPanel/RichTextLabel2".sha1_text("../../Score")

func find_bucket(hole):
	for element in get_node("dropped_items").get_children():
		if element is pickupable && element.item_type == World.Item.Bucket:
			if abs(element.position.x - (hole.position.x + 40))<40 && abs(element.position.y - hole.position.y)<160: 
				return element

	return null
	
func _process(_delta):
	if Input.is_action_pressed("stop"):
		get_tree().paused = true
		$"Panel".pause_mode = 2
		
		$"Panel".show()
	
	for player in get_node(PlayerRoot).get_children():
		var tile = $Tiles.get_cellv($Tiles.world_to_map(player.position))
		player.is_on_ladder = tile == TILE_LADDER or tile == TILE_LADDER_TOP or tile == TILE_LADDER_BOTTOM

func _on_Timer_timeout():
	calculate_health()
	if randi()%101>96 && currentMotor.broken == false:
		currentMotor.breakMotor()
	if randi()%101>95:
		create_obstacle()

func _on_Level_draw():
	pass
