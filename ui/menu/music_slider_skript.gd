extends HSlider

onready var controller = $"/root/Global/AudioManager"

func _ready():
	connect("value_changed", controller, "_on_music_slider_changed")
	value = controller.get_music_volume()
	
	

