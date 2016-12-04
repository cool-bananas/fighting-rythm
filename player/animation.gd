
extends AnimationPlayer

func _on_change_state( st ):
	if has_animation(st):
		stop(true)
		play(st)
