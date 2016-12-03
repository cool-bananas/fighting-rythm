
extends KinematicBody2D

const EPSILON = 1
const WALK_ACC = Vector2(100, 0)
const JUMP_ACC = Vector2(0, -4000)
const FLOOR = 512

signal player_ready (pl)
signal change_state (st)
signal player_stagger (player, strength)

onready var database = get_node("/root/database")
onready var attacks = get_node("attack")
var speed = Vector2()
var state = 'idle'
var player
var chara

func _ready():
  var attacks = get_node("attack")
  attacks.set_player(player)
  connect("change_state", get_node("animation"), "_on_change_state")
  set_fixed_process(true)
  set_process(true)
  print("PLAYER ", player, " READY")
  set_state('idle')
  emit_signal("player_ready")

func _fixed_process(delta):
  var motion = self.move(speed * delta)
  deaccelerate()
  if is_colliding():
    var n = get_collision_normal()
    motion = n.slide(motion)
    speed = n.slide(speed)
    move(motion)

func _process(delta):
  if get_pos().y >= FLOOR and state != 'idle' and state != 'walk':
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

func walk(dir):
  if state != 'attack_A' and state != 'attack_B' and state != 'attack_C' :
    accelerate(WALK_ACC * dir)
    if state != 'jump' and state != 'walk':
      set_state('walk')

func jump():
  if state == 'idle' or state == 'walk':
    accelerate(JUMP_ACC)
    set_state('jump')

func idle():
  if state == 'walk':
    set_state('idle')

func attack(type):
  if state == 'attack_A' and state == 'attack_B' and state == 'attack_C' :
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

func set_state(st):
  state = st
  emit_signal("change_state", state)

func get_state():
  return state

func take_dmg(damage, strength):
  emit_signal("player_stagger", self, strength)
  get_chara().take_dmg(damage)

func accelerate(acc):
  speed += acc

func still():
  speed *= 0

func deaccelerate():
  speed *= 0.9
  if speed.length() <= EPSILON:
    still()
