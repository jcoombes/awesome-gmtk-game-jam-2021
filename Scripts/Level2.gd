extends Node2D
signal death
signal eat_2

var Player = load("res://Scenes/Player.tscn")
var Apple = load("res://Scenes/Apple.tscn")

var player_spawn = Vector2(960 - 430, 540)
var apple_spawn = Vector2(rand_range(0, 1920), rand_range(0,1080))

var players = []

var the_time = 0
var new_snake = 7

func _on_Player_death():
	emit_signal("death")

func _on_Player_eat():
	emit_signal("eat_2")

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

	var player = Player.instance()
	player.position = player_spawn
	player.connect("death", self, "_on_Player_death")
	add_child(player)
	players.push_back(player)
	
	var apple = Apple.instance()
	apple.position = apple_spawn
	apple.connect("eat", self, "_on_Player_eat")
	add_child(apple)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	the_time += delta
	
	if the_time > new_snake:
		var player = Player.instance()
		player.position = player_spawn
		player.connect("death", self, "_on_Player_death")
		add_child(player)
		players.push_back(player)
		
		the_time -= new_snake
#	pass
