
extends Node

signal fight_message ()
signal player_win_message ()

onready var sfx = get_node("/root/main/SFX")
onready var setup = get_node("/root/setup")
onready var lifebar_1 = get_node("lifebar_1")
onready var lifebar_2 = get_node("lifebar_2")
onready var messages = get_node("messages")

func _on_gamestate_ready(p1, p2):
  lifebar_1.load_character(p1)
  lifebar_1.set_player(1)
  print(lifebar_1, p1)
  lifebar_2.load_character(p2)
  lifebar_2.set_player(2)
  print(lifebar_2, p2)
  get_node("/root/main/GAME/fighting").connect("char_is_dead", self, "_on_char_is_dead")
  animate_fight()

func animate_fight():
  var animation = messages.get_node("animation")
  for n in messages.get_children():
    if n != animation:
      n.hide()
  messages.get_node("fight").show()
  animation.play("fight")
  sfx.play("fight2")
  yield(animation, "finished")
  emit_signal("fight_message")

func _on_char_is_dead(pl):
  var animation = messages.get_node("animation")
  for n in messages.get_children():
    if n != animation:
      n.hide()
  messages.get_node("p" + str(pl % 2 + 1) + "_wins").show()
  animation.play("p" + str(pl % 2 + 1) + "_win")
  yield(animation, "finished")
  emit_signal("player_win_message")
