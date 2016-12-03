
extends Node2D

const PLAYERBODY = preload("res://player.tscn")

onready var setup = get_node("/root/setup")
onready var players = get_node("players")
onready var controllers = get_node("controllers")

var ready = [ false, false ]

func load_player(pl):
	var player = PLAYERBODY.instance(pl)
	player.get_node("sprite").set_texture(load("res://assets/" + setup.get_player(pl) + ".tex"))
	player.set_id(pl)
	player.connect("player_ready", self, "_on_player_ready", [pl])
	players.add_child(player)
	print("Player instanced")
	if pl == 1:
		player.set_pos(Vector2(100, 256))
	elif pl == 2:
		player.set_pos(Vector2(924, 256))

func _ready():
	print("Getting fight gamestate ready")
	load_player(1)
	load_player(2)

func _on_player_ready(pl):
	ready[pl - 1] = true
	print(pl - 1)
	if ready[0] and ready[1]:
		for controller in controllers.get_children():
			controller.set_players(players)
		print("GAMESTATE LOADED")
