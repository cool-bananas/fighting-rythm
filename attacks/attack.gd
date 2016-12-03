
extends Node2D

signal attack_done (type)

onready var animation = get_node("animation")
onready var hitboxes = {
  "weak": get_node("weak"),
  "strong": get_node("strong"),
  "bullet": get_node("bullet"),
}

func _ready():
  var test_sprite = get_node("test_sprite")
  if test_sprite:
    test_sprite.hide()
  stop_attack()

func set_player(pl):
  if pl == 1:
    hitboxes.weak.set_layer_mask(8)
    hitboxes.weak.set_collision_mask(4 + 64 + 128)
    hitboxes.strong.set_layer_mask(16)
    hitboxes.strong.set_collision_mask(4 + 128 + 256)
    hitboxes.bullet.set_layer_mask(32)
    hitboxes.bullet.set_collision_mask(4 + 256 + 64)
  elif pl == 2:
    hitboxes.weak.set_layer_mask(64)
    hitboxes.weak.set_collision_mask(2 + 8 + 16)
    hitboxes.strong.set_layer_mask(128)
    hitboxes.strong.set_collision_mask(4 + 16 + 32)
    hitboxes.bullet.set_layer_mask(256)
    hitboxes.bullet.set_collision_mask(4 + 32 + 8)

func set_hitbox(hitbox):
  stop_attack()
  hitbox.show()

func stop_attack():
  for i in hitboxes:
    hitboxes[i].hide()

func weak_attack():
  set_hitbox(hitboxes.weak)
  animation.stop()
  animation.play("weak")
  yield(animation, "finished")
  emit_signal("attack_done", 1)
  stop_attack()

func strong_attack():
  pass

func bullet_attack():
  pass
