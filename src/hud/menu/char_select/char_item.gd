
extends Polygon2D

onready var database = get_node("/root/database")
onready var face = get_node("face")
onready var name = get_node("name")

func set_char(charname):
  face.set_texture(load("res://assets/img/" + name + "_face.tex"))
  name.set_text(charname)
