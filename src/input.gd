
extends Node

const ACTION = preload("res://actions.gd")

var KEYMAP = {
"p1_up": ACTION.P1_UP,
"p1_right": ACTION.P1_RIGHT,
"p1_down":  ACTION.P1_DOWN,
"p1_left":  ACTION.P1_LEFT,

"p1_a":     ACTION.P1_A,
"p1_b":     ACTION.P1_B,
"p1_c":     ACTION.P1_C,
"p1_pause": ACTION.P1_PAUSE,
"p1_quit":  ACTION.P1_QUIT,

"p2_up":    ACTION.P2_UP,
"p2_right": ACTION.P2_RIGHT,
"p2_down":  ACTION.P2_DOWN,
"p2_left":  ACTION.P2_LEFT,

"p2_a":     ACTION.P2_A,
"p2_b":     ACTION.P2_B,
"p2_c":     ACTION.P2_C,
"p2_pause": ACTION.P2_PAUSE,
"p2_quit":  ACTION.P2_QUIT,
}

signal hold_action (act)
signal press_action (act)
signal p1_idle ()
signal p2_idle ()

func _ready():
  set_process(true)
  set_process_input(true)

func _input(event):
  var act = get_pressed_action(event)
  if act != null:
    print(act)
    emit_signal("press_action", act)

func _process(delta):
  get_held_actions(Input)

func get_held_actions(e):
  var idle = true
  for key in KEYMAP:
    if e.is_action_pressed(key):
      idle = false
      var act = KEYMAP[key]
      emit_signal("hold_action", act)
    if key == "p1_quit":
      if idle: emit_signal("hold_action", -1)
      idle = true
    if key == "p2_quit":
      if idle: emit_signal("hold_action", -2)

func get_pressed_action(e):
  for key in KEYMAP:
    if e.is_action_pressed(key):
      print(key)
      return KEYMAP[key]



# --
