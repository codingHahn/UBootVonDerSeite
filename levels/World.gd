
enum Item {
	Gasoline,
	Bucket,
	Bedsheet
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
	return load("res://items/interactables/" + asset)
