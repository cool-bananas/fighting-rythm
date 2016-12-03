
extends "res://gamestate/controller.gd"

func _ready():
  connect("players_are_set", self, "_on_players_set")

func _on_players_set():
  for player in get_players().get_children():
    player.connect("player_stagger", self, "_on_player_stagger")

func _on_player_stagger(player, strength):
  pass
