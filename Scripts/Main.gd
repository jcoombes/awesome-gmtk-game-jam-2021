extends Node

var Start = load("res://Scenes/Start.tscn")
var Level1 = load("res://Scenes/Level1.tscn")
var Gameover = load("res://Scenes/Gameover.tscn")

var start = null
var level = null
var gameover = null


func _on_Level1_started():
#	$Start.visible = !$Start.visible
	print("Started!")
	
	self.remove_child(start)
	level = Level1.instance()
	level.connect("death", self, "_on_Level1_death")
	self.add_child(level)
	
func _on_Level1_death():
	self.remove_child(level)
	gameover = Gameover.instance()
	gameover.connect("replay", self, "_on_Replay")
	self.add_child(gameover)
	
func _on_Replay():
	self.remove_child(gameover)
	start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	self.add_child(start)
	
func _on_Start():
	print("function _on_Start")
	start = Start.instance()
	start.connect("start", self, "_on_Level1_started")
	add_child(start)

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
