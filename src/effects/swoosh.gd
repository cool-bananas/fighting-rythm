
extends Node2D

onready var animation = get_node("animation")

func swoosh(node, direction):
  var new_swoosh = self.new()
  node.add_child(new_swoosh)
  yield(new_swoosh, "ready")
  new_swoosh.animation.play(direction)
  yield(new_swoosh.animation, "finished")
  new_swoosh.queue_free()
