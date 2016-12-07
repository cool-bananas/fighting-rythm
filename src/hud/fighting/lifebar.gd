
extends Polygon2D

onready var bar = get_node("bar")
onready var tween = get_node("tween")
onready var name = get_node("name")

var chara
var polygon = [
  Vector2(0, 0),
  Vector2(236, 0),
  Vector2(244, 24),
  Vector2(8, 24),
]
var last_percentage = 1.0

func load_character(character):
  chara = character
  get_node("name").set_text(chara.get_name())
  chara.connect("life_change", self, "_on_life_change")

func _on_life_change():
  var health = 1.0 * chara.get_hp()
  var current = 1.0 * chara.get_current_hp()
  if current > 0:
    change_life(current / health)
  else:
    bar.hide()
  last_percentage = current / health

func change_life(percentage):
  print(last_percentage, " -> ", percentage)
  if last_percentage != percentage:
    print("update lifebar!")
    tween.interpolate_method(self, "rawset_bar", last_percentage, percentage, .5, Tween.TRANS_EXPO, Tween.EASE_OUT)
    tween.start()

func rawset_bar(percentage):
  polygon[1] = Vector2(236 * percentage, 0)
  polygon[2] = Vector2(236 * percentage + 8, 24)
  bar.set_polygon(polygon)
