extends Node

export (Array) var PlayerList

func _ready():
	PlayerList.append("Player1")

func _player2_ready():
	PlayerList.append("Player2")

func _player3_ready():
	PlayerList.append("Player3")
	
func _player4_ready():
	PlayerList.append("Player4")
