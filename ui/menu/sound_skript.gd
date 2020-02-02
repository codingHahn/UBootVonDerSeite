extends AudioStreamPlayer

func _ready():
	volume_db = -40;

func _on_volume_changed(value):
	volume_db = (value - 80) * 0.5
