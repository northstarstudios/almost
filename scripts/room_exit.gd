extends Area2D

@export_file("*.tscn") var destination_scene: String

var is_changing_room := false

func _on_body_entered(body: Node2D) -> void:
	if is_changing_room or not body is CharacterBody2D:
		return

	is_changing_room = true
	get_tree().change_scene_to_file(destination_scene)
