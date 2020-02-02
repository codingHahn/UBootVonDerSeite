extends interactable
class_name toilet

var level

func _init(position: Vector2):
	var item = World.Item.Toilet
	self.position = position
	self.item_type = item
	self.icon = World.load_texture_for_item(item)
	
func interact_with_player(player):
	var item = player.take_item_if_eq(World.Item.Bucket);
	if item != null:
		level.empty_bucket(item)
