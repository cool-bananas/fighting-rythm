
extends "res://player/body.gd"

signal player_ready (pl)
signal change_state (st)
signal player_stagger (player, strength)

onready var database = get_node("/root/database")
onready var attacks = get_node("attack")
onready var timer = get_node("timer")
var state = 'idle'
var facing = 'right'
var player
var chara

func _ready():
  var attacks = get_node("attack")
  attacks.set_player(player)
  connect("change_state", get_node("animation"), "_on_change_state")
  set_process(true)
  print("PLAYER ", player, " READY")
  set_state('idle')
  emit_signal("player_ready")

func _process(delta):
  if get_pos().y >= FLOOR and state != 'idle' and state != 'walk':
    if state == 'stagger':
      return
    set_state('idle')

func set_chara(name):
  yield(self, "player_ready")
  var chars = database.get_node("chars")
  for char in chars.get_children():
    if char.get_name() == name:
      chara = char.duplicate()
      print(chara)

func get_chara():
  return chara

func set_id(pl):
  player = pl
  if player == 1:
    set_layer_mask(2)
    set_collision_mask(1 + 64 + 128 + 256)
  elif player == 2:
    set_layer_mask(4)
    set_collision_mask(1 + 8 + 16 + 32)
  print("INITIALIZE PLAYER ", pl)

func which_player():
  return player

func face(dir):
  facing = dir

func is_facing(dir):
  return facing == dir

func walk(dir):
  if state == 'stagger':
    return
  if state != 'attack_A' and state != 'attack_B' and state != 'attack_C' :
    accelerate(WALK_ACC * dir)
    if state != 'jump' and state != 'walk':
      set_state('walk')

func jump():
  if state == 'stagger':
    return
  if state == 'idle' or state == 'walk':
    accelerate(JUMP_ACC)
    set_state('jump')

func idle():
  if state == 'stagger':
    return
  if state == 'walk':
    set_state('idle')

func attack(type):
  if state == 'attack_A' or state == 'attack_B' or state == 'attack_C':
    return

  if state == 'stagger':
    return

  if type == 1:
    print("WEAK ATTACK!")
    still()
    set_state('attack_A')
    attacks.weak_attack()
    yield(attacks, "attack_done")
    set_state('idle')
  elif type == 2:
    print("STRONG ATTACK!")
    attacks.strong_attack()
  elif type == 3:
    print("BULLET ATTACK!")
    attacks.bullet_attack()

func stagger(dir, strength):
  timer.set_wait_time(.1 + (strength + 1) * .3)
  timer.start()
  accelerate(WALK_ACC * dir)
  set_state('stagger')
  yield(timer, "timeout")
  print("oooff!")
  set_state('idle')

func set_state(st):
  state = st
  emit_signal("change_state", state)

func get_state():
  return state

func take_dmg(damage, strength):
  if state != 'defend' and state != 'damage_heavy':
    emit_signal("player_stagger", self, strength)
    get_chara().take_dmg(damage)
