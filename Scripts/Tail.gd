extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var the_time = 0
var init_not_deadly = .2
var seconds_remaining = 3

signal death

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	the_time += delta
	
	seconds_remaining -= delta
	if seconds_remaining <= 0:
		get_parent().remove_child(self)


func _on_Tail_area_entered(area):
	if the_time > init_not_deadly:
		emit_signal("death")
