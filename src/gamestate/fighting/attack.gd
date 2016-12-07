
extends "res://gamestate/controller.gd"

const ACTIONS = preload("res://actions.gd")

onready var input = get_node("/root/input")

var player1
var player2

func is_input():
  return true

func _ready():
  yield(self, "players_are_set")
  set_each_player()
  load_input()

func load_input():
	input.connect("press_action", self, "_on_press_action")

func set_each_player():
  for pl in get_players().get_children():
    if pl.which_player() == 1:
      player1 = pl
    elif pl.which_player() == 2:
      player2 = pl

func _on_press_action(action):
  if action == ACTIONS.P1_A:
    player1.attack(1)
  elif action == ACTIONS.P1_B:
    player1.attack(2)
  elif action == ACTIONS.P1_C:
    player1.attack(3)
  elif action == ACTIONS.P2_A:
    player2.attack(1)
  elif action == ACTIONS.P2_B:
    player2.attack(2)
  elif action == ACTIONS.P2_C:
    player2.attack(3)
