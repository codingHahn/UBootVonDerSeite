extends Node

const World = preload("res://Scripts/World.gd")

func interact_with_player(player):
	if player.can_pickup():
		player.set_holding(World.Item.Gasoline)
