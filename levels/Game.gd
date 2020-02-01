extends Node2D


var lsize

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	
func _on_Node2D_draw():
	var vsize = self.get_viewport_rect().size
	var lsize = $UBoot.get_rect().size
	
	
	var scalex = (vsize.x / lsize.x) * (2.0 / 3.0)
	var scaley = (vsize.y / lsize.y) * (1.0 / 2.0)
	
	var mins = min(scalex, scaley)
	$UBoot.rect_scale = Vector2(mins, mins)
	$UBoot.rect_position = Vector2(0, (vsize.y / 2.0) - (lsize.y * mins / 2.0))
	
