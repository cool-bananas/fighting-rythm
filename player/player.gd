
extends KinematicBody2D

const EPSILON = 2e-5
const WALK_ACC = Vector2(100, 0)
const JUMP_ACC = Vector2(0, -4000)
const FLOOR = 512

signal change_state (st)

var speed = Vector2()
var state = 'idle'

func _ready():
  set_fixed_process(true)
  set_process(true)

func _fixed_process(delta):
  var motion = self.move(speed * delta)
  deaccelerate()
  if is_colliding():
    var n = get_collision_normal()
    motion = n.slide(motion)
    speed = n.slide(speed)
    move(motion)

func _process(delta):
  if state == 'idle' or state == 'walk':
    face_opponent()
  if get_pos().y >= FLOOR and state != 'idle' and state != 'walk':
    state = 'idle'
    emit_signal("change_state", state)

func walk(dir):
  if state != 'attack':
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
  if state != 'jump' and state != 'attack' and state != 'idle':
    pass
    #print("here!")
    #state = 'idle'
    #emit_signal("change_state", state)

func face_opponent():
  var opponent = get_opponent()
  if opponent.get_pos().x < get_pos().x:
    set_scale(Vector2(-1, 1))
  elif opponent.get_pos().x > get_pos().x:
    set_scale(Vector2(1, 1))

func get_opponent():
  var players = get_parent().get_children()
  for pl in players:
    if pl != self:
      return pl

func accelerate(acc):
  speed += acc

func deaccelerate():
  speed *= 0.9
  if speed.length() <= EPSILON:
    speed.x = 0
    speed.y = 0
