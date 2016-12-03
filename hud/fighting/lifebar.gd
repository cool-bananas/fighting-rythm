
extends Polygon2D

onready var bar = get_node("bar")
onready var database = get_node("/root/database")

var chara
var polygon = [
  Vector2(0, 0),
  Vector2(236, 0),
  Vector2(244, 24),
  Vector2(8, 24),
]

func load_health(character):
  var chars = database.get_node("chars")
  chara = chars.get_node(character)
  set_process(true)

func _process(delta):
  var health = chara.get_hp()
  var current = chara.get_hp()
  polygon[1].x = 244 * current / health
  polygon[2].x = 252 * current / health
  set_polygon(polygon)
