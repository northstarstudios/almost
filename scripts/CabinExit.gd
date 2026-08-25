extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		change_to_next_scene()
		
func change_to_next_scene():
	print("test")
	get_tree().change_scene_to_file("res://scenes/rooms/test-room/test_room.tscn")
