
extends "res://hud/menu/screen.gd"

const CHAR_ITEM = preload("res://hud/menu/char_select/char_item.tscn")
const COLS = 3

onready var chars = get_node("/root/database/chars").get_children()
onready var chars_display = [ get_node("char_display1"), get_node("char_display2") ]
onready var cursors = [ get_node("cursor1"), get_node("cursor2") ]
onready var lists = [ get_node("list1"), get_node("list2") ]
var selection = [ 0, 0 ]

func _ready():
  for n in range(chars.size()):
    for pl in range(2):
      add_char_item(pl, n)
  for pl in range(2):
    update_cursor_pos(pl)
    update_char_display(pl)

func _on_press_action(action):
  var pl = floor(action / ACTIONS.P2_UP)
  var act = action % ACTIONS.P2_UP
  if act < 4:
    move_selection(pl, act)
  else:
    handle_action(pl, act)

func get_square_pos(pl, n):
  var x = pl * 512 + 128 + (n % COLS) * 128
  var y = 6 * 64 + 128 * floor(n / COLS)
  return Vector2(x, y)

func add_char_item(pl, n):
  var name = chars[n].get_name()
  var char = CHAR_ITEM.instance()
  lists[n].add_child(char)
  char.set_pos(get_square_pos(pl, n))
  char.set_char(name)

func move_selection(pl, dir):
  var n = chars.size()
  if dir == 0:
    selection[pl] += 2 * n - COLS
  elif dir == 1:
    selection[pl] += 1
  elif dir == 2:
    selection[pl] += COLS
  elif dir == 3:
    selection[pl] += n - 1
  selection[pl] = selection[pl] % n
  print("SELECTION P", pl, ": ", selection[pl])
  update_cursor_pos(pl)
  update_char_display(pl)

func handle_action(pl, act):
  if act == 4:
    pass
  elif act == 6:
    selection[0] = 0
    selection[1] = 0
    emit_signal("change_screen", 0)
  elif act == 7:
    pass
    #selection[0] = 0
    #selection[1] = 0
    #emit_signal("change_screen", 0)
  elif act == 8:
    pass

func update_cursor_pos(pl):
  var cursor = cursors[pl]
  var n = selection[pl]
  cursor.set_pos(get_square_pos(pl, n))

func update_char_display(pl):
  var n = selection[pl]
  print(pl, n)
  chars_display[pl].set_char(chars[n])
  chars_display[pl].set_player(pl)
