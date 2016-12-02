
extends Node

const G = Vector2(0, 8000)

var bodies = []

func _ready():
  set_fixed_process(true)

func _fixed_process(delta):
  for body in bodies:
    body.accelerate(G * delta)

func add_body(body):
  for b in bodies:
    if b == body: return
  bodies.append(body)
