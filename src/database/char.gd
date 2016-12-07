
extends Node

signal char_ko ()
signal life_change ()

export (String) var name
export (int) var hp
export (float) var speed
export (float) var power

var player
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

func reset_health():
  damage = 0

func set_player(pl):
  player = pl

func get_player():
  return player

func take_dmg(dmg):
  print("life_change!")
  damage += dmg
  emit_signal("life_change")
  if damage >= hp:
    damage = hp
    print("CHAR IS DEAD")
    emit_signal("char_ko")
