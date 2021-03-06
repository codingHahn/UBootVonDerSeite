extends pickupable
class_name bucket

const BUCKET_SIZE = 50.0
var wasFull

func _init(position: Vector2, fillsize).(position, World.Item.Bucket):
	value = fillsize
	if is_bucket_full():
		value = BUCKET_SIZE

	var rect = ColorRect.new()
	rect.name = "Back"
	rect.set_position(Vector2(-16, 20))
	rect.set_size(Vector2(32, 4))
	rect.color = Color(0.5,0.5,0.5)
	add_child(rect)

	rect = ColorRect.new()
	rect.name = "Progress"
	rect.set_position(Vector2(-16, 20))
	add_child(rect)
	update_bucket_bar()

func is_bucket_full():
	return value >= BUCKET_SIZE

func empty_bucket():
	value = 0
	update_bucket_bar()
	
func fill_bucket():
	value += 1
	update_bucket_bar()

func update_bucket_bar():
	var rect = get_node("Progress")
	if is_bucket_full():
		rect.color = Color(1,0,0)
	else:
		if value/BUCKET_SIZE > 0.7:
			rect.color = Color(1,1,0)
		else:
			rect.color = Color(0,1,0)
				
	rect.set_size(Vector2(value / BUCKET_SIZE * 32, 4))
	if !wasFull:
		if is_bucket_full():
			wasFull = true
			updateIcon(load("res://items/interactables/bucket/BucketWater.png"))
	else:
		if is_bucket_full() == false:
			wasFull = false
			updateIcon(World.load_texture_for_item(World.Item.Bucket))
			
