extends KinematicBody2D

signal death

var tail = load("res://Tail.tscn")

var speed = 2
var direction = Vector2(1, 0)
var tail_spawn_rate = 0.05
var the_time = 0


func on_death():
	# print("ohno")
	emit_signal("death")
	
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
	# print(position)

	the_time += delta
	if the_time > tail_spawn_rate:
		var tail_ = tail.instance()
		tail_.position = position
		tail_.connect('death', self, 'on_death')
		get_parent().add_child(tail_)
	
		the_time -= tail_spawn_rate
	
	var collision = move_and_collide(direction * speed)
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		direction = direction.bounce(collision.normal)
		move_and_collide(reflect)
		
		
	# object "collision" contains information about the collision



func _on_Player_death():
	pass # Replace with function body.
