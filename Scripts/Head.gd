extends KinematicBody2D

signal death
signal glint

var tail = load("res://Scenes/Tail.tscn")

var speed = 2
var direction = Vector2(1, 0)
var tail_spawn_rate = 0.05
var tail_spawn_time = 0

var glint_duration = 0.03
var glint_time = 0

func on_death():
	# print("ohno")
	emit_signal("death")

func on_glint():
	emit_signal("glint")
	
func physics_abstraction(delta, direction):
	tail_spawn_time += delta
	glint_time = 0
	
	if tail_spawn_time > tail_spawn_rate:
		var tail_ = tail.instance()
		tail_.position = position
		tail_.connect('death', self, 'on_death')
		get_parent().add_child(tail_)
	
		tail_spawn_time -= tail_spawn_rate
		
	var collision = move_and_collide(direction * speed)
	if collision:
		var reflect = collision.remainder.bounce(collision.normal)
		direction = direction.bounce(collision.normal)
		move_and_collide(reflect)
	

func _input(event):
	if event is InputEventMouseMotion:
		self.direction = event.relative.normalized()
		
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	physics_abstraction(delta, direction)
		
		
	# object "collision" contains information about the collision
