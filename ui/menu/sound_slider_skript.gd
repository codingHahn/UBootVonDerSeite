extends HSlider

func _ready():
	connect("changed", $"/root/Global", "_on_volume_change")
