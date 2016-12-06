
extends "res://hud/menu/screen.gd"

const CHAR_ITEM = preload("res://hud/menu/char_select/char_item.tscn")

onready var chars = get_node("/root/database/chars").get_children()
onready var cursor1 = get_node("cursor1")
onready var cursor2 = get_node("cursor2")
onready var lists = [ get_node("list1"), get_node("list2") ]

var p1_selection = 0
var p2_selection = 0

func _ready():
  var j = 0
  var y = 5 * 64
  for chara in chars:
    j += 1
    if j % 3 == 0:
      y += 128
    for i in range(2):
      var y = 5 * 64 + j % 3
      var pos = Vector2(i * 512 + 64 + (j % 3) * 128, y )
      var item = CHAR_ITEM.instance()
      item.set_pos(pos)
      lists[i].add_child(item)
      item.set_char(chara.get_name())


func _on_press_action(action):
  pass
