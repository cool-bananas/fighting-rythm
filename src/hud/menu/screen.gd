
extends Node2D

const ACTIONS = preload("res://actions.gd")

signal change_screen (idx)

onready var input = get_node("/root/input")
onready var setup = get_node("/root/setup")
onready var database = get_node("/root/database")

func focus():
  print("FOCUS: ", get_name())
  input.connect("press_action", self, "_on_press_action")
  on_focus()

func unfocus():
  print("UNFOCUS: ", get_name())
  if input.is_connected("press_action", self, "_on_press_action"):
    input.disconnect("press_action", self, "_on_press_action")
  on_unfocus()

func on_focus():
  pass

func on_unfocus():
  pass

func _on_press_action(action):
  pass
