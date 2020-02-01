extends Area2D

var check = 1
const World = preload("res://levels/World.gd")

func interact_with_player(player):
	if check<2:
		var item = player.take_item_if_eq(World.Item.Bedsheet);
		if item != null:
			$HoleSprite.texture = load("res://items/hole/abgedichtetesloch.jpeg")
			check = check+1
