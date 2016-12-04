
extends "res://gamestate/controller.gd"

func _process(delta):
  for pl in get_players().get_children():
    if pl.get_state() == 'idle' or pl.get_state() == 'walk':
      face_opponent(pl)

func face_opponent(player):
  var opponent = get_opponent(player)
  if opponent.get_pos().x < player.get_pos().x:
    player.set_scale(Vector2(-1, 1))
    player.face("left")
  elif opponent.get_pos().x > player.get_pos().x:
    player.set_scale(Vector2(1, 1))
    player.face("right")
