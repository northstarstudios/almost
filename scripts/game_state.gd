extends Node

var loop_count := 0

func reset_current_room() -> void:
	loop_count += 1
	get_tree().reload_current_scene()
