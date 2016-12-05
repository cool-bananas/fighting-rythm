
extends Polygon2D

signal fade_start ()
signal fade_middle ()
signal fade_end ()

var tween = Tween.new()

func _ready():
  add_child(tween)

func start(secs):
  tween.interpolate_method(self, "set_opacity", 0, 1, secs / 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  emit_signal("fade_start")
  yield(tween, "tween_complete")
  emit_signal("fade_middle")
  fade_in(secs / 2)

func fade_in(secs):
  tween.interpolate_method(self, "set_opacity", 1, 0, secs, Tween.TRANS_LINEAR, Tween.EASE_IN)
  tween.start()
  yield(tween, "tween_complete")
  emit_signal("fade_end")

func set_opacity(opacity):
  set_color(Color(32/255, 32/255, 32/255, opacity))
