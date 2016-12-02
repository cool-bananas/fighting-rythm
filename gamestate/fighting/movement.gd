
extends Node

const ACTIONS = preload("res://actions.gd")

var player1
var player2

func set_p1(p1):
  player1 = p1

func set_p2(p2):
  player2 = p2

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
  elif action == ACTIONS.P1_A:
    pass
  elif action == ACTIONS.P1_B:
    pass
  elif action == ACTIONS.P1_C:
    pass
  elif action == ACTIONS.P2_UP:
    player2.jump()
  elif action == ACTIONS.P2_A:
    pass
  elif action == ACTIONS.P2_B:
    pass
  elif action == ACTIONS.P2_C:
    pass

func _on_p1_idle():
  player1.idle()

func _on_p2_idle():
  player2.idle()
