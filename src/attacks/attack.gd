
extends Node2D

const LAYERS = {
  "weak": {
    1: {
      "layer": 8,
      "collision": 4 + 64 + 128,
    },
    2: {
      "layer": 64,
      "collision": 2 + 8 + 16,
    },
  },
  "strong": {
    1: {
      "layer": 16,
      "collision": 4 + 128 + 256,
    },
    2: {
      "layer": 128,
      "collision": 2 + 16 + 32,
    },
  },
  "bullet": {
    1: {
      "layer": 32,
      "collision": 4 + 256 + 64,
    },
    2: {
      "layer": 256,
      "collision": 2 + 32 + 8,
    },
  }
}

signal attack_done (type)
signal attack_animation (type)

onready var animation = get_node("animation")
onready var hitboxes = {
  "weak": get_node("weak"),
  "strong": get_node("strong"),
  "bullet": get_node("bullet"),
}
var player

func _ready():
  var test_sprite = get_node("test_sprite")
  if test_sprite:
    test_sprite.hide()
  reset_hitbox_layers()
  stop_attack()

func set_player(pl):
  player = pl

func set_hitbox_layers(name):
  reset_hitbox_layers()
  hitboxes[name].set_layer_mask(LAYERS[name][player]["layer"])
  hitboxes[name].set_collision_mask(LAYERS[name][player]["collision"])

func reset_hitbox_layers():
  for name in hitboxes:
    hitboxes[name].set_layer_mask(0)
    hitboxes[name].set_collision_mask(0)

func set_hitbox(name):
  set_hitbox_layers(name)
  stop_attack()
  hitboxes[name].show()
  remove_child(hitboxes[name])
  add_child(hitboxes[name])

func stop_attack():
  for i in hitboxes:
    hitboxes[i].hide()

func weak_attack():
  set_hitbox("weak")
  animation.stop()
  animation.play("weak")
  emit_signal("attack_animation", "weak")
  yield(animation, "finished")
  done()

func strong_attack():
  set_hitbox("strong")
  animation.stop()
  animation.play("strong")
  emit_signal("attack_animation", "strong")
  yield(animation, "finished")
  done()

func bullet_attack():
  set_hitbox("bullet")
  animation.stop()
  animation.play("bullet")
  emit_signal("attack_animation", "bullet")
  yield(animation, "finished")
  done()

func done():
  reset_hitbox_layers()
  stop_attack()
  emit_signal("attack_done")
