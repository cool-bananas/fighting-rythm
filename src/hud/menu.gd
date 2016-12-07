
extends Control

onready var menus = get_node("screens").get_children()
onready var fade = get_node("/root/main/FX/fade")
onready var main = get_node("/root/main")
var focus = 0
var current

func _ready():
  for m in menus:
    m.connect("change_screen", self, "_on_change_screen")

func _on_gamestate_ready():
  print("READY")
  for m in menus:
    m.hide()
    m.unfocus()
  menus[focus].show()
  menus[focus].focus()

func _on_change_screen(idx):
  set_focus(idx)

func set_focus(idx):
  var old_focus = focus
  focus += idx
  print(old_focus)
  print(focus)
  if focus >= menus.size():
    go_to_fighting()
    return
  menus[old_focus].unfocus()
  print(old_focus, " unfocused")
  fade.start(1.5)
  yield(fade, "fade_middle")
  for m in menus:
    m.hide()
  menus[focus].show()
  yield(fade, "fade_end")
  menus[focus].focus()

func go_to_fighting():
  fade.start(1.2)
  yield(fade, "fade_middle")
  for m in menus:
    m.hide()
    m.unfocus()
  main.change_gamestate("fighting")
