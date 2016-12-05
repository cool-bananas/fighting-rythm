
extends Control

onready var menus = get_node("screens").get_children()
onready var fade = get_node("/root/main/FX/fade")
var focus = 0

func _on_gamestate_ready():
  print("READY")
  set_focus(focus)

func _on_change_screen(idx):
  set_focus(idx)

func set_focus(idx):
  if focus != -1:
    menus[focus].unfocus()
    fade.start(1)
    yield(fade, "fade_middle")
    for m in menus:
      m.hide()
    menus[idx].show()
    yield(fade, "fade_end")
    menus[idx].focus()
  else:
    for m in menus:
      m.hide()
      m.unfocus()
