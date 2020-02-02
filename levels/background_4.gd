extends Sprite


func _process(delta):
	if not get_parent().currentMotor.broken:
		self.position.x -= 4
