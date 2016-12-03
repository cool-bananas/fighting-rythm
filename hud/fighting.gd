
extends Node

onready var setup = get_node("/root/setup")
onready var lifebar_1 = get_node("lifebar_1")
onready var lifebar_2 = get_node("lifebar_2")

func _ready():
  lifebar_1.load_health(setup.get_player(1))
  lifebar_2.load_health(setup.get_player(2))
