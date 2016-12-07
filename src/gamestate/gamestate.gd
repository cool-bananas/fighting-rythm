
extends Node2D

const HUD_PATH = "/root/main/HUD/"

signal gamestate_ready ()

export (String) var name

func _ready():
  connect("gamestate_ready", get_node(HUD_PATH + name), "_on_gamestate_ready")
