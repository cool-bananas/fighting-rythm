
extends Node

signal char_ko ()
signal life_change ()

export (String) var name
export (int) var hp
export (float) var speed
export (float) var power

var damage = 0

func get_hp():
  return hp

func get_name():
  return name

func get_speed():
  return speed

func get_power():
  return power

func get_current_hp():
  return hp - damage

func take_dmg(dmg):
  print("life_change!")
  damage += dmg
  emit_signal("life_change")
  if damage >= hp:
    damage = hp
    emit_signal("char_ko", get_name())
