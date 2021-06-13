extends Node

var Start = load("res://Scenes/Start.tscn")

var Level1 = load("res://Scenes/Level1.tscn")
var Level2 = load("res://Scenes/Level2.tscn")
var Level3 = load("res://Scenes/Level3.tscn")

var Gameover = load("res://Scenes/Gameover.tscn")
var Win = load("res://Scenes/Win.tscn")

var Vibes = load("res://Scenes/Vibes.tscn")

var scene = null

# var possible_scenes = [start, level_1, level_2, level_3, gameover, win, vibes]

func _on_Start():
	var start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	scene = start
	add_child(scene)

func _on_Level1_started():
#	$Start.visible = !$Start.visible
	remove_child(scene)
	scene.queue_free()
	
	var level_1 = Level1.instance()
	level_1.connect("death", self, "_on_death")
	level_1.connect("eat_1", self, "_on_Level1_completed")
	scene = level_1
	add_child(scene)
	
func _on_death():
	remove_child(scene)
	scene.queue_free()
	
	var gameover = Gameover.instance()
	gameover.connect("replay", self, "_on_Replay")
	scene = gameover
	add_child(scene)

func _on_Level1_completed():
	remove_child(scene)
	scene.queue_free()
	
	var level_2 = Level2.instance()
	level_2.connect("death", self, "_on_death")
	level_2.connect("eat_2", self, "_on_Level2_completed")
	scene = level_2
	add_child(scene)

func _on_Level2_completed():
	remove_child(scene)
	scene.queue_free()
	
	var level_3 = Level3.instance()
	level_3.connect("death", self, "_on_death")
	level_3.connect("eat_3", self, "_on_win")
	
	scene = level_3
	add_child(scene)
	
func _on_win():
	remove_child(scene)
	scene.queue_free()
	
	var win = Win.instance()
	win.connect("replay", self, "_on_Replay")
	
	scene = win
	add_child(scene)

func _on_Vibes():
	remove_child(scene)
	scene.queue_free()
		
	var vibes = Vibes.instance()
	vibes.connect("unvibes", self, "_on_Replay")
	scene = vibes
	add_child(scene)

#func _on_Level3_completed():
#	self.remove_child(level_3)
#	level_4 = Level4.instance()
#	level_4.connect("death", self, "_on_death")
#	level_4.connect("eat", self, "_on_win")
#	self.add_child(level_4)
	
func _on_Replay():
	remove_child(scene)
	scene.queue_free()
	
	var start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	scene = start
	add_child(scene)

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("escape!"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if event.is_action_pressed("enscape."):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if event.is_action_pressed("vibes"):
		_on_Vibes()

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_on_Start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
