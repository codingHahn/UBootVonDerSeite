extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var score_timer = Timer.new()
	add_child(score_timer)
	score_timer.connect("timeout", self, "update_score")
	score_timer.set_wait_time(1.0)
	score_timer.set_one_shot(false)
	score_timer.start()


func update_score():
	if $UBoot/Level.health <= 0:
		return
	if !$UBoot/Level.currentMotor.broken:
		score += 1
	$Score.text = "Distance: " + str(score)



func _on_Node2D_draw():
	var vsize = self.get_viewport_rect().size
	var lsize = $UBoot.get_rect().size
	
	
	var scalex = (vsize.x / lsize.x) * (2.0 / 3.0)
	var scaley = (vsize.y / lsize.y) * (1.0 / 2.0)
	
	var mins = min(scalex, scaley)
	$UBoot.rect_scale = Vector2(mins, mins)
	$UBoot.rect_position = Vector2(0, (vsize.y / 2.0) - (lsize.y * mins / 2.0))
	$UBoot/Level.max_size = Vector2(lsize.x, lsize.y)
	
