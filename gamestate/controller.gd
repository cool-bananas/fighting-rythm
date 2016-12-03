
extends Node

signal players_are_set ()

var players = []

func set_players(players_node):
  players = players_node
  set_process(true)
  set_fixed_process(true)
  emit_signal("players_are_set")

func get_players():
  return players
