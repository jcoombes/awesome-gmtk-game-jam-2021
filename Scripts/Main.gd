extends Node

var Start = load("res://Scenes/Start.tscn")

var Level1 = load("res://Scenes/Level1.tscn")
var Level2 = load("res://Scenes/Level2.tscn")
var Level3 = load("res://Scenes/Level3.tscn")

var Gameover = load("res://Scenes/Gameover.tscn")
var Win = load("res://Scenes/Win.tscn")

var Vibes = load("res://Scenes/Vibes.tscn")

var start = null
var level_1 = null
var level_2 = null
var level_3 = null
var gameover = null
var win = null
var vibes = null

var possible_scenes = [start, level_1, level_2, level_3, gameover, win, vibes]

func _on_Start():
	start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	add_child(start)

func _on_Level1_started():
#	$Start.visible = !$Start.visible
	self.remove_child(start)
	level_1 = Level1.instance()
	level_1.connect("death", self, "_on_death")
	level_1.connect("eat_1", self, "_on_Level1_completed")
	self.add_child(level_1)
	
func _on_death():
	self.remove_child(level_1)
	self.remove_child(level_2)
	self.remove_child(level_3)
	gameover = Gameover.instance()
	gameover.connect("replay", self, "_on_Replay")
	self.add_child(gameover)

func _on_Level1_completed():
	self.remove_child(level_1)
	level_2 = Level2.instance()
	level_2.connect("death", self, "_on_death")
	level_2.connect("eat_2", self, "_on_Level2_completed")
	self.add_child(level_2)

func _on_Level2_completed():
	self.remove_child(level_2)
	level_3 = Level3.instance()
	level_3.connect("death", self, "_on_death")
	level_3.connect("eat_3", self, "_on_win")
	self.add_child(level_3)
	
func _on_win():
	self.remove_child(level_3)
	win = Win.instance()
	win.connect("replay", self, "_on_Replay")
	self.add_child(win)

func _on_Vibes():
	for n in self.get_children():
		self.remove_child(n)
		
	for poss_scene in possible_scenes:
		self.remove_child(poss_scene)
	vibes = Vibes.instance()
	vibes.connect("unvibes", self, "_on_Replay")
	self.add_child(vibes)

#func _on_Level3_completed():
#	self.remove_child(level_3)
#	level_4 = Level4.instance()
#	level_4.connect("death", self, "_on_death")
#	level_4.connect("eat", self, "_on_win")
#	self.add_child(level_4)
	
func _on_Replay():
	self.remove_child(vibes)
	self.remove_child(gameover)
	self.remove_child(win)
	start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	self.add_child(start)

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
