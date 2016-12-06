
extends Node2D

onready var name = get_node("name")
onready var player_display = get_node("player_display")

func set_char(char):
  name.set_text(char.get_name())
  player_display.set_texture(load("res://assets/img/" + char.get_name() + ".tex"))
