extends HSlider

func _ready():
	connect("value_changed", $"/root/Global/AudioController", "_on_volume_changed")
	value = $"/root/Global/AudioController".volume_db * 2 + 80
