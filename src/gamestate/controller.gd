
extends Node

signal players_are_set ()
signal stop_controller ()

var players

func _ready():
  connect("stop_controller", self, "_on_stop")

func set_players(players_node):
  players = players_node
  set_process(true)
  set_fixed_process(true)
  emit_signal("players_are_set")

func get_players():
  return players

func get_opponent(player):
  for pl in get_players().get_children():
    if pl != player:
      return pl

func is_input():
  return false

func stop():
  set_process(false)
  set_fixed_process(false)
  emit_signal("stop_controller")

func _on_stop():
  pass
