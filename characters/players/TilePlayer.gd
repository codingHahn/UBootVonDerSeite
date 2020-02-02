extends KinematicBody2D

var gravity = 800
onready var velocity:Vector2 = Vector2.ZERO

export var speed = 150

var is_on_ladder = false
var can_jump = false

var prefix
var level

export (NodePath) onready var drop_item_to
export (NodePath) onready var tilemap

# Do not export, because then it cannot be easily nulled at the beginning
# If this is exported, there is a ghostitem in the players hand that has
# to be discarded before he can pick up any object
var holding
var holdingValue

var disable_interact = false

const World = preload("res://levels/World.gd")

var asp: AudioStreamPlayer
var sounds = {
	"climb_ladder": load("res://characters/players/climb_ladder.wav"),
	"jump": load("res://characters/players/jump.wav")
}

func _ready():
	self.add_to_group("players")

	asp = AudioStreamPlayer.new()
	add_child(asp)
	
func _process(_delta):
	var has_disabled_gravity = is_on_ladder and holding == null

	velocity.x = 0
	if has_disabled_gravity:
		gravity = 0
		velocity.y = 0
	else:
		gravity = 800

	var currentSpeed = speed
	var fire = level.find_fire(self)
	if fire != null:
		currentSpeed = 50

	if Input.is_action_pressed(prefix + "_left"):
		velocity.x = -currentSpeed
	if Input.is_action_pressed(prefix + "_right"):
		velocity.x = currentSpeed
	if Input.is_action_pressed(prefix + "_up") and (is_on_floor() or has_disabled_gravity):
		velocity.y = -speed * 2
		asp.stream = sounds["climb_ladder" if has_disabled_gravity else "jump"]
		asp.play(0)
	if Input.is_action_pressed(prefix + "_down") and has_disabled_gravity:
		velocity.y = speed
		asp.stream = sounds["climb_ladder"]
		asp.play(0)
	
	play_animation_danke_michael_ismir_egal()
	handle_interaction()
	handle_drop()

func play_animation_danke_michael_ismir_egal():
	if velocity.x == 0:
		$Animation.play("idle")
	elif velocity.x > 0:
		$Animation.play("walk_right")
	else:
		$Animation.play("walk_left")

func handle_interaction():
	if Input.is_action_pressed(prefix + "_interact"):
		if !disable_interact:
			var areas = $InteractableArea.get_overlapping_areas()
			
			if holding == null:
				for element in areas:
					if element is pickupable:
						element.call("interact_with_player", self)
						disable_interact = true
						return
						
			for element in areas:
				if (element is pickupable) == false && element.has_method("interact_with_player"):
					element.call("interact_with_player", self)
					disable_interact = true
					return
	else:
		disable_interact = false

func handle_drop():
	if Input.is_action_pressed(prefix + "_drop_item"):
		if holding != null:
			var itemValue = self.get_item_value()
			var item = self.take_item()
			if item == World.Item.Bucket:
				level.create_bucket(self.position + $Holding.position, itemValue)
			else:
				var to_drop = pickupable.new(self.position + $Holding.position, item)
				get_node(drop_item_to).add_child(to_drop)
		self.set_holding(null, null)
	
func can_pickup():
	return holding == null

func get_item_value():
	return holdingValue

func take_item():
	var item = self.holding
	self.set_holding(null, null)
	return item
	
func take_item_if_eq(item):
	if holding != item:
		return null

	var tmp_holding = holding
	self.set_holding(null, null)
	return tmp_holding


func set_holding(item, value):
	holding = item
	holdingValue = value
	
	if item == null:
		$Holding.texture = null
	else:
		$Holding.texture = World.load_texture_for_item(item)
		var sx = World.ItemSize.x /  $Holding.texture.get_size().x 
		var sy = World.ItemSize.y /  $Holding.texture.get_size().y 
		$Holding.scale = Vector2(sx, sy)


func _physics_process(delta):
	var scaled_node = self.get_parent().get_parent().get_parent()
	velocity.y += gravity * delta
	velocity.x *= scaled_node.rect_scale.length();
	velocity = move_and_slide(velocity, Vector2.UP, true)
