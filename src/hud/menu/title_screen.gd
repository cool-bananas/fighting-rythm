
extends "res://hud/menu/screen.gd"

onready var animation = get_node("animation")

func _on_press_action(action):
  animation.play("accept")
  unfocus()
  yield(animation, "finished")
  emit_signal("change_screen", 1)

func on_focus():
  animation.play("blink")
