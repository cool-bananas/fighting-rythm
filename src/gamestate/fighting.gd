
extends "res://gamestate/gamestate.gd"

const PLAYERBODY = preload("res://player/player.tscn")

onready var setup = get_node("/root/setup")
onready var players = get_node("players")
onready var background = get_node("background")
onready var controllers = get_node("controllers")
onready var bgm = get_node("/root/main/BGM")

var ready = { "p1": false, "p2": false }

func _ready():
	print("Getting fight gamestate ready")
	load_player(1)
	load_player(2)
	load_background()
	finish_preparations()

func get_player_meta(pl):
	for player in players.get_children():
		if pl == player.which_player():
			return player.get_chara()

func load_player(pl):
	var player = PLAYERBODY.instance(pl)
	var charname = setup.get_player(pl)
	player.get_node("player_display").set_texture(load("res://assets/img/" + charname + ".tex"))
	player.set_id(pl)
	player.connect("player_ready", self, "_on_player_ready", [pl])
	player.set_chara(charname)
	players.add_child(player)
	print("Player instanced")
	if pl == 1:
		player.set_pos(Vector2(6 * 32 + 128, 500))
	elif pl == 2:
		player.set_pos(Vector2(6 * 32 + 924, 500))

func load_background():
	var bgidx = randi() % background.get_child_count()
	for bg in background.get_children():
		bg.hide()
	background.get_child(bgidx).show()

func _on_player_ready(pl):
	ready["p" + str(pl)] = true

func finish_preparations():
	if ready["p1"] and ready["p2"]:
		prepare_for_fight()
		print("GAMESTATE LOADED")
		emit_signal("gamestate_ready", get_player_meta(1), get_player_meta(2))
		var r = randi()
		var list_size = bgm.get_node("fighting").get_children().size()
		bgm.play(r % list_size)
		go_for_fight()

func prepare_for_fight():
	for controller in controllers.get_children():
		if not controller.is_input():
			controller.set_players(players)

func go_for_fight():
	for controller in controllers.get_children():
		if controller.is_input():
			controller.set_players(players)
