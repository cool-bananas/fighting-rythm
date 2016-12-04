
extends Camera2D

const MAX_DISTANCE = 924-128

var position = Vector2()
var players

func set_players(players_node):
  players = players_node
  make_current()
  set_process(true)
  set_fixed_process(true)

func get_players():
  return players

func _process(delta):
  set_medium_position()
  set_ideal_zoom()
  set_pos(position)

func set_medium_position():
  var diff = Vector2()
  for pl in players.get_children():
    diff += pl.get_pos()
  diff /= 2
  position *= 0
  position += diff

func set_ideal_zoom():
  var diff = Vector2()
  var len = 0
  for pl in players.get_children():
    if diff.x == diff.y and diff.x == 0:
      diff += pl.get_pos()
    else:
      diff -= pl.get_pos()
  len = abs(diff.x)
  if len > MAX_DISTANCE:
    var z = (len / MAX_DISTANCE)
    print(z)
    set_zoom(Vector2(1, 1) * z)
  else:
    set_zoom(Vector2(1, 1))
