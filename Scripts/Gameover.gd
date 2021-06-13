extends Node2D
signal replay
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("replay"):
		emit_signal("replay")


func _on_Player_death():
	visible = true # Replace with function body.
