extends Area2D


const World = preload("res://Scripts/World.gd")

func interact_with_player(player):
	var item = player.take_item_if_eq(World.Item.Bedsheet);
	if item != null:
		$WholeSprite.texture = load("res://Assets/Sprites/icon.png")
