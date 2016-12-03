
extends Node

onready var setup = get_node("/root/setup")
onready var lifebar_1 = get_node("lifebar_1")
onready var lifebar_2 = get_node("lifebar_2")

func _on_fighting_ready(p1, p2):
  lifebar_1.load_health(p1)
  print(lifebar_1, p1)
  lifebar_2.load_health(p2)
  print(lifebar_2, p2)
