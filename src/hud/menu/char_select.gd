
extends "res://hud/menu/screen.gd"

const CHAR_ITEM = preload("res://hud/menu/char_select/char_item.tscn")
const COLS = 3

onready var sfx = get_node("/root/main/SFX")
onready var chars = get_node("/root/database/chars").get_children()
onready var chars_display = [ get_node("char_display1"), get_node("char_display2") ]
onready var cursors = [ get_node("cursor1"), get_node("cursor2") ]
onready var list = get_node("list")
var selecting = [ true, true ]
var selection = [ 0, 0 ]
var initialised = false

func _ready():
  for n in range(chars.size()):
    add_char_item(n)
  for pl in range(2):
    set_cursor_color(pl)
    update_cursor_pos(pl)
    update_char_display(pl)

func _on_press_action(action):
  var pl = floor(action / ACTIONS.P2_UP)
  var act = action % ACTIONS.P2_UP
  if act < 4:
    move_selection(pl, act)
  else:
    handle_action(pl, act)

func get_square_pos(n):
  var x = 7 * 64 + (n % COLS) * 128
  var y = 6 * 64 + 128 * floor(n / COLS)
  return Vector2(x, y)

func add_char_item(n):
  var name = chars[n].get_name()
  var char = CHAR_ITEM.instance()
  list.add_child(char)
  char.set_pos(get_square_pos(n))
  char.set_char(name)

func move_selection(pl, dir):
  if not selecting[pl]:
    return

  sfx.play("move_cursor")
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
    if selecting[pl]:
      select_character(pl)
    elif not selecting[int(pl + 1) % 2]:
      confirm()
  elif act == 5:
    if selecting[pl]:
      go_back()
    else:
      unselect_character(pl)
  elif act == 6:
    pass
  elif act == 7:
    pass

func set_cursor_color(pl):
  var colors = cursors[pl].get_node("colors").get_children()
  colors[pl].show()

func update_cursor_pos(pl):
  var cursor = cursors[pl]
  var n = selection[pl]
  cursor.set_pos(get_square_pos(n))

func update_char_display(pl):
  var n = selection[pl]
  chars_display[pl].set_char(chars[n])
  chars_display[pl].set_player(pl)

func select_character(pl):
  var chara = chars[selection[pl]]
  var labels = cursors[pl].get_node("labels").get_children()
  var cursor_animation = cursors[pl].get_child(0)
  sfx.play("confirm_charas")
  setup.set_player(pl + 1, chara.get_name())
  cursor_animation.stop()
  cursor_animation.play("select")
  labels[pl].show()
  selecting[pl] = false

func unselect_character(pl):
  var cursor_animation = cursors[pl].get_child(0)
  var labels = cursors[pl].get_node("labels").get_children()
  sfx.play("cancel")
  cursor_animation.stop()
  cursor_animation.play("cursor")
  labels[pl].hide()
  selecting[pl] = true
  #play se: cancel

func set_selection():
  for pl in range(2):
    var cursor_animation = cursors[pl].get_child(0)
    var labels = cursors[pl].get_node("labels").get_children()
    cursor_animation.stop()
    cursor_animation.play("cursor")
    selecting[pl] = true
    #selection[pl] = 0
    update_cursor_pos(pl)
    for n in range(2):
      labels[n].hide()

func go_back():
  sfx.play("cancel")
  selection[0] = 0
  selection[1] = 0
  emit_signal("change_screen", -1)

func confirm():
  sfx.play("confirm_charas")
  unfocus()
  emit_signal("change_screen", 1)
  pass

func on_focus():
  set_selection()
