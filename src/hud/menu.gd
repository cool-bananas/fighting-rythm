
extends Control

onready var menus = get_node("screens").get_children()
onready var fade = get_node("/root/main/FX/fade")
var focus = 0

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
  menus[focus].unfocus()
  fade.start(1.0)
  print("fading in...")
  yield(fade, "fade_middle")
  print("fading out...")
  for m in menus:
    m.hide()
  menus[idx].show()
  yield(fade, "fade_end")
  menus[idx].focus()
