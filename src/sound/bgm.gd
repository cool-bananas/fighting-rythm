
extends Node

onready var main = get_node("/root/main")

func play(track):
  var gs = main.get_current()
  var playlist = get_node(gs).get_children()
  var next = playlist[track]
  for p in get_children():
    for t in p.get_children():
      if t != next:
        t.stop()
  if not next.is_playing():
    next.play()
