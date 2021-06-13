extends KinematicBody2D

signal death

var Tail = load("res://Scenes/Tail.tscn")

var speed = 2
var direction = Vector2(1, 0)
var movement_coefficient = 1
var tail_spawn_rate = 0.05
var tail_spawn_time = 0

var glint_duration = 0.2
var glint_seconds_remaining = 0.2
var glint_cooldown_duration = 0.1
var glint_cooldown = glint_cooldown_duration

func on_death():
	# print("ohno")
	emit_signal("death")

#func on_glint():
#	print('glint')
#	emit_signal("glint")

func glint():
	print('I, the heroic glint() function, have been called!')
	if glint_cooldown <= 0:
		glint_seconds_remaining = glint_duration
		glint_cooldown = glint_cooldown_duration
		print('I, the heroic glint() function, must wait ' + String(glint_cooldown))
#	glint_seconds_remaining = glint_duration

func _input(event):
	if event is InputEventMouseMotion:
		self.direction = event.relative.normalized()
		glint()
		
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	tail_spawn_time += delta

	if (tail_spawn_time > tail_spawn_rate and glint_seconds_remaining > 0 and glint_cooldown > 0):
		var tail = Tail.instance()
		tail.position = position
		tail.get_node('./OuterTail').animation = 'Glint'
		tail.get_node('./OuterTail').z_index = +1
		tail.get_node('./OuterTail').scale = Vector2(1.2, 1.2)
		
		tail.connect('death', self, 'on_death')
		get_parent().add_child(tail)
	
		tail_spawn_time -= tail_spawn_rate
		glint_cooldown -= delta
		glint_seconds_remaining -= delta
		
	elif tail_spawn_time > tail_spawn_rate:
		var tail = Tail.instance()
		tail.position = position
		tail.get_node('./OuterTail').animation = 'default'
		tail.connect('death', self, 'on_death')
		get_parent().add_child(tail)
	
		tail_spawn_time -= tail_spawn_rate
	
#	elif glint_seconds_remaining > 0:
#		glint_seconds_remaining -= delta	
				
	var collision = move_and_collide(movement_coefficient * direction * speed)
	if collision:
		glint()
		var reflect = collision.remainder.bounce(collision.normal)
		direction = direction.bounce(collision.normal)
		move_and_collide(reflect)
