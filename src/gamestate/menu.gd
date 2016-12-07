
extends "res://gamestate/gamestate.gd"

onready var bgm = get_node("/root/main/BGM")

func _ready():
  bgm.play(0)
  emit_signal("gamestate_ready", 0)
