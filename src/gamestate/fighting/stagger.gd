
extends "res://gamestate/controller.gd"

func _ready():
  connect("players_are_set", self, "_on_players_set")

func _on_players_set():
  for player in get_players().get_children():
    player.connect("player_stagger", self, "_on_player_stagger")

func _on_player_stagger(player, strength):
  var opponent = get_opponent(player)
  var dir = 1
  if player.get_pos().x < opponent.get_pos().x:
    dir = -1
    if player.is_facing("left"):
      # BACK ATTACK!
      strength += 1
  elif player.get_pos().x > opponent.get_pos().x:
    dir = 1
    if player.is_facing("right"):
      # BACK ATTACK!
      strength += 1
  player.stagger(dir, strength)
