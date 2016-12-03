
extends KinematicBody2D

const EPSILON = 1
const WALK_ACC = Vector2(100, 0)
const JUMP_ACC = Vector2(0, -4000)
const FLOOR = 512

signal player_ready (pl)
signal change_state (st)

var speed = Vector2()
var state = 'idle'
var player

func _ready():
  connect("change_state", get_node("animation"), "_on_change_state")
  set_fixed_process(true)
  set_process(true)
  print("PLAYER ", player, " READY")
  state = 'idle'
  emit_signal("change_state", state)
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
    state = 'idle'
    emit_signal("change_state", state)

func set_id(pl):
  player = pl
  print("INITIALIZE PLAYER ", pl)

func which_player():
  return player

func walk(dir):
  if state != 'attack_A' and state != 'attack_B' and state != 'attack_C' :
    accelerate(WALK_ACC * dir)
    if state != 'jump' and state != 'walk':
      state = 'walk'
      emit_signal("change_state", state)

func jump():
  if state == 'idle' or state == 'walk':
    accelerate(JUMP_ACC)
    state = 'jump'
    emit_signal("change_state", state)

func idle():
  if state == 'walk':
    state = 'idle'
    emit_signal("change_state", state)

func attack(type):
  if type == 1:
    print("WEAK ATTACK!")
  elif type == 2:
    print("STRONG ATTACK!")
  elif type == 3:
    print("BULLET ATTACK!")

func get_state():
  return state

func accelerate(acc):
  speed += acc

func deaccelerate():
  speed *= 0.9
  if speed.length() <= EPSILON:
    speed.x = 0
    speed.y = 0
