
extends Node

onready var choices = get_node("/root/choices")
onready var lifebar_1 = get_node("lifebar_1")
onready var lifebar_2 = get_node("lifebar_2")

func _ready():
  lifebar_1.load_health(choices.get_player1())
  lifebar_2.load_health(choices.get_player2())
