extends Node2D
signal death

var player = load("res://Scenes/Player.tscn")
var antiplayer = load("res://Scenes/Antiplayer.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player_spawn = Vector2(960 - 430, 540)
var antiplayer_spawn = Vector2(960 + 430, 540)
var players = []

var the_time = 0
var new_snake = 10

func _on_Player_death():
	emit_signal("death")

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

	var player_ = player.instance()
	player_.position = player_spawn
	player_.connect("death", self, "_on_Player_death")
	add_child(player_)
	players.push_back(player_)
	
	var antiplayer_ = antiplayer.instance()
	antiplayer_.position = antiplayer_spawn
	antiplayer_.connect("death", self, "_on_Player_death")
	add_child(antiplayer_)
	players.push_back(antiplayer_)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	the_time += delta
	
	if the_time > new_snake:
		var player_ = player.instance()
		player_.position = player_spawn
		player_.connect("death", self, "_on_Player_death")
		add_child(player_)
		players.push_back(player_)
		
		

		var antiplayer_ = antiplayer.instance()
		antiplayer_.position = antiplayer_spawn
		antiplayer_.connect("death", self, "_on_Player_death")
		add_child(antiplayer_)
		players.push_back(antiplayer_)
		
		the_time -= new_snake
#	pass
