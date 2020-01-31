extends "res://Scripts/Interactable.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	print("Button pressed")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_body_entered(player):
	player.set_interaction_target(self)

func interact_with_player(player):
	print("Player  ", player, " interacted with a button")
