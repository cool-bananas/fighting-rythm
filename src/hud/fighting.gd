
extends Node

signal fight_message ()

onready var setup = get_node("/root/setup")
onready var lifebar_1 = get_node("lifebar_1")
onready var lifebar_2 = get_node("lifebar_2")
onready var messages = get_node("messages")

func _on_gamestate_ready(p1, p2):
  lifebar_1.load_character(p1)
  print(lifebar_1, p1)
  lifebar_2.load_character(p2)
  print(lifebar_2, p2)
  animate_fight()

func animate_fight():
  var animation = messages.get_node("animation")
  for n in messages.get_children():
    if n != animation:
      n.hide()
  messages.get_node("fight").show()
  animation.play("fight")
  yield(animation, "finished")
  emit_signal("fight_message")
