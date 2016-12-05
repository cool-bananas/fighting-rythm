
extends "res://hud/menu/screen.gd"

onready var animation = get_node("animation")

func focus():
  connect("press_action", self, "_on_press_action")

func unfocus():
  disconnect("press_action", self, "_on_press_action")

func _on_press_action(action):
  animation.play("accept")
  yield(animation, "finished")
  emit_signal("change_screen", 1)
  pass
