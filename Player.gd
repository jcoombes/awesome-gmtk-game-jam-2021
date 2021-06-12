extends KinematicBody2D

var avg = Vector2()
var diff = Vector2()
var speed = 200
var cursor_positions = []
var velocity = Vector2(0, 0)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseMotion:
		self.velocity = event.relative.normalized() * 100
#		look_at(event.relative * 10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	move_and_slide(self.velocity)
	
	var buddy = add_child()
