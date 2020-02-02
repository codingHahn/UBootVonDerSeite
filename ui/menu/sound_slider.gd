extends HSlider

onready var controller = $"/root/Global/AudioManager"

func _ready():
	connect("value_changed", controller, "_on_sfx_slider_changed")
	value = controller.get_sfx_volume()

