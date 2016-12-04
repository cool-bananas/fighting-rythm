
extends "res://gamestate/controller.gd"

const ACTIONS = preload("res://actions.gd")

onready var input = get_node("/root/input")

var player1
var player2

func _ready():
	yield(self, "players_are_set")
	set_each_player()
	load_input()

func load_input():
	input.connect("hold_action", self, "_on_hold_action")
	input.connect("press_action", self, "_on_press_action")
	input.connect("p1_idle", self, "_on_p1_idle")
	input.connect("p2_idle", self, "_on_p2_idle")

func set_each_player():
  for pl in get_players().get_children():
    if pl.which_player() == 1:
      player1 = pl
    elif pl.which_player() == 2:
      player2 = pl

func _on_hold_action(action):
  #print("HOLD: " + str(action))
  if   action == ACTIONS.P1_RIGHT:
    player1.walk(1)
  elif action == ACTIONS.P1_LEFT:
    player1.walk(-1)
  elif action == ACTIONS.P2_RIGHT:
    player2.walk(1)
  elif action == ACTIONS.P2_LEFT:
    player2.walk(-1)

func _on_press_action(action):
  print("PRESS: " + str(action))
  if action == ACTIONS.P1_UP:
    player1.jump()
  elif action == ACTIONS.P2_UP:
    player2.jump()

func _on_p1_idle():
  player1.idle()

func _on_p2_idle():
  player2.idle()
