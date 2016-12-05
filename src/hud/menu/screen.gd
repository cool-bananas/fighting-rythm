
extends Node2D

const ACTIONS = preload("res://actions.gd")

signal change_screen (idx)

onready var input = get_node("/root/input")
onready var setup = get_node("/root/setup")
onready var database = get_node("/root/database")

func _ready():
  connect("change_screen", get_parent(), "_on_change_screen")

func focus():
  # implement input connections
  pass

func unfocus():
  # implement input disconnections
  pass
