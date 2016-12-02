
extends Node

const GAMESTATES = "res://gamestate/"

export (String, "fighting", "rhythm", "menu") var initial
var current

func _ready():
  var gs = load(GAMESTATES + initial + '.tscn')
  #current = add_child(gs.instance())
  change_gamestate(initial)

func change_gamestate(next_gs):
  var gs = load(GAMESTATES + next_gs + '.tscn')
  if not gs: self.queue_free()
  if current: current.queue_free()
  current = add_child(gs.instance())
  for huddy in get_node("HUD").get_children():
    huddy.hide()
  get_node("HUD/" + next_gs).show()
