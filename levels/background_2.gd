extends Sprite

var start_x

func _ready():
	start_x = self.position.x

func _process(delta):
	if not get_parent().currentMotor.broken:
		self.position.x -= 1
	if self.position.x < -600:
		self.position.x = 1580
