
extends Node2D

const GRAVITY = preload("res://gamestate/fighting/gravity.gd")
const MOVEMENT = preload("res://gamestate/fighting/movement.gd")
const COLLISION = preload("res://gamestate/fighting/collision.gd")

const CHARACTERS = "res://characters/"

onready var choices = get_node("/root/choices")
onready var input = get_node("/root/input")
onready var gravity = GRAVITY.new()
onready var movement = MOVEMENT.new()
var player1
var player2

func load_player1():
	var chara = load(CHARACTERS + choices.get_player1() + ".tscn")
	player1 = chara.instance()
	gravity.add_body(player1)
	movement.set_p1(player1)
	player1.set_pos(Vector2(100, 128))
	self.add_child(player1)

func load_player2():
	var chara = load(CHARACTERS + choices.get_player2() + ".tscn")
	player2 = chara.instance()
	gravity.add_body(player2)
	movement.set_p2(player2)
	player2.set_pos(Vector2(924, 128))
	self.add_child(player2)

func load_input():
	input.connect("hold_action", movement, "_on_hold_action")
	input.connect("press_action", movement, "_on_press_action")
	input.connect("p1_idle", movement, "_on_p1_idle")
	input.connect("p2_idle", movement, "_on_p2_idle")

func _ready():
	self.add_child(gravity)
	self.add_child(movement)
	load_player1()
	load_player2()
	load_input()
	print("GAMESTATE LOADED")
