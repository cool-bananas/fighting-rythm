
extends "res://hud/menu/screen.gd"

func focus():
  connect("press_action", self, "_on_press_action")

func unfocus():
  disconnect("press_action", self, "_on_press_action")

func _on_press_action(action):
  pass
