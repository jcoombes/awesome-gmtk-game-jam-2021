extends "res://Scripts/Head.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	print('Im a antihead and I am ready')
	direction = Vector2(-1, 0)

func _input(event):
	if event is InputEventMouseMotion:
		direction = event.relative.normalized()

func _physics_process(delta):
	.physics_abstraction(delta, -1 * direction * speed)
