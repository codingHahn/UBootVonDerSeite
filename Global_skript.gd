extends Node

export (Array) var PlayerList

func _ready():
	_resetPlayerList()

func _player2_ready():
	if not "player_2" in PlayerList:
		PlayerList.append("player_2")

func _player3_ready():
	if not "player_3" in PlayerList:
		PlayerList.append("player_3")
	
func _player4_ready():
	if not "player_4" in PlayerList:
		PlayerList.append("player_4")
		
func _resetPlayerList():
	PlayerList = ["player_1"]
