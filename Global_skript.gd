extends Node

export (Array) var PlayerList

func _ready():
	PlayerList.append("player_1")

func _player2_ready():
	PlayerList.append("player_2")

func _player3_ready():
	PlayerList.append("player_3")
	
func _player4_ready():
	PlayerList.append("player_4")
