extends Area2D

# With this class interactable objects can be specified
# They react to a player (e.g. a node thats in the group "players")
class_name interactable

# Here Enums get used for the Items. Maybe change that
const World = preload("res://levels/World.gd")

# icon is currently unused. Could be used to give the interactable Area2Ds 
# a visual representation
export (Texture) onready var icon

# The tooltip texture that is shown to the player
export (Texture) onready var tooltip_texture

# The item type this interactable generates
export (World.Item) var item_type

# The duration the tooltip is show to the player
export (float) var show_duration = 0.5

# Allocate helper nodes. A sprite for the tooltip and a time for the
# tooltip timeout
onready var tooltip = Sprite.new()
onready var texture = Sprite.new()
onready var timer = Timer.new()

func _ready():
	
	if icon != null:
		texture.texture = icon
		add_child(texture)
	# Initializes the tooltip texture
	tooltip.texture = tooltip_texture
	# Hide the tooltip by default
	tooltip.hide()
	tooltip.position.y -= 20
	# Required to be in front of the player
	tooltip.z_index = 1
	tooltip.scale = Vector2(0.3, 0.3)
	add_child(tooltip)
	
	# Initializes the timer
	timer.wait_time = show_duration
	timer.one_shot = true
	timer.connect("timeout", self, "_on_tooltip_timeout")
	add_child(timer)
	
	
	
func _physics_process(delta):
	# Check for overlapping players and display the tooltip to them
	var overlapping_bodies = self.get_overlapping_bodies()
	if !overlapping_bodies.empty():
		if overlapping_bodies.pop_back().is_in_group("players"):
			tooltip.show()
			if timer.is_stopped():
				timer.start()

func _on_tooltip_timeout():
	tooltip.hide()

# From the old implementation, will be reimplemented sometime(TM)
# TODO: Reimplement
func interact_with_player(player):
	if player.can_pickup():
		player.set_holding(item_type)
