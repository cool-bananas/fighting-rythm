
extends Sprite

onready var animation = get_node("animation")

func _on_change_state(st):
	if animation.has_animation(st):
		animation.stop(true)
		animation.play(st)
