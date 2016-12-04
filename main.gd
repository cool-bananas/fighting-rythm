
extends Node

const GAMESTATES = "res://gamestate/"

export (String, "fighting", "rhythm", "menu") var initial
onready var gamestate = get_node("GAME")
var current

func _ready():
  var gs = load(GAMESTATES + initial + '.tscn')
  #current = add_child(gs.instance())
  change_gamestate(initial)

func change_gamestate(next_gs):
  var gs = load(GAMESTATES + next_gs + '.tscn')

  if not gs:
    get_tree().quit()

  if current:
    current.queue_free()

  current = gs.instance()
  print("Fighting instanced")
  gamestate.add_child(current)
  change_hud(next_gs)

func change_hud(next_hud):
  for huddy in get_node("HUD").get_children():
    huddy.hide()
  get_node("HUD/" + next_hud).show()

func get_current():
  return current
