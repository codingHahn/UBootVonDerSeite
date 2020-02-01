extends Sprite


var initial_scale
var scale_fraction

func _ready():
	initial_scale = scale 
	scale.y = scale.y / 1000
	
	scale_fraction = scale.y
	
func _process(delta):
	scale.y = scale_fraction * (1000 - $"../../Level".health)
