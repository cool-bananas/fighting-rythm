
extends "res://hud/menu/screen.gd"

onready var animation = get_node("animation")

func _on_press_action(action):
  animation.play("accept")
  yield(animation, "finished")
  emit_signal("change_screen", 1)
  pass

func on_focus():
  animation.play("blink")
