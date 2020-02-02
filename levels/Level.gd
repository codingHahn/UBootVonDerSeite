extends Node2D

const TILE_NONE = -1
#const TILE_ROOM  = 0 # ??
#const TILE_LEAK = 1 # ??
const TILE_LADDER = 11 # ??
const TILE_LADDER_TOP = 36
const TILE_LADDER_BOTTOM = 37
#const TILE_PLAYER = 3 # ??

const TILE_BACKGROUND = 14
const TILE_WINDOW = 16
const TILE_LIGHT = 43
const TILE_PIPES_UP = 33

const TILE_HOLE = 48

onready var PlayerScene = preload("res://characters/players/TilePlayer.tscn")

export (NodePath) onready var hole_holder

const World = preload("res://levels/World.gd")

export (NodePath) onready var PlayerRoot

export (int) var health = 1000

var music_stage_2 = false
var music_stage_3 = false

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
	create_wheel(Vector2(900, 120), true)
	create_wheel(Vector2(80, 120), false)
	
	# test code
	place_new_hole(Vector2(740, 102))
	create_fire(Vector2(300, 128))
	create_obstacle()
		
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.prefix = player
		newPlayer.get_child(1).texture = load("res://characters/players/" + newPlayer.prefix + ".png")
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
	
func create_wheel(pos, isUp):
	var to_drop = wheel.new(pos, isUp)
	to_drop.currentLevel = self
	get_node("dropped_items").add_child(to_drop)

func create_wrench(pos):
	var to_drop = pickupable.new(pos, World.Item.Wrench)
	get_node("dropped_items").add_child(to_drop)

func generate_new_fire():
	if self.max_size != null:
		var tile_x = rand_range(0, self.max_size.x)
		var tile_y = rand_range(0, self.max_size.y)
		create_fire(Vector2(tile_x, tile_y))

func create_fire(pos):
	var fireBounds = Rect2(Vector2(pos.x, pos.y), World.ItemSize)
	for element in get_node("dropped_items").get_children():
		var elemenBounds = Rect2(element.position, World.ItemSize)
		if(fireBounds.intersects(elemenBounds)):
			return
	
	var to_drop = fire.new(pos)
	to_drop.currentLevel = self
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
	
	if self.is_hole_placable_on(background_tile) && foreground_tile == TILE_NONE:
		var hole = load("res://items/hole/Hole.tscn");
		var instance = hole.instance()
		print(instance)
		instance.call("initialize", cell, $ForegroundTiles)
		instance.position = $Tiles.map_to_world(cell)

		get_node(hole_holder).add_child(instance)

		$ForegroundTiles.set_cellv(cell, TILE_HOLE)
		
func is_hole_placable_on(tile):
	return tile == TILE_BACKGROUND || tile == TILE_WINDOW || tile == TILE_LIGHT || tile == TILE_PIPES_UP


func calculate_health():
	var dripping_holes = 0
	for hole in get_node(hole_holder).get_children():
		var bucket = find_bucket(hole)
		if bucket != null && !bucket.is_bucket_full():
			bucket.fill_bucket()
		else:
			dripping_holes += 1
			
		var fire = find_fire(hole)
		if fire != null:
			fire.extinguish()
	
	
	
	if health - dripping_holes > 0:
		health -= dripping_holes
		if(health < 600 && health >= 300 && !music_stage_2):
			music_stage_2 = true
			music_stage_3 = false
			$"/root/Global/AudioManager".call("_music_stage_2")
		if(health < 300 && health <= 600  && !music_stage_3):
			music_stage_3 = true
			music_stage_2 = false
			$"/root/Global/AudioManager".call("_music_stage_3")
	else:
		health = 0
		$"RichTextLabel".show()

func find_bucket(hole):
	for element in get_node("dropped_items").get_children():
		if element is pickupable && element.item_type == World.Item.Bucket:
			if abs(element.position.x - (hole.position.x + 40))<40 && abs(element.position.y - hole.position.y)<160: 
				return element

	return null

func find_fire(hole):
	for element in get_node("dropped_items").get_children():
		if element is interactable && element.item_type == World.Item.Fire:
			if abs(element.position.x - (hole.position.x + 40))<40 && abs(element.position.y - hole.position.y)<160: 
				return element

	return null
	
func _process(_delta):
	if Input.is_action_pressed("stop"):
		get_tree().paused = true
		$"Panel".pause_mode = 2
		$"Panel/ResumeGame".grab_focus()
		
		$"Panel".show()
	
	for player in get_node(PlayerRoot).get_children():
		var tile = $Tiles.get_cellv($Tiles.world_to_map(player.position))
		player.is_on_ladder = tile == TILE_LADDER or tile == TILE_LADDER_TOP or tile == TILE_LADDER_BOTTOM

func _on_Timer_timeout():
	calculate_health()
	if randi()%101>98 && currentMotor.broken == false:
		currentMotor.breakMotor()
	if randi()%101>98:
		create_obstacle()
	if randi()%101>95:
		generate_new_fire()

func _on_Level_draw():
	pass
	
func enableSteerUp():
	currentMotor.steerUp = true

func disableSteerUp():
	currentMotor.steerUp = false
	
func enableSteerDown():
	currentMotor.steerDown = true

func disableSteerDown():
	currentMotor.steerDown = false
