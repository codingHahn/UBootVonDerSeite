extends HSlider

onready var controller = $"/root/Global/AudioController"

func _ready():
	connect("value_changed", controller, "_on_volume_changed")
	controller.set_bus("Music")
	value = controller.volume_db * 2 + 80
