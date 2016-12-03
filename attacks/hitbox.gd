
extends Area2D

onready var setup = get_node("/root/setup")
onready var database = get_node("/root/database")

export (float) var damage = 10
export (int, "weak", "strong") var strength

func _ready():
  connect("area_enter", self, "_on_area_enter")
  connect("body_enter", self, "_on_body_enter")

func _on_area_enter(attack):
  if is_hidden(): return
  print("CANCEL ATTACK")

func _on_body_enter(player):
  if is_hidden(): return
  print("HIT LANDED!")
  player.take_dmg(damage, strength)
