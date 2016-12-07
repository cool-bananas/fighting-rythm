
extends Node2D

onready var SWOOSH = get_node("/root/main/FX/SWOOSH")
onready var main = get_node("/root/main")

func swoosh(position, direction):
  var new_swoosh = SWOOSH.duplicate()
  var animation = new_swoosh.get_node("animation")
  print("PREPARE SWOOSH")
  main.get_node("GAME/" + main.get_current()).add_child(new_swoosh)
  print("EXECUTE SWOOSH")
  new_swoosh.set_pos(position)
  new_swoosh.show()
  animation.stop()
  animation.play(direction)
  print(animation)
  yield(animation, "finished")
  print("SWOOSH IS A FREE ELF")
  new_swoosh.free()
