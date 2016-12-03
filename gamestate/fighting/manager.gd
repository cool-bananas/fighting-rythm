
extends Node

onready var players = get_parent().get_node("players")

func _ready():
  set_process(true)

func _process(delta):
  for pl in players.get_children():
    if pl.get_state() == 'idle' or pl.get_state() == 'walk':
      face_opponent(pl)

func face_opponent(player):
  var opponent = get_opponent(player)
  if opponent.get_pos().x < player.get_pos().x:
    player.set_scale(Vector2(-1, 1))
  elif opponent.get_pos().x > player.get_pos().x:
    player.set_scale(Vector2(1, 1))

func get_opponent(player):
  for pl in players.get_children():
    if pl != player:
      return pl
