extends Node

export (NodePath) onready var background_1_path
export (NodePath) onready var background_2_path
export (NodePath) onready var background_3_path
export (NodePath) onready var animation_player_path

onready var background_1 : AudioStreamPlayer = get_node(background_1_path)
onready var background_2 : AudioStreamPlayer = get_node(background_2_path)
onready var background_3 : AudioStreamPlayer = get_node(background_3_path)
onready var animation_player = get_node(animation_player_path)

var music_bus = AudioServer.get_bus_index("Music")
var sfx_bus = AudioServer.get_bus_index("Soundeffects")

func _ready():
	AudioServer.set_bus_volume_db(music_bus, -40)
	AudioServer.set_bus_volume_db(sfx_bus, -40)
	

	
	background_1.play()
	background_2.play()
	background_3.play()
	
	background_1.set_volume_db(10)
	background_2.set_volume_db(-80)
	background_3.set_volume_db(-80)
	
func get_sfx_volume():
	return AudioServer.get_bus_volume_db(sfx_bus)
	
func get_music_volume():
	return AudioServer.get_bus_volume_db(music_bus)

func _on_music_slider_changed(value):
	AudioServer.set_bus_volume_db(music_bus, value)
	
func _on_sfx_slider_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, value)

func _music_stage_2():
	animation_player.play("1to2")

func _music_stage_3():
	animation_player.play("2to3")

