extends Polygon2D

const max_health = 1000.0

var initial_scale
var scale_fraction

func _ready():
	#initial_scale = scale 
	#scale.y = scale.y / 1000
	
	#scale_fraction = scale.y
	pass
	
func _process(_delta):
	var bounds = $Bounds.get_rect().size
	
	var percentage_destroyed = (max_health - $"../../Level".health) / max_health
	var height = bounds.y * percentage_destroyed
	
	self.material.set_shader_param("height", Vector3(bounds.x, height, 4096))
