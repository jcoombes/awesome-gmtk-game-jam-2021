extends Node

var Start = load("res://Scenes/Start.tscn")

var Level1 = load("res://Scenes/Level1.tscn")
var Level2 = load("res://Scenes/Level2.tscn")
var Level3 = load("res://Scenes/Level3.tscn")

var Gameover = load("res://Scenes/Gameover.tscn")
var Win = load("res://Scenes/Win.tscn")

var start = null
var level = null
var level_2 = null
var level_3 = null
var gameover = null
var win = null

func _on_Start():
	start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	add_child(start)

func _on_Level1_started():
#	$Start.visible = !$Start.visible
	self.remove_child(start)
	level = Level1.instance()
	level.connect("death", self, "_on_death")
	level.connect("eat", self, "_on_win")
	self.add_child(level)
	
func _on_death():
	self.remove_child(level)
	gameover = Gameover.instance()
	gameover.connect("replay", self, "_on_Replay")
	self.add_child(gameover)

func _on_Level1_completed():
	self.remove_child(level)
	level_2 = Level2.instance()
	level_2.connect("death", self, "_on_death")
	level_2.connect("eat", self, "_on_Level2_completed")
	self.add_child(level_2)

func _on_Level2_completed():
	self.remove_child(level_2)
	level_3 = Level3.instance()
	level_3.connect("death", self, "_on_death")
	level_3.connect("eat", self, "_on_win")
	self.add_child(level_3)
	
func _on_win():
	self.remove_child(level)
	win = Win.instance()
	win.connect("replay", self, "_on_Replay")
	self.add_child(win)
	
func _on_Level3_completed():
	self.remove_child(level_3)
	level_3 = Level3.instance()
	level_3.connect("death", self, "_on_death")
	level_3.connect("eat", self, "_on_Level3_completed")
	self.add_child(level_3)
	
func _on_Replay():
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

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_on_Start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
