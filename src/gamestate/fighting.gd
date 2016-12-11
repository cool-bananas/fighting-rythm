
extends "res://gamestate/gamestate.gd"

const PLAYERBODY = preload("res://player/player.tscn")

signal char_is_dead (pl)

onready var main = get_node("/root/main")
onready var fade = get_node("/root/main/FX/fade")
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
	if setup.get_player(1) == setup.get_player(2):
		players.get_child(1).get_node("player_display").set_modulate(Color(64.0/256, 222.0/256, 252.0/256))
	load_background()
	finish_preparations()

func get_player(pl):
	for player in players.get_children():
		if pl == player.which_player():
			return player

func get_player_meta(pl):
	return get_player(pl).get_chara()

func load_player(pl):
	var player = PLAYERBODY.instance()
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
		yield(get_hud(), "fight_message")
		connect_charas()
		go_for_fight()

func connect_charas():
	var char1 = get_player_meta(1)
	var char2 = get_player_meta(2)
	char1.reset_health()
	char2.reset_health()
	# you win message + change gamestate
	char1.connect("char_ko", self, "_on_char_ko", [1])
	char2.connect("char_ko", self, "_on_char_ko", [2])
	# player animation
	char1.connect("char_ko", get_player(1), "_on_char_ko")
	char2.connect("char_ko", get_player(2), "_on_char_ko")

func prepare_for_fight():
	for controller in controllers.get_children():
		if not controller.is_input():
			controller.set_players(players)

func go_for_fight():
	for controller in controllers.get_children():
		if controller.is_input():
			controller.set_players(players)

func stop_the_fight():
	for controller in controllers.get_children():
		if controller.is_input():
			controller.stop()

func delete_everything():
	for pl in players.get_children():
		pl.free()

func _on_char_ko(pl):
	stop_the_fight()
	# you win message
	emit_signal("char_is_dead", pl)
	yield(get_hud(), "player_win_message")
	fade.start(1.5)
	yield(fade, "fade_middle")
	delete_everything()
	# change_gamestate
	main.change_gamestate("menu")
