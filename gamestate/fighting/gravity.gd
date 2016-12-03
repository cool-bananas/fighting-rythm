
extends "res://gamestate/controller.gd"

const G = Vector2(0, 8000)

func _fixed_process(delta):
  for pl in get_players().get_children():
    pl.accelerate(G * delta)
