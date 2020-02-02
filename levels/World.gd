extends Node2D

const ItemSize = Vector2(32, 32)

enum Item {
	Gasoline,
	Bucket,
	Bedsheet,
	Toilet
}

static func load_texture_for_item(item):
	var asset = "";
	match item:
		Item.Gasoline:
			asset = "gasoline/Gasoline.png"
		Item.Bucket:
			asset = "bucket/Bucket.png"
		Item.Bedsheet:
			asset = "bed/Bedsheet.png"
		Item.Toilet:
			asset = "wc/wc.png"
	return load("res://items/interactables/" + asset)
