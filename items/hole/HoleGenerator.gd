extends Node

var _timer = null

func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(1.0)
	_timer.set_one_shot(false)
	_timer.start()

func _on_Timer_timeout():
	if(randi()%101+1 > 75):
		var particles = Particles2D.new()
		particles.process_material = ParticlesMaterial.new()
		particles.process_material.scale = 5
		particles.process_material.color = Color(30, 200, 90)
		particles.emitting = true
		particles.position = Vector2(randi() % 800,randi() % 400+50);
		add_child(particles)
		print("hole!!")
