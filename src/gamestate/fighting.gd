
extends "res://gamestate/gamestate.gd"

const PLAYERBODY = preload("res://player/player.tscn")

onready var setup = get_node("/root/setup")
onready var players = get_node("players")
onready var controllers = get_node("controllers")
onready var bgm = get_node("/root/main/BGM")

var ready = { "p1": false, "p2": false }

func get_player_meta(pl):
	for player in players.get_children():
		if pl == player.which_player():
			return player.get_chara()

func load_player(pl):
	var player = PLAYERBODY.instance(pl)
	var charname = setup.get_player(pl)
	player.get_node("sprite").set_texture(load("res://assets/" + charname + ".tex"))
	player.set_id(pl)
	player.connect("player_ready", self, "_on_player_ready", [pl])
	player.set_chara(charname)
	players.add_child(player)
	print("Player instanced")
	if pl == 1:
		player.set_pos(Vector2(128, 500))
	elif pl == 2:
		player.set_pos(Vector2(924, 500))

func _ready():
	print("Getting fight gamestate ready")
	load_player(1)
	load_player(2)
	finish_preparations()

func _on_player_ready(pl):
	ready["p" + str(pl)] = true

func finish_preparations():
	if ready["p1"] and ready["p2"]:
		for controller in controllers.get_children():
			controller.set_players(players)
		print("GAMESTATE LOADED")
		emit_signal("gamestate_ready", get_player_meta(1), get_player_meta(2))
		var r = randi()
		var list_size = bgm.get_node("fighting").get_children().size()
		bgm.play(r % list_size)
