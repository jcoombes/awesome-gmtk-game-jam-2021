extends Node2D
signal start

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("I live! I start! I breathe")
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("start"):
		emit_signal('start')
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#
