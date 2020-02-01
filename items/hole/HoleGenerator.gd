extends Node

var _timer = null
var PlayerList
var keyMapDictionary : Dictionary
var spawnDictionary : Dictionary
									
var PlayerScene = preload("res://characters/players/Player.tscn")

func _ready():
	initDictionary()
	PlayerList = get_node("/root/Global").PlayerList
	
	for player in PlayerList:
		var newPlayer = PlayerScene.instance()
		newPlayer.keymap = keyMapDictionary[player]
		newPlayer.position = spawnDictionary[player].position
		add_child(newPlayer)
	
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false)
	_timer.start()

func initDictionary():
	keyMapDictionary["Player1"] = ["player_1_up", "player_1_down", "player_1_left",
								   "player_1_right", "player_1_interact", "player_1_drop_item"]
	keyMapDictionary["Player2"] = ["player_2_up", "player_2_down", "player_2_left", 
								   "player_2_right", "player_2_interact", "player_2_drop_item"]
	keyMapDictionary["Player3"] = ["player_3_up", "player_3_down", "player_3_left",
								   "player_3_right", "player_3_interact", "player_3_drop_item"]
	keyMapDictionary["Player4"] = ["player_4_up", "player_4_down", "player_4_left",
								   "player_4_right", "player_4_interact", "player_4_drop_item"]
								
	spawnDictionary["Player1"] = $"Geometry/PlayerSpawns/Spawn1"
	spawnDictionary["Player2"] = $"Geometry/PlayerSpawns/Spawn2"
	spawnDictionary["Player3"] = $"Geometry/PlayerSpawns/Spawn3"
	spawnDictionary["Player4"] = $"Geometry/PlayerSpawns/Spawn4"

func _on_Timer_timeout():
	if(randi()%101+1 > 75):
		var particles = Particles2D.new()
		particles.process_material = ParticlesMaterial.new()
		particles.process_material.scale = 5
		particles.process_material.color = Color(30, 200, 90)
		particles.emitting = true
		particles.position = Vector2(randi() % 800,randi() % 400+50);
		add_child(particles)
		print("hole!!")
		
		
