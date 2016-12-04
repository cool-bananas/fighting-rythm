
extends KinematicBody2D

const EPSILON = 1
const WALK_ACC = Vector2(100, 0)
const JUMP_ACC = Vector2(0, -4000)
const FLOOR = 512

var speed = Vector2()

func _ready():
  set_fixed_process(true)

func _fixed_process(delta):
  var motion = self.move(speed * delta)
  deaccelerate()
  if is_colliding():
    var n = get_collision_normal()
    motion = n.slide(motion)
    speed = n.slide(speed)
    move(motion)

func get_speed():
  return speed

func accelerate(acc):
  speed += acc

func still():
  speed *= 0

func deaccelerate():
  speed *= 0.9
  if speed.length() <= EPSILON:
    still()
