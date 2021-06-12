extends KinematicBody2D

var tail = load("res://Tail.tscn")

var speed = 200
var direction = Vector2(0, 0)
var tail_spawn_rate = .5
var the_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		self.direction = event.relative.normalized()
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	print(position)

	the_time += delta
	if the_time > tail_spawn_rate:
		var tail_ = tail.instance()
		tail_.position = position
		get_parent().add_child(tail_)
	
		the_time -= tail_spawn_rate
		
	move_and_slide(speed * direction)
	
