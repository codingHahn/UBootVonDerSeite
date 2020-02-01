extends "res://items/interactable.gd"

var check = 1

func interact_with_player(player):
	print("Player wants to interact ", player)
	if check<2:
		var item = player.take_item_if_eq(World.Item.Bedsheet);
		if item != null:
			$Water.texture = load("res://items/hole/abgedichtetesloch.jpeg")
			$Animation.stop(true)
			check = check+1
