extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var seconds_remaining

# Called when the node enters the scene tree for the first time.
func _ready():
	seconds_remaining = 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# self.position += delta * Vector2(1, 1)
	seconds_remaining -= delta
	if seconds_remaining <= 0:
		print("I am dead now goodbye")
		get_parent().remove_child(self)
