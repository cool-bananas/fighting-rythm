
extends Node

const GAMESTATES = "res://gamestate/"

export (String, "fighting", "rhythm", "menu") var initial
onready var gamestate = get_node("GAME")
var current

func _ready():
  var gs = load(GAMESTATES + initial + '.tscn')
  randomize()
  change_gamestate(initial)

func change_gamestate(next_gs):
  var gs = load(GAMESTATES + next_gs + '.tscn')
  var gamescene

  if not gs:
    get_tree().quit()

  if current:
    gamestate.get_node(current).queue_free()

  current = next_gs
  gamescene = gs.instance()
  gamestate.add_child(gamescene)
  change_hud(current)

func change_hud(next_hud):
  for hud in get_node("HUD").get_children():
    hud.hide()
  get_node("HUD/" + next_hud).show()

func get_current():
  return current
