
extends Node

var player1 = 'dummy'
var player2 = 'dummy'
var background = 'none'

func set_player(pl, chara):
  if pl == 1:
    player1 = chara
  elif pl == 2:
    player2 = chara

func get_player(pl):
  if pl == 1:
    return player1
  elif pl == 2:
    return player2
