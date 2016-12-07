
extends Area2D

onready var setup = get_node("/root/setup")
onready var database = get_node("/root/database")
onready var attack = get_parent()
onready var sfx = get_node("/root/main/SFX")

export (float) var damage = 10
export (int, "weak", "strong") var strength

func _ready():
  if not is_connected("area_enter", self, "_on_area_enter"):
    connect("area_enter", self, "_on_area_enter")
  if not is_connected("body_enter", self, "_on_body_enter"):
    connect("body_enter", self, "_on_body_enter")

func _on_area_enter(opponent_attack):
  if is_hidden(): return
  attack.done()
  print("CANCEL ATTACK")

func _on_body_enter(player):
  if is_hidden(): return
  print("HIT LANDED!")
  player.take_dmg(damage, strength)
  if strength == 0:
    sfx.play("weak")
  else:
    sfx.play("strong")
