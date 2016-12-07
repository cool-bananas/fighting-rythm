
extends "res://player/body.gd"

signal player_ready (pl)
signal change_state (st)
signal player_stagger (player, strength)
signal player_attack (player, strength)

onready var swoosh = get_node("/root/main/FX/SWOOSH")
onready var display = get_node("player_display")
onready var database = get_node("/root/database")
onready var attacks = get_node("attack")
onready var timer = get_node("timer")
onready var tween = get_node("tween")
var state = 'idle'
var facing = 'right'
var player
var chara
var combo = {
  "weak": 0,
  "strong": 0,
  "bullet": 0,
}

func _ready():
  var attacks = get_node("attack")
  attacks.set_player(player)
  attacks.connect("attack_animation", self, "_on_attack_animation")
  connect("change_state", display, "_on_change_state")
  set_process(true)
  print("PLAYER ", player, " READY")
  set_state('idle')
  emit_signal("player_ready")

func _process(delta):
  if get_pos().y >= FLOOR and state == 'jump':
      set_state('idle')
      var pos = Vector2(display.get_global_pos().x, FLOOR - 32)
      swoosh.swoosh(pos, "down")

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
  if state != 'attack' :
    accelerate(WALK_ACC * dir)
    if state != 'jump' and state != 'walk':
      set_state('walk')

func jump():
  if state == 'stagger':
    return
  if state == 'idle' or state == 'walk':
    swoosh.swoosh(display.get_global_pos() + Vector2(0, 16), "down")
    accelerate(JUMP_ACC)
    set_state('jump')

func idle():
  if state == 'walk':
    set_state('idle')

func attack(type):
  if state == 'stagger' or state == 'attack_a' or state == 'attack_b' or state == 'attack_c':
    return

  if type == 1:
    print("WEAK ATTACK!")
    emit_signal("player_attack", self, "weak")
  elif type == 2:
    print("STRONG ATTACK!")
    emit_signal("player_attack", self, "strong")
  elif type == 3:
    print("BULLET ATTACK!")
    emit_signal("player_attack", self, "bullet")

func stagger(dir, strength):
  var t = .3 + (strength + 1) * 1/60
  var acc = WALK_ACC * 0.5 * dir * (strength + 1) * (strength + 1)
  var offset = Vector2(-dir * 64, -16)
  tween.interpolate_method(self, "accelerate", 2 * acc, 0.5 * acc, t, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
  tween.start()

  if dir < 0:
    swoosh.swoosh(display.get_global_pos() + offset, "left")
  else:
    swoosh.swoosh(display.get_global_pos() + offset, "right")
  set_state('stagger')
  yield(tween, "tween_complete")
  set_state('idle')

func set_state(st):
  state = st
  emit_signal("change_state", state)

func get_state():
  return state

func get_timer():
  return timer

func set_timer(t):
  timer.stop()
  timer.set_wait_time(t)
  timer.start()
  return timer

func get_attacks():
  return attacks

func reset_combo():
  for c in combo:
    combo[c] = 0

func get_combo():
  return combo

func take_dmg(damage, strength):
  if state != 'defend' and state != 'damage_heavy':
    emit_signal("player_stagger", self, strength)
    print("Taking damage: ", damage)
    get_chara().take_dmg(damage)

func _on_attack_animation(type):
  if type == 'weak':
    var acc = WALK_ACC * .5
    if facing == 'left':
      acc *= -1
    tween.interpolate_method(self, "accelerate", 2 * acc, 0.5 * acc, .1, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
    tween.start()
  if type == 'strong':
    var acc = WALK_ACC * 2.5
    if facing == 'left':
      acc *= -1
    tween.interpolate_method(self, "accelerate", 2 * acc, 0.5 * acc, .1, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
    tween.start()
