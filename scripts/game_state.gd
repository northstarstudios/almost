extends Node

var loop_count := 0

func complete_reset() -> void:
	loop_count += 1
	get_tree().reload_current_scene()
